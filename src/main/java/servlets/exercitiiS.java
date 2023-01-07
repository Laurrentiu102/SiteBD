package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "exercitiiS", value = "/exercitiiS")
public class exercitiiS extends HttpServlet {

    String ex;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ex=request.getParameter("ex");
        request.getRequestDispatcher("/WEB-INF/Ex"+request.getParameter("ex").charAt(0)+"/"+request.getParameter("ex").charAt(1)+".jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
