package org.monochrome.persistence;

import org.monochrome.Models.Theme;
import org.monochrome.services.SingleLogger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.logging.Level;

public class ThemeDataSource {

    private static final String table = "themes";

    private final StorageBackend storage;
    private final QuizzDataSource quizzSource;

    public ThemeDataSource(StorageBackend storage, QuizzDataSource quizzSource) {
        this.storage = storage;
        this.quizzSource = quizzSource;
    }


    /***
     * return an array of Theme, each one containing a quizz[] property
     *
     * @param acceptEmptyThemes     will themes with no related quizz be shown?
     * @param onlyMCQ              will non-MCQ quizzes be shown?
     * @param acceptRandomQuizzes   will randomly-generated quizzes be shown?
     * @return Theme[]
     */
    public Theme[] getThemesAndQuizzes(boolean acceptEmptyThemes, boolean onlyMCQ, boolean acceptRandomQuizzes) {
        Theme[] result;

        try {
            ResultSet rs = this.storage.executeQuery("SELECT * FROM " + this.table);

            //TODO: is'nt it weird and inneficient ? should I REALLY build an arrayList, and then an array?
            //count the number of rows returned into the ResultSet
            rs.last();
            int nbRows = rs.getRow();
            rs.beforeFirst();

            result = new Theme[nbRows];
            nbRows = 0;

            while (rs.next()) {
                Theme theme = new Theme();

                theme.themeId = rs.getLong("themeId");
                theme.name = rs.getString("name");
                theme.description = rs.getString("description");
                theme.quizzList = this.quizzSource.getQuizzesByThemeId(theme.themeId, onlyMCQ, acceptRandomQuizzes);

                result[nbRows++] = theme;
            }

            return result;

        } catch (SQLException e ) {
            SingleLogger.logger.severe("Impossible to read Theme data from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }

}
