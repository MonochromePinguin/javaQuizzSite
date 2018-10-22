package org.monochrome.servlets;

/* quizz lists, sorted by categories servlet */

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet
public class QuizzSelectionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "entry quizz selection" );

        request.getRequestDispatcher("/WEB-INF/views/quizzList.jsp").forward(request, response);
        //TODO
    }
}
