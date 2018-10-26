package org.monochrome.Models;

public class Answer {
    public long answerId;
    public String label;
    public boolean isCorrect;

    public Answer() {}

    public Answer(long answerId, String label, boolean isCorrect) {
        this.answerId = answerId;
        this.label = label;
        this.isCorrect = isCorrect;
    }
}
