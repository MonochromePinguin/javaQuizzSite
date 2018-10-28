package org.monochrome.services;

/* class send back by Corrector.correctResponses() to give back (or not) detailed data about the correction */

import org.monochrome.models.Answer;
import org.monochrome.models.Question;

import java.util.Map;

public class CorrectorResult {
    //has the copy given at least CorrectorService.winMinPercentage% good answers?
    public boolean passed;
    public int successPercentage; //percentage of rightly-answered questions

    // each Question object is mapped to a boolean telling the correctness of the response given in the POST data
    public Map<Question, Boolean> questionsCorrectness;

    //same thing for the answers
    public Map<Answer, Boolean> answersCorrectess;
}
