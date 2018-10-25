package org.monochrome.persistence;

import org.monochrome.Models.Quizz;
import org.monochrome.services.SingleLogger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

public class QuizzRepository {

    private static final String table = "quizzes";

    private final StorageBackend storage;

    public QuizzRepository(StorageBackend storage) {
        this.storage = storage;
    }


    public Quizz[] getQuizzesByThemeId(long themeId, boolean acceptOnlyMCQ, boolean acceptRandomQuizzes) {
        Quizz[] result;

        try {
            PreparedStatement statement = storage.getPreparedStatement(
                    "SELECT * FROM " + this.table + " WHERE isMCQ = ? AND isRandom = ? AND themeId = ?"
            );
            statement.setBoolean(1, acceptOnlyMCQ );
            statement.setBoolean(2, acceptRandomQuizzes );
            statement.setLong(3, themeId );

            statement.executeQuery();

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
                quizz.themeId = rs.getLong("themeId");
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
