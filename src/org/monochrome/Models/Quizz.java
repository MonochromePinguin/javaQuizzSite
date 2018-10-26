package org.monochrome.Models;

import java.util.List;
import java.util.Map;

//PUBLIC FIELDS: BAD PRACTICE, BUT EASY FOR THESE SIMPLE OBJECTS
public class Quizz {
    public long quizzId;
    public String name;
    public String slug;
    public Theme theme;
    public long teacherId;
    public boolean isMcq;
    public boolean isRandom;
    public int nbQuestions;

    public List<Question> questionList;


    public Quizz() {}

    public Quizz(
            long quizzId,
            String name,
            String slug,
            Theme theme,
            long teacherId,
            boolean isMcq,
            boolean isRandom,
            int nbQuestions,
            List<Question> questionList
    ) {
        this.quizzId = quizzId;
        this.name = name;
        this.slug = slug;
        this.theme = theme;
        this.teacherId = teacherId;
        this.isMcq = isMcq;
        this.isRandom = isRandom;
        this.nbQuestions = nbQuestions;
        this.questionList = questionList;
    }


    //GETTERS ARE NEEDED BY THE JSP PART!
    //
    public long getQuizzId() {
        return quizzId;
    }

    public String getName() {
        return name;
    }

    public String getSlug() {
        return slug;
    }

    public Theme getTheme() {
        return theme;
    }

    public long getTeacherId() {
        return teacherId;
    }

    public boolean isMcq() {
        return isMcq;
    }

    public boolean isRandom() {
        return isRandom;
    }

    public int getNbQuestions() {
        return nbQuestions;
    }

    public List<Question> getQuestionList() { return questionList; }
}
