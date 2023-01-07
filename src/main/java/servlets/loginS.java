package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet(name = "loginS", value = "/loginS")
public class loginS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if(Cookies.checkCookieRememberMeAdded(request,response) || Cookies.checkCookieRememberEmail(request,response)){
                response.sendRedirect("/"+request.getRequestURI().split("/")[1]+"/paginaPrincipalaS");
                return;
            }
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        setLoginInitial(request);
        request.getRequestDispatcher("/WEB-INF/login/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("emailvalue", request.getParameter("email"));
        try {
            if(SQL.checkAccountLogInGood(request.getParameter("email"),Hash.genHash(request.getParameter("password")))) {
                Cookies.addRememberMe(request,response);
                response.sendRedirect("/"+request.getRequestURI().split("/")[1]+"/paginaPrincipalaS");
                return;
            }
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        setLoginEsuat(request,response);
        request.getRequestDispatcher("/WEB-INF/login/login.jsp").forward(request, response);
    }

    private void setLoginInitial(HttpServletRequest request) throws IOException {
        request.setAttribute("emailvalue", request.getParameter("email"));
        request.setAttribute("vis", "hidden");
        request.setAttribute("text", "");
    }

    private void setLoginEsuat(HttpServletRequest request,HttpServletResponse response){
        request.setAttribute("emailvalue", request.getParameter("email"));
        request.setAttribute("vis", "visible");
        request.setAttribute("text", "Emailul sau parola au fost introduse gresit");
    }
}
