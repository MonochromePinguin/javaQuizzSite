package org.monochrome.services;

import org.monochrome.persistence.QuizzDataSource;
import org.monochrome.persistence.StorageBackend;
import org.monochrome.persistence.ThemeDataSource;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
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
    private static ThemeDataSource themeSource = null;
    private static QuizzDataSource quizzSource = null;


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


    public static ThemeDataSource getThemeDataSource() {
        if (themeSource == null) {
            themeSource = new ThemeDataSource(Factory.getStorageBackend(), Factory.getQuizzDataSource());
        }
        return themeSource;
    }


    public static QuizzDataSource getQuizzDataSource() {
        if (quizzSource == null) {
            quizzSource = new QuizzDataSource(Factory.getStorageBackend());
        }
        return quizzSource;
    }

}
