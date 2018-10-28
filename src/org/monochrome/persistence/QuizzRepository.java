package org.monochrome.persistence;

import org.monochrome.models.Quizz;
import org.monochrome.models.Theme;
import org.monochrome.services.Factory;
import org.monochrome.services.SingleLogger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

public class QuizzRepository {

    private static final String table = "quizzes";

    private final StorageBackend storage;
    private final QuestionRepository questionSource;

    private static final String requestQuizzesByThemeId = "SELECT * FROM " + QuizzRepository.table + " WHERE themeId = ?";


    public QuizzRepository(StorageBackend storage, QuestionRepository questionRepository)
    {
        this.storage = storage;
        this.questionSource = questionRepository;
    }



    public Quizz getQuizzById(long id, boolean withFullData, boolean withQuestionsAndAnswers) {

        try {
            PreparedStatement statement = storage.getPreparedStatement(
                    "SELECT * FROM " + QuizzRepository.table + " WHERE quizzId = ?"
            );
            statement.setLong(1, id);
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            return buildQuizz(rs, withFullData, withQuestionsAndAnswers);

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a quizz from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }


    public Quizz getQuizzBySlug(String slug, boolean withFullData, boolean withQuestionsAndAnswers) {
        //remember: prepared statements are immune to SQL injection...
        try {
            PreparedStatement statement = storage.getPreparedStatement(
                    "SELECT * FROM " + QuizzRepository.table + " WHERE slug like ?"
            );
            statement.setString(1, slug);
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            return buildQuizz(rs, withFullData, withQuestionsAndAnswers);

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a quizz from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }


    /**
     *  HELPER FUNCTION – build a Quizz from data extracted *from the 1st row* of the ResultSet
     * @param rs                            the ResultSet filled by the calling method
     * @param withFullData                  do we need to stuff object' fields with all rows data?
     *                                        theme, teacherId, nbQuestions are affected by this boolean
     * @param withQuestionsAndAnswers       do we need to include full Question list?
     * @return Quizz or null
     */
    protected Quizz buildQuizz(ResultSet rs, boolean withFullData, boolean withQuestionsAndAnswers) {
        Quizz quizz;

        try {
            //there is at most one row returned...
            if (!rs.next()) {
                return null;
            }

            quizz = new Quizz();

            quizz.quizzId = rs.getLong("quizzId");
            quizz.name = rs.getString("name");
            quizz.slug = withFullData ? rs.getString("slug")  :  null;
            quizz.theme = withFullData ?
                    Factory.getThemeRepository().getThemeById(rs.getLong("themeId"), false )
                    : null;
            quizz.isMcq = rs.getBoolean("isMcq");
            quizz.isRandom = rs.getBoolean("isRandom");
            quizz.teacherId = withFullData ? rs.getLong("teacherId") : 0;
            quizz.nbQuestions = (withFullData || (withQuestionsAndAnswers && quizz.isRandom)) ?
                                    rs.getInt("nbQuestions") : 0;
            if (withQuestionsAndAnswers) {
                this.questionSource.stuffQuestionListAndDataInsideQuizz(quizz, true);
            } else {
                quizz.nbMcqQuestions =
                quizz.nbFreeTextQuestions = 0;
                quizz.questionList = null;
            }

            if (withFullData && !quizz.isRandom && quizz.questionList != null) {
                quizz.nbQuestions = quizz.questionList.size();
            }
            return quizz;

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a quizz from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }



    public Quizz[] getQuizzesByTheme(Theme theme, boolean acceptOnlyMCQ, boolean acceptRandomQuizzes) {
        Quizz[] result;

        try {
            PreparedStatement statement = storage.getPreparedStatement(
                QuizzRepository.requestQuizzesByThemeId
                        + ( acceptOnlyMCQ ? " AND isMCQ = 1"  :  "" )
                        + ( acceptRandomQuizzes ? "" : " AND isRandom = 0" )
            );

            statement.setLong(1, theme.themeId );
            statement.executeQuery();

            //now, parse the result
            //
            ResultSet rs = statement.getResultSet();
            int nbRows;

            //TODO: is'nt it weird and inefficient? should I REALLY build an arrayList, and then an array?
            //count the number of rows returned into the ResultSet
            rs.last();
            nbRows = rs.getRow();
            rs.beforeFirst();

            result = new Quizz[nbRows];
            nbRows = 0;

            while (rs.next()) {
                Quizz quizz = new Quizz();

                //TODO: get columns number at class instanciation, then reuse these numbers instead of strings :
                //TODO:    should'nt this be more efficient?
                quizz.quizzId = rs.getLong("quizzId");
                quizz.name = rs.getString("name");
                quizz.slug = rs.getString("slug");
                quizz.theme = theme;
                quizz.teacherId = rs.getLong("teacherId");
                quizz.isMcq = rs.getBoolean("isMCQ");
                quizz.isRandom = rs.getBoolean("isRandom");
                quizz.nbQuestions = rs.getInt("nbQuestions");

                result[nbRows++] = quizz;
            }

            return result;

        } catch (SQLException e ) {
            SingleLogger.logger.severe("Impossible to read Theme data from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }

}
