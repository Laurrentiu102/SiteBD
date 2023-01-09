package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet(name = "paginaPrincipalaS", value = "/paginaPrincipalaS")
public class paginaPrincipalaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if(Cookies.checkCookieRememberMeAdded(request,response) || Cookies.checkCookieRememberEmail(request,response)){
                if(Cookies.getJob(request).equals("avocat") || Cookies.getJob(request).equals("client") || Cookies.getJob(request).equals("angajat")){
                    request.setAttribute("email",Cookies.getEmail(request));
                    request.setAttribute("functie",Cookies.getJob(request));
                    request.getRequestDispatcher("/WEB-INF/paginaPrincipala/paginaPrincipala.jsp").forward(request,response);
                }
                return;
            }
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        response.sendRedirect("/"+request.getRequestURI().split("/")[1]+"/loginS");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
