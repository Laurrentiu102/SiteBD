package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "manageTableS", value = "/manageTableS")
public class manageTableS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (request.getParameter("ex").equals("3a"))
                request.setAttribute("rows", SQL.Ex03a(request.getParameter("luna"), request.getParameter("an"), request.getParameter("onorarMin"), request.getParameter("onorarMax")));
            else if (request.getParameter("ex").equals("3b"))
                request.setAttribute("rows", SQL.Ex03b(request.getParameter("litera")));
            else if (request.getParameter("ex").equals("4a"))
                request.setAttribute("rows", SQL.Ex04a(request.getParameter("functia"), request.getParameter("an")));
            else if (request.getParameter("ex").equals("4b"))
                request.setAttribute("rows", SQL.Ex04b(request.getParameter("idAvocat")));
            else if (request.getParameter("ex").equals("5a"))
                request.setAttribute("rows", SQL.Ex05a());
            else if (request.getParameter("ex").equals("5b"))
                request.setAttribute("rows", SQL.Ex05b());
            else if (request.getParameter("ex").equals("6a"))
                request.setAttribute("rows", SQL.Ex06a(request.getParameter("functia"), request.getParameter("an")));
            else if (request.getParameter("ex").equals("6b"))
                request.setAttribute("rows", SQL.Ex06b());
            else {
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/WEB-INF/IframeTabela/IframeTabela.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("do post");
    }
}
