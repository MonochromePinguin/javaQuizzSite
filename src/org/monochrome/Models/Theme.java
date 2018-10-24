package org.monochrome.Models;

/* This POJO represent a quizz theme and its related quizzes */

import org.monochrome.Models.Quizz;

import java.util.HashMap;
import java.util.Map;

//PUBLIC FIELDS: BAD PRACTICE, BUT EASY FOR THESE SIMPLE OBJECTS
public class Theme {

    public long themeId;
    public String name;
    public String description;

    //TODO: replace this, OR add to this, a Map<Long, Quizz>
    public Quizz quizzList[];

    public Theme() {
        this.themeId = 0;
        this.name =
        this.description = null;
        this.quizzList = null;
    }

    public Theme(long themeId, String name, String description, Quizz quizzList[] ) {
        this.themeId = themeId;
        this.name = name;
        this.description = description;

        this.quizzList = quizzList;
    }
}
