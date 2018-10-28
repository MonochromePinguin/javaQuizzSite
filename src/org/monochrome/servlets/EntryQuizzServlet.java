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
import org.monochrome.models.Quizz;
import org.monochrome.models.Theme;
import org.monochrome.persistence.QuizzRepository;
import org.monochrome.services.CorrectorResult;
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



    /* Act as a dispatcher between showEntryQuizzSelectionPage() / showQuizzPage() methods :
        ${SERVLETPATH}/     →   showEntryQuizzSelectionPage
        ${SERVLETPATH}/\n+  →   show quizz page – quizz selected by id
        ${SERVLETPATH}/\a+  →   show quizz page – quizz seleted by slug
    */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        //get the URL part AFTER the part attribued to the servlet (eg http://host/servletName/lastPart → « /lastPart »)
        String quizzPattern = request.getPathInfo();
        Quizz quizz;

        if (quizzPattern == null) {
            this.showEntryQuizzSelectionPage(request, response);
            return;
        }

        //get the quizz corresponding to the given URL portion
        quizz = this.getQuizzForSubpath(quizzPattern.substring(1));

        if (quizz != null) {
            this.showQuizzPage(request, response, quizz);
            return;
        }

        //no quizz found – redirect to the 404 page
        response.sendRedirect("/page-not-found");
    }



    /** handle POST to quizz-associed URL (by id or by slug) :
     * _ if pure-MCQ quizz (quizz.nbFreeTextQuestion == 0), correct it automatically by calling CorrectorService.correct()
     * _ if the quizz contains free-answer questions, store all questions into the DB for future correction
          by a teacher
     **/
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get the URL part AFTER the part attribued to the servlet (eg http://host/servletName/lastPart → « /lastPart »)
        String quizzPattern = request.getPathInfo();
        Quizz quizz;

        //get the quizz corresponding to the given URL portion
        quizz = getQuizzForSubpath(quizzPattern.substring(1));

        if (quizz == null) {
            // empty subpath, bad URL or no quizz found – redirect to the 404 page
            response.sendRedirect("/page-not-found");
        }

        if (quizz.isMcq || quizz.nbFreeTextQuestions == 0) {
            CorrectorResult correctionResult = CorrectorService.correctMcqResponses(quizz, request, false);

            //null returned: the asked quizz has incoherency inside!
            if (correctionResult == null) {
                this.showQuizzIncoherencyPage(request, response, quizz);
            }

            if (correctionResult.passed) {
                this.showCongratulationPage(request, response, quizz, correctionResult);
            } else {
                this.showQuizzNotPassedPage(request, response, quizz, correctionResult);
            }
        }
    }



    /** return the Quizz associated to the given subpath, either a numeric id, or an alphanumeric slug.
     *      slugs cannot be full-numeric.
     * @return Quizz, or null if none found
     */
    protected Quizz getQuizzForSubpath(String subpath) {
        Quizz quizz = null;

        //is this subpath a route to a Quizz by its quizzId?
        if (StringUtils.isStrictlyNumeric(subpath)) {
            try {
                long quizzId = Long.parseLong(subpath);
                quizz = this.quizzRepository.getQuizzById(quizzId, true, true);

            } catch (NumberFormatException e) {
                //do nothing in case of conversion error, just return null
                return null;
            }

        } else {

            //is this a route to a quizz by its slug?
            quizz = this.quizzRepository.getQuizzBySlug(subpath, true, true);
        }

        return quizz;
    }



    /* show the list of quizzes accessibles for the entry test.
     This list in influenced by the two constants ACCEPT_ONLY_MCQ and ACCEPT_RANDOM_QUIZZES given as parameters to
      getThemesAndQuizzes() inside init().
     */
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



    /* show a single quizz in its page */
    //
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
                ("" + quizz.nbMcqQuestions).concat(" checkbox questions, ")
                .concat("" + quizz.nbFreeTextQuestions)
                .concat(" free answer questions. Undefined time to answer them.\n<br>\n" +
                        "<span class=\"about-em\">Good Luck!</span>")
        );

        request.setAttribute("quizz", quizz);

        request.setAttribute("destinationUrl", getServletContext().getContextPath());

        request.setAttribute("showSendButton", true);

        if (quizz.hasProblem == true ) {
            request.setAttribute("showBackButton", true);
        }

        request.getRequestDispatcher("/WEB-INF/views/quizz.jsp").forward(request, response);
    }



    protected void showCongratulationPage(
            HttpServletRequest request,
            HttpServletResponse response,
            Quizz quizz,
            CorrectorResult correction
    )
            throws ServletException, IOException
    {
        request.setAttribute("titleIntro", "Oh, Joy!" );
        request.setAttribute("title", "You passed the quizz");

        request.setAttribute("quizzName", quizz.name);
        request.setAttribute("successPercentage", correction.successPercentage );

        request.getRequestDispatcher("/WEB-INF/views/entryQuizzPassed.jsp").forward(request, response);
    }



    protected void showQuizzNotPassedPage(
            HttpServletRequest request,
            HttpServletResponse response,
            Quizz quizz,
            CorrectorResult correction
    )
            throws ServletException, IOException
    {

        request.setAttribute("title", "You can do better!");
        request.setAttribute("subtitle", "you did not pass the quizz");


        request.setAttribute("quizzName", quizz.name);
        request.setAttribute("successPercentage", correction.successPercentage );
        request.setAttribute("winMinPercentage", CorrectorService.winMinPercentage);


        request.getRequestDispatcher("/WEB-INF/views/quizzFailure.jsp").forward(request, response);
    }



    protected void showQuizzIncoherencyPage(HttpServletRequest request, HttpServletResponse response, Quizz quizz)
            throws ServletException, IOException
    {
        request.setAttribute("titleIntro", "Were're sorry..." );
        request.setAttribute("title", "incoherency have been detected inside the quizz");
        request.setAttribute(
                "subtitle",
                "It is thus impossible to correct your answers to the « ".concat(quizz.name).concat(" » quizz")
        );

        request.setAttribute("goBackUrl", "/entryQuizz");

        request.getRequestDispatcher("/WEB-INF/views/quizzIncoherencyDetected.jsp").forward(request, response);
    }

}
