package org.monochrome.servlets;

/* homePage servlet */

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet
public class HomeServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "quizzSchool" );
        request.setAttribute("titleIntro", "welcome to" );
        request.setAttribute("subtitle", "web learning" );

        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }

}