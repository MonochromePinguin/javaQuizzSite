package org.monochrome.persistence;

import org.monochrome.models.Question;
import org.monochrome.models.Quizz;
import org.monochrome.services.SingleLogger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

public class QuestionRepository {

    private static final String table = "questions";

    private final StorageBackend storage;
    private final AnswerRepository answerSource;


    private static final String queryForQuizz =  "SELECT * FROM " + QuestionRepository.table
            + " t JOIN inter_questions_quizzes i ON t.questionId = i.questionId"
            + " JOIN quizzes q ON i.quizzId = q.quizzId WHERE q.quizzId = ?";

    public static final String queryForRandomQuizz = "SELECT * FROM " + QuestionRepository.table
            + " WHERE themeId = ?  ORDER BY RAND() LIMIT ?";



    public QuestionRepository(StorageBackend storage, AnswerRepository answerRepository)
    {
        this.storage = storage;
        this.answerSource = answerRepository;
    }


    public Question getQuestionById(long id, boolean withAnswers) {

        try {
            PreparedStatement statement = storage.getPreparedStatement(
                    "SELECT * FROM " + QuestionRepository.table + "  WHERE questionId = ?"
            );
            statement.setLong(1, id);
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            return buildQuestion(rs, withAnswers);

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a question from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }


    // HELPER FUNCTION – build a Question from data extracted *from the 1st row* of the ResultSet
    protected Question buildQuestion(ResultSet rs, boolean withAnswers) {
        Question question;

        try {
            //there is at most one row returned...
            if (!rs.next()) {
                return null;
            }

            Long questionId = rs.getLong("questionId");

            question = new Question(
                    questionId,
                    rs.getString("label"),
                    rs.getBoolean("isMcq"),
                    withAnswers ?
                            this.answerSource.getAnswersByQuestionId(questionId)
                            :  null
            );
            return question;

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a quizz from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }


    /***
     * Retrieves questions related to a quizz, and stuff these questions with related data, inside it. Two cases:
     * _ quizzes with a specific set of questions,
     * _ and quizzes randomly built from n questions taken from the pool of all questions having same same themeId than
     *     the quizz.
     * MODIFY theses fields:
     *  hasProblem, nbQuestions (if !isRandom), nbMcqQuestions, nbFreeTextQuestions, questionList.
     *
     * @param quizz                     the quizz to receive the questionList and related data
     * @param withAnswers               must we load answers too?
     */
    //TODO: this is BAD. there is thight coupling with the Quizz class... But it is soooo convenient here not to return
    //TODO: a class holding all data.
    public void stuffQuestionListAndDataInsideQuizz(Quizz quizz, boolean withAnswers ) {
        List<Question> result = new ArrayList<>(4);
        PreparedStatement statement;

        //these fields gather informations for checking/display
        int nbMcqQuestion = 0,
            nbFreeTextQuestions = 0;

        try {
            statement = this.storage.getPreparedStatement(
                quizz.isRandom ?  queryForRandomQuizz  :  queryForQuizz
            );

            if (!quizz.isRandom) {
                //get questions related to this quizz.
                statement.setLong(1, quizz.quizzId);
            } else {
                // for randomly-generated quizzes: get quizz.nbQuestions from the pool of all questions having
                // the same themeId as the quizz.
                statement.setLong(1, quizz.theme.themeId);
                statement.setInt(2, quizz.nbQuestions );
            }

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {

                Long questionId = rs.getLong("questionId");
                boolean isMCQ = rs.getBoolean("isMCQ");

                //TODO: get columns number at class instanciation, then reuse these numbers instead of strings :
                //TODO:    should'nt this be more efficient?
                Question question = new Question(
                        questionId,
                        rs.getString("label"),
                        rs.getBoolean("isMCQ"),
                        // non-isMCQ / «free-text answer» questions have no associated Questions:
                        withAnswers && isMCQ ?
                                this.answerSource.getAnswersByQuestionId(questionId) : null
                );
                result.add(question);

                //information gathering
                if (question.isMCQ) {
                    ++nbMcqQuestion;
                } else{
                    ++nbFreeTextQuestions;
                }

                if  (withAnswers && isMCQ && question.answerList == null || question.answerList.size() == 0 ) {
                    quizz.hasProblem = true;
                }
            }

            //feed back data into the quizz
            quizz.nbMcqQuestions = nbMcqQuestion;
            quizz.nbFreeTextQuestions = nbFreeTextQuestions;

            if (!quizz.isRandom) {
                // set the retrieved question count.
                quizz.nbQuestions = quizz.nbMcqQuestions + quizz.nbFreeTextQuestions;
            }
            //randomly-build quizz: verify there is the right count of questions to send back.
            else if (quizz.nbQuestions != quizz.questionList.size()) {
                //quizz.nbQuestions is left unchanged, because it told us how many questions to load.
                quizz.hasProblem = true;
            }

            if (result.size() > 0) {
                quizz.questionList = result;
            } else {
                quizz.hasProblem = true;
                quizz.questionList = null;
            }

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a question list from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            quizz.questionList = null;
        }
    }

}
