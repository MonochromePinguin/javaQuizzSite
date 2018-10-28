package org.monochrome.services;

import org.monochrome.models.Answer;
import org.monochrome.models.Question;
import org.monochrome.models.Quizz;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

public class CorrectorService {
    //minimum percentage of rightly-answered questions for a quizz to be considered "passed"
    public static final int winMinPercentage = 75;


    /***
     * this method test the correctness of returned answers present in the POST request given as parameter.
     * if an incoherency is detected in the given quizz, the function returns null.
     *
     * @param needDetailedInfos     if true, the maps questionsCorrectness and answersCorrectess are filled,
     *                                  either they're set to null.
     * @return CorrectorResult,
     *          or null if the quizz can't be corrected:
     *             the quizz has no related Question object, a Question object has no related Answer object,
     *              a question is not MCQ.
     */
    public static CorrectorResult correctMcqResponses(Quizz quizz, HttpServletRequest request, boolean needDetailedInfos)
    {
        CorrectorResult result = new CorrectorResult();
        int nbCorrectlyAnsweredQuestion = 0;

        // incoherencies should not pass!
        if (   quizz.questionList == null || quizz.questionList.size() == 0
            //↓ this code cannot correct free-text answers!
            || quizz.nbFreeTextQuestions > 0
            //↓ incoherency: less questions in the quizz than asked
            || (quizz.isRandom && (quizz.nbMcqQuestions + quizz.nbFreeTextQuestions) < quizz.nbQuestions)
        ) {
            return null;
        }

        if (needDetailedInfos) {
            result.questionsCorrectness = new HashMap<>();
            result.answersCorrectess = new HashMap<>();
        } else {
            result.questionsCorrectness = null;
            result.answersCorrectess = null;
        }

        for (Question question: quizz.questionList) {
            boolean questionCorrectlyAnswered = true;

            if ( !question.isMCQ || question.answerList == null || question.answerList.size() == 0) {
                //there is a bug! We can't correct this quizz decently. Just return null
                return null;
            }


            for (Answer answer: question.answerList) {
                /*if this Answer object is a good answer, its checkbox's value must be present in the POST data,
                 but if the object represents a bad answer, its checkbox should be left unchecked,
                 and thus NOT appear in the data.
                 We don't need to check the returned value, only that it is present.
                */
                String presenceMarker = request.getParameter(Long.toString(answer.answerId));

                if ((answer.isCorrect && presenceMarker != null)
                        || (!answer.isCorrect && presenceMarker == null)) {
                    //good.
                    if (needDetailedInfos) {
                        result.answersCorrectess.put(answer, true);
                    }
                } else {
                    //bad.
                    if (needDetailedInfos) {
                        result.answersCorrectess.put(answer, false);
                    }
                    questionCorrectlyAnswered = false;
                }
            }

            //now the answers are all parsed,
            // set the Question state
            if (questionCorrectlyAnswered) {
                ++nbCorrectlyAnsweredQuestion;
            }
            if (needDetailedInfos) {
                result.questionsCorrectness.put(question, questionCorrectlyAnswered);
            } //end of "for answer of question.answerList"

        } //end of "for question of quizz.questionList"

        result.successPercentage = nbCorrectlyAnsweredQuestion * 100 / quizz.nbQuestions;
        result.passed =  result.successPercentage >= winMinPercentage;
        return result;
    }

}
