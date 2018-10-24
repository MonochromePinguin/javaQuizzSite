package org.monochrome.servlets;

/* quizz lists, sorted by categories servlet */

import org.monochrome.Models.Quizz;
import org.monochrome.Models.Theme;
import org.monochrome.services.CorrectorService;
import org.monochrome.services.Factory;
import org.monochrome.services.SingleLogger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet
public class EntryQuizzServlet extends HttpServlet {

    private Theme[] themeList;

    @Override
    public void init(){
        SingleLogger.logger.info("● EntryQuizzServlet.init() called");

/*
        //TODO: replace this test with a real DB access
        Quizz quizzList1[] = {
                new Quizz(1, "MCQ, Qquizz 1 – blablabla ... Bla !", "quizz-1-blablabla",
                        1, 1, true, false, 0),
                new Quizz(2, "MCQ, quizz 2 – about nothing!", "quizz-2-nothing",
                        1, 2, true, false, 0)
        },
            quizzList2[] = {
                    new Quizz(3, "MCQ, third quizz...", "third-quizz",
                            2, 3, true, false, 0)
        },
            quizzList3[] = {
                new Quizz(4, "MCQ #4", "mcq-4",
                3, 1, true, false, 0)
        };

        themeList = new Theme[] {
                new Theme(1, "theme1", "theme description", quizzList1 ),
                new Theme(2, "empty theme!", "nothing inside this theme. Not Worth of.", null ),
                new Theme(3, "theme #2", "theme #2 description", quizzList2 ),
                new Theme(4, "theme #2½ – sfmlsjfslej", "theme #3 description – blablabla", quizzList3 )
        };
*/

        themeList = Factory.getThemeDataSource().getThemesAndQuizzes(true, true, false);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("pageTitle", "quizzSchool – entry quizz selection");
        request.setAttribute("title", "Entrance test lists" );
        request.setAttribute("subtitle", "ordered by theme" );

        request.setAttribute("aboutTitle", "Please Select the quizz with wich you wanna have your exam.");
        request.setAttribute(
                "rawAboutText",
                ("<p>As a candidate, you'll have to choose amongst some MCQ.</p>\n" +
                 "<p>\n" +
                       "<span class=\"about-em\">Reminder:</span> you must have at least <span class=\"about-em\">")
                    .concat("" + CorrectorService.winMinPercentage)
                    .concat("%</span> of correctly-answered questions to pass the quizz.</p>" +
                            "<p><span class=\"about-em\">Good luck!</p>")
        );

        request.setAttribute("themeList", themeList);

        request.getRequestDispatcher("/WEB-INF/views/quizzList.jsp").forward(request, response);
    }
}
