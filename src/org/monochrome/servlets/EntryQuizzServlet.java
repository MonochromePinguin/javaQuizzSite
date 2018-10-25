package org.monochrome.servlets;

/*
Servlet handling two cases:
    _ entry test selection – quizz list, sorted by categories servlet amongst which the candidate must choose.
    _ entry test page – one of these quizzes.

These quizzes must be accessible to candidates : they are only accessible through this path if they correspond to the
 constnat criterias defined in top of the class.

handled sub-URL:
    /(\d+)      →   route to a quizz by its quizzId
    /(\S+)       →   route to a quizz by its slug

themes and related quizzes are *cached* in a private property to avoid excessive DB accesses, but this lead to a ...
TODO: create a mechanism of data discarding when the DB is updated through our app, and/or at periodic interval

*/


import com.mysql.cj.util.StringUtils;
import org.monochrome.Models.Quizz;
import org.monochrome.Models.Theme;
import org.monochrome.persistence.QuizzRepository;
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

    private QuizzRepository quizzRepository;

    private Theme[] themeList;

    // these combined boolean decide together wich kind of quizzes are accessible to candidates
    private static final boolean ACCEPT_ONLY_MCQ = true;
    public static final boolean ACCEPT_RANDOM_QUIZZES = false;


    @Override
    public void init(){
        SingleLogger.logger.info("● EntryQuizzServlet.init() called");

        this.quizzRepository = Factory.getQuizzRepository();
        this.themeList =  Factory.getThemeRepository().getThemesAndQuizzes(false, ACCEPT_ONLY_MCQ, ACCEPT_RANDOM_QUIZZES);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        //get the URL part AFTER the part attribued to the servlet (eg http://host/servletName/lastPart → « /lastPart »)
        String quizzPattern = request.getPathInfo();
        Quizz quizz;

        if (quizzPattern == null) {
            this.showEntryQuizzSelectionPage(request, response);
            return;
        }

        quizzPattern = quizzPattern.substring(1);

        //is this a route to a Quizz by its quizzId?
        if (StringUtils.isStrictlyNumeric(quizzPattern)) {
            try {
                long quizzId = Long.parseLong(quizzPattern);
                quizz = this.quizzRepository.getQuizzById(quizzId, true, true);

                //quizz found by id
                if (quizz != null) {
                    this.showQuizzPage(request, response, quizz);
                    return;
                }

            } catch (NumberFormatException e) {}    //do nothing in case of conversion error, just go to the next step

        }

        //is this a route to a quizz by its slug?
        quizz = this.quizzRepository.getQuizzBySlug(quizzPattern, true, true);
        if (quizz != null) {
            this.showQuizzPage(request, response, quizz );
            return;
        }

        //no quizz found – redirect to the 404 page
        response.sendRedirect("/page-not-found");
    }



    protected void showEntryQuizzSelectionPage(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        request.setAttribute("pageTitle", "quizzSchool – entry quizz selection");
        request.setAttribute("title", "Entrance test lists" );
        request.setAttribute("subtitle", "ordered by theme" );

        request.setAttribute("aboutTitle", "Please Select the quizz with wich you wanna have your exam.");
        request.setAttribute(
                "rawAboutText",
                ("<p>As a candidate, your access is restricted to MCQ quizzes.</p>\n" +
                 "<p>\n" +
                       "<span class=\"about-em\">Reminder:</span> you must have at least <span class=\"about-em\">")
                    .concat("" + CorrectorService.winMinPercentage)
                    .concat("%</span> of correctly-answered questions to pass the quizz.</p>" +
                            "<p><span class=\"about-em\">Good luck!</p>")
        );

        request.setAttribute("themeList", themeList);

        request.getRequestDispatcher("/WEB-INF/views/quizzList.jsp").forward(request, response);
    }


    protected void showQuizzPage(HttpServletRequest request, HttpServletResponse response, Quizz quizz)
        throws ServletException, IOException
    {
        request.setAttribute("pageTitle", "quizzSchool – entry test");
        request.setAttribute("title", quizz.name );
        if (quizz.theme != null) {
            request.setAttribute("subtitle", quizz.theme.name );
        }

        request.setAttribute(
                "aboutTitle",
                ("Here you are. You must have at least " + CorrectorService.winMinPercentage)
                    .concat("% of good answers to pass your exam.")
        );
        request.setAttribute(
                "rawAboutText",
                ("" + quizz.nbQuestions).concat(" questions. Undefined time to answer them.\n<br>\n" +
                        "                           <span class=\"about-em\">Good Luck!</span>")
        );


        request.setAttribute("questionList", quizz.questionList);

        request.getRequestDispatcher("/WEB-INF/views/quizz.jsp").forward(request, response);
    }

}
