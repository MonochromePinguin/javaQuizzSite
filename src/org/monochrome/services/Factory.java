package org.monochrome.services;

import org.monochrome.persistence.*;

import java.sql.SQLException;
import java.util.logging.Level;

/* this class is menat to be a really naive implementation of the factory pattern –
 at least, it centralize several classes retrievement and settings. these classes are practically singletons
 */
public final class Factory {

    //TODO: for ease of deployment, these data should be taken from a .properties
    private static final String serverUrl = "jdbc:mysql://localhost/";
    private static final String urlSuffix = "?useUnicode=true&useSSL=false&serverTimezone=UTC";
    private static final String database = "quizzdb";
    private static final String username = "quizzUser";
    private static final String password = "quizzeur";


    private static StorageBackend storage = null;
    private static ThemeRepository themeSource = null;
    private static QuizzRepository quizzSource = null;
    private static QuestionRepository questionSource = null;
    private static AnswerRepository answerSource = null;


    public static StorageBackend getStorageBackend() {
        if (storage == null) {
            try {
                storage = new StorageBackend(serverUrl, database, urlSuffix, username, password);

            } catch (SQLException | ClassNotFoundException e) {
                SingleLogger.logger.severe("Cannot Connect to the database:\n");
                SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            }
        }
        return storage;
    }


    public static ThemeRepository getThemeRepository() {
        if (themeSource == null) {
            themeSource = new ThemeRepository(Factory.getStorageBackend(), Factory.getQuizzRepository());
        }
        return themeSource;
    }


    public static QuizzRepository getQuizzRepository() {
        if (quizzSource == null) {
            quizzSource = new QuizzRepository(Factory.getStorageBackend(), Factory.getQuestionRepository());
        }
        return quizzSource;
    }


    public static QuestionRepository getQuestionRepository() {
        if (questionSource == null) {
            questionSource = new QuestionRepository(Factory.getStorageBackend(), Factory.getAnswerRepository());
        }
        return questionSource;
    }


    public static AnswerRepository getAnswerRepository() {
        if (answerSource == null) {
            answerSource = new AnswerRepository(Factory.getStorageBackend());
        }
        return answerSource;
    }

}
