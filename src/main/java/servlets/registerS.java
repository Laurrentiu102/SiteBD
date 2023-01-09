package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet(name = "registerS", value = "/registerS")
public class registerS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if(Cookies.checkCookieRememberMeAdded(request,response) || Cookies.checkCookieRememberEmail(request,response)){
                if((Cookies.getJob(request).equals("avocat") || Cookies.getJob(request).equals("client") || Cookies.getJob(request).equals("angajat")) && SQL.checkAccountExists(Cookies.getEmail(request))){
                    request.setAttribute("email",Cookies.getEmail(request));
                    request.setAttribute("functie",Cookies.getJob(request));
                    request.getRequestDispatcher("/WEB-INF/paginaPrincipala/paginaPrincipala.jsp").forward(request,response);
                }else{
                    Cookies.deleteRememberMeCookie(response);
                    setRegisterInitial(request);
                    request.getRequestDispatcher("/WEB-INF/register/register.jsp").forward(request, response);
                }
                return;
            }
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        setRegisterInitial(request);
        request.getRequestDispatcher("/WEB-INF/register/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("emailvalue",request.getParameter("email"));
        try {
            boolean emailStatus = verificaEmail(request);
            boolean parolaStatus = verificaParola(request);
            if(emailStatus){
                request.setAttribute("emailvisbun","visible");
                if(parolaStatus){
                    SQL.insertIntoConturi(request.getParameter("email"),Hash.genHash(request.getParameter("password")));

                    HttpServletRequestWrapper wrapper = new HttpServletRequestWrapper(request) {
                        @Override
                        public String getMethod() {
                            return "GET";
                        }
                    };
                    response.sendRedirect("/"+request.getRequestURI().split("/")[1]+"/loginS?email="+request.getParameter("email"));
                    return;
                }
            }
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/WEB-INF/register/register.jsp").forward(request, response);
    }

    private void setRegisterInitial(HttpServletRequest request){
        request.setAttribute("emailvalue", "");
        request.setAttribute("parolavalue", "");
        request.setAttribute("parola2value", "");

        request.setAttribute("emailvisbun", "hidden");
        request.setAttribute("parolavisbun", "hidden");
        request.setAttribute("parola2visbun", "hidden");

        request.setAttribute("emailvis", "hidden");
        request.setAttribute("parolavis", "hidden");
        request.setAttribute("parola2vis", "hidden");

        request.setAttribute("emailtext", "");
        request.setAttribute("parolatext", "");
        request.setAttribute("parola2text", "");
    }

    private boolean verificaParola(HttpServletRequest request) throws NoSuchAlgorithmException {
        String parola = Hash.genHash(request.getParameter("password"));
        String parolac = Hash.genHash(request.getParameter("password2"));

        if(request.getParameter("password").length()==0){
            request.setAttribute("parolatext", "Trebuie sa introduceti o parola");
            request.setAttribute("parolavis", "visible");
            request.setAttribute("parola2text", "");
            request.setAttribute("parola2vis", "hidden");
            return false;
        }else if (!this.verificaNumarParola(request)) {
            request.setAttribute("parolatext", "Parola trebuie sa contina cel putin o cifra");
            request.setAttribute("parolavis", "visible");
            request.setAttribute("parola2text", "");
            request.setAttribute("parola2vis", "hidden");
            return false;
        }else if (!this.verificaLiteraParola(request)) {
            request.setAttribute("parolatext", "Parola trebuie sa contina cel putin o litera");
            request.setAttribute("parolavis", "visible");
            request.setAttribute("parola2text", "");
            request.setAttribute("parola2vis", "hidden");
            return false;
        }else if (request.getParameter("password").length() < 8) {
            request.setAttribute("parolatext", "Parola trebuie sa contina cel putin 8 caractere");
            request.setAttribute("parolavis", "visible");
            request.setAttribute("parola2text", "");
            request.setAttribute("parola2vis", "hidden");
            return false;
        }else if (request.getParameter("password").length() > 15) {
            request.setAttribute("parolatext", "Parola trebuie sa contina cel mult 15 caractere");
            request.setAttribute("parolavis", "visible");
            request.setAttribute("parola2text", "");
            request.setAttribute("parola2vis", "hidden");
            return false;
        }else if (!parola.equals(parolac)) {
            request.setAttribute("parola2text", "Parolele nu coincid");
            request.setAttribute("parola2vis", "visible");
            request.setAttribute("parolatext", "Parolele nu coincid");
            request.setAttribute("parolavis", "visible");
            return false;
        }
        return true;
    }

    private boolean verificaNumarParola(HttpServletRequest request) {
        for(int i = 0; i < request.getParameter("password").length(); ++i) {
            if (Character.isDigit(request.getParameter("password").charAt(i))) {
                return true;
            }
        }
        return false;
    }

    private boolean verificaLiteraParola(HttpServletRequest request) {
        for(int i = 0; i < request.getParameter("password").length(); ++i) {
            if (Character.isAlphabetic(request.getParameter("password").charAt(i))) {
                return true;
            }
        }
        return false;
    }

    private boolean verificaEmail(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        String email = request.getParameter("email");
        if(email.equals("")){
            request.setAttribute("emailvisbun", "hidden");
            request.setAttribute("emailtext", "Trebuie sa introduceti un email");
            request.setAttribute("emailvis", "visible");
            return false;
        } else if (SQL.checkAccountExists(email)) {
            request.setAttribute("emailvisbun", "hidden");
            request.setAttribute("emailtext", "Emailul apartine deja unui cont");
            request.setAttribute("emailvis", "visible");
            return false;
        } else if(!SQL.checkEmailExists(email)){
            request.setAttribute("emailvisbun", "hidden");
            request.setAttribute("emailtext", "Emailul nu se afla in contracte");
            request.setAttribute("emailvis", "visible");
            return false;
        }else if (email.isEmpty()) {
            request.setAttribute("emailvisbun", "hidden");
            request.setAttribute("emailtext", "Campul email trebuie sa fie completat");
            request.setAttribute("emailvis", "visible");
            return false;
        }
        return true;
    }
}
