package org.monochrome.Models;

public class Question {
    public long questionId;
    public String label;
    public boolean isMCQ;


    public Question() {}

    public Question(long questionId, String label, boolean isMCQ) {
        this.questionId = questionId;
        this.label = label;
        this.isMCQ = isMCQ;
    }
}
