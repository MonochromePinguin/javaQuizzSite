package org.monochrome.persistence;

import org.monochrome.Models.Answer;
import org.monochrome.services.SingleLogger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

public class AnswerRepository {
    private static final String table = "answers";

    private final StorageBackend storage;

    public AnswerRepository(StorageBackend storage) {
        this.storage = storage;
    }


    public List<Answer> getAnswersByQuestionId(long id) {
        ArrayList<Answer> result = new ArrayList<>(4);

        try {
            PreparedStatement statement = storage.getPreparedStatement(
                    "SELECT * FROM " + AnswerRepository.table + " WHERE questionId = ?"
            );
            statement.setLong(1, id);
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            while (rs.next()) {
                Answer answer = new Answer(
                        //TODO: get columns number at class instanciation, then reuse these numbers instead of strings :
                        //TODO:    should'nt this be more efficient?
                        rs.getLong("answerId"),
                        rs.getString("label"),
                        rs.getBoolean("isCorrect")
                );
                result.add(answer);
            }

            return  result.size() > 0 ? result : null;

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to load a quizz from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }

}
