package org.monochrome.models;

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

    public long getAnswerId() {
        return answerId;
    }

    public String getLabel() {
        return label;
    }

    public boolean isCorrect() {
        return isCorrect;
    }
}
