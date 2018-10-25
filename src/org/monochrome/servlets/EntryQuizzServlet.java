package org.monochrome.servlets;

/* quizz lists, sorted by categories servlet */

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

@WebServlet
public class EntryQuizzServlet extends HttpServlet {

    private Theme[] themeList;

    @Override
    public void init(){
        SingleLogger.logger.info("● EntryQuizzServlet.init() called");
        themeList = Factory.getThemeRepository().getThemesAndQuizzes(false, true, true);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("pageTitle", "quizzSchool – entry quizz selection");
        request.setAttribute("title", "Entrance test lists" );
        request.setAttribute("subtitle", "ordered by theme" );

        request.setAttribute("aboutTitle", "Please Select the quizz with wich you wanna have your exam.");
        request.setAttribute(
                "rawAboutText",
                ("<p>As a candidate, you have access to MCQ quizzes.</p>\n" +
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
