package org.monochrome.persistence;

import org.monochrome.Models.Theme;
import org.monochrome.services.SingleLogger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.logging.Level;

public class ThemeRepository {

    private static final String table = "themes";

    private final StorageBackend storage;
    private final QuizzRepository quizzSource;

    // this is a cache for loaded themes
    //TODO: beware if the servlet scope is reduced to session or request !
    //TODO: verify it is worth, and it is worth only in case of a long-lasting servlet...
    ///TODO: add a mechanism to swipe the cache content when db is changed!
    //TODO: And to share this cache amonst servlets using same version of the whole-DB!
    private final Map<Long, Theme> themeCache;


    public ThemeRepository(StorageBackend storage, QuizzRepository quizzSource) {
        this.storage = storage;
        this.quizzSource = quizzSource;
        this.themeCache = new HashMap<>();
    }




    public Theme getThemeById(long id, boolean withQuizzList) {
        Theme theme;

        //first, look in the cache
        theme = this.themeCache.get(id);
        if (theme != null) {
            return theme;
        }

        //then, ask the DB
        try {
            PreparedStatement statement = this.storage.getPreparedStatement(
                    "SELECT * FROM " + this.table + " WHERE themeId = ?"
            );
            statement.setLong(1, id);

            ResultSet rs = statement.executeQuery();
            if (!rs.next()) {
                return null;
            }

            theme = new Theme(
                    rs.getLong("themeId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    withQuizzList ?
                        this.quizzSource.getQuizzesByTheme(theme, false, true )
                        :  null
            );

            this.themeCache.put(id, theme);

            return theme;

        } catch (SQLException e) {
            SingleLogger.logger.severe("Impossible to read Theme data from DB:");
            SingleLogger.logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
            return null;
        }
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
                theme.quizzList = this.quizzSource.getQuizzesByTheme(theme, onlyMCQ, acceptRandomQuizzes);

                //register the theme inside the cache any way
                this.themeCache.put(theme.themeId, theme);

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
