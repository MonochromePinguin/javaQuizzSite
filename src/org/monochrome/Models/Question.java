package org.monochrome.Models;

import java.util.List;

public class Question {
    public long questionId;
    public String label;
    public boolean isMCQ;

    public List<Answer> answerList;


    public Question() {}

    public Question(long questionId, String label, boolean isMCQ, List<Answer> answerList) {
        this.questionId = questionId;
        this.label = label;
        this.isMCQ = isMCQ;
        this.answerList = answerList;
    }


    public long getQuestionId() {
        return questionId;
    }

    public String getLabel() {
        return label;
    }

    public boolean isMCQ() {
        return isMCQ;
    }

    public List<Answer> getAnswerList() {
        return answerList;
    }
}
