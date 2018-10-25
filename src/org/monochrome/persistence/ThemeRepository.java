package org.monochrome.persistence;

import org.monochrome.Models.Theme;
import org.monochrome.services.SingleLogger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.logging.Level;

public class ThemeRepository {

    private static final String table = "themes";

    private final StorageBackend storage;
    private final QuizzRepository quizzSource;

    public ThemeRepository(StorageBackend storage, QuizzRepository quizzSource) {
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
        LinkedList<Theme> themeList = new LinkedList<>();

        try {
            ResultSet rs = this.storage.executeQuery("SELECT * FROM " + this.table);

            while (rs.next()) {
                Theme theme = new Theme();

                theme.themeId = rs.getLong("themeId");
                theme.name = rs.getString("name");
                theme.description = rs.getString("description");
                theme.quizzList = this.quizzSource.getQuizzesByThemeId(theme.themeId, onlyMCQ, acceptRandomQuizzes);

                if ( acceptEmptyThemes || ( theme.quizzList != null && theme.quizzList.length > 0 ) ) {
                    //do not enlist themes whith no related quizz
                    themeList.add(theme);
                }
            }
            return themeList.toArray(new Theme[]{} );

        } catch (SQLException e ) {
            SingleLogger.logger.severe("Impossible to read Theme data from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
    }

}
