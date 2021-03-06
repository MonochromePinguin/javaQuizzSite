package org.monochrome.models;

import java.time.LocalDateTime;
import java.util.List;

//PUBLIC FIELDS: BAD PRACTICE, BUT EASY FOR THESE SIMPLE OBJECTS
public class Quizz {
    public long quizzId;
    public String name;
    public String slug;
    public Theme theme;
    public long teacherId;
    public LocalDateTime lastEditUtc;   // ← must use UTC for interoperability.
    public boolean isMcq;       // ← does it contains only MCQ, or does it ALLOW questions with free-text answers?
    public boolean isRandom;    // ← is the quizz built randomly from a pool of questions ?
    public int nbQuestions;     // ← if !isRandom, this is a total count of question, UNRELATED TO DB CONTENT

    //fields non existent in DB:
    // they are here for information gathering and checking
    public boolean hasProblem;
    public int nbMcqQuestions;
    public int nbFreeTextQuestions;

    public List<Question> questionList;


    public Quizz() {}

    public Quizz(
            long quizzId,
            String name,
            String slug,
            Theme theme,
            long teacherId,
            LocalDateTime lastEditUtc,
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
        this.lastEditUtc = lastEditUtc;
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

    public LocalDateTime getLastEditUtc() {
        return lastEditUtc;
    }

    public void setLastEditUtc(LocalDateTime lastEditUtc) {
        this.lastEditUtc = lastEditUtc;
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

    public boolean getHasProblem() {return hasProblem; }

    public int getNbMcqQuestions() {
        return nbMcqQuestions;
    }

    public int getNbFreeTextQuestions() {
        return nbFreeTextQuestions;
    }

    public List<Question> getQuestionList() { return questionList; }
}
