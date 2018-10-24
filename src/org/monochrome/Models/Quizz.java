package org.monochrome.Models;

//PUBLIC FIELDS: BAD PRACTICE, BUT EASY FOR THESE SIMPLE OBJECTS
public class Quizz {
    public long quizzId;
    public String name;
    public String slug;
    public long themeId;
    public long teacherId;
    public boolean isMcq;
    public boolean isRandom;
    public int nbQuestions;

    public Quizz() {
        this.quizzId = 0;
        this.name = 
        this.slug = null;
        this.themeId =
        this.teacherId = 0;
        isMcq =
        isRandom = false;
        this.nbQuestions = 0;
    }

    public Quizz(long quizzId, String name, String slug, long themeId, long teacherId, boolean isMcq, boolean isRandom, int nbQuestions) {
        this.quizzId = quizzId;
        this.name = name;
        this.slug = slug;
        this.themeId = themeId;
        this.teacherId = teacherId;
        this.isMcq = isMcq;
        this.isRandom = isRandom;
        this.nbQuestions = nbQuestions;
    }
}
