package servlets;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.RandomStringUtils;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public class Cookies {

    public Cookies() {

    }

    public static String getJob(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        for (Cookie ck:cookies){
            if(ck.getName().equals("functie"))
                return ck.getValue();
        }
        return "nimic";
    }

    public static String getEmail(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        for (Cookie ck:cookies){
            if(ck.getName().equals("email"))
                return ck.getValue();
        }
        return null;
    }

    public static void deleteRememberMeCookie(HttpServletResponse response) {
        Cookie newEmail = new Cookie("email", "");
        newEmail.setMaxAge(0);
        response.addCookie(newEmail);

        Cookie sel = new Cookie("selector", "");
        sel.setMaxAge(0);
        response.addCookie(sel);

        Cookie val = new Cookie("validator", "");
        val.setMaxAge(0);
        response.addCookie(val);

        Cookie fct = new Cookie("functie", "");
        fct.setMaxAge(0);
        response.addCookie(fct);
    }

    public static boolean checkCookieRememberEmail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {
        Cookie[] cook = request.getCookies();
        String email = null;
        if (cook != null)
            for (Cookie ck : cook)
                if (ck.getName().equals("email"))
                    email = ck.getValue();
        if(email!=null && email.equals("")){
            deleteRememberMeCookie(response);
            return false;
        }
        if(!SQL.checkEmailExists(email)){
            deleteRememberMeCookie(response);
            return false;
        }
        Cookie newEmail = new Cookie("email", email);
        newEmail.setMaxAge(60*10);
        response.addCookie(newEmail);

        Cookie newFunctie = new Cookie("functie", SQL.getJob(email));
        newFunctie.setMaxAge(60*10);
        response.addCookie(newFunctie);
        return true;
    }
    public static boolean checkCookieRememberMeAdded(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        Cookie[] cook = request.getCookies();
        String selector = null, validator = null;
        if (cook != null)
            for (Cookie ck : cook)
                if (ck.getName().equals("selector"))
                    selector = ck.getValue();
                else if (ck.getName().equals("validator"))
                    validator = ck.getValue();
        String emailSQL = SQL.getEmailAndTimeLeftByRememberMe(selector, validator);
        if (emailSQL != null) {
            int time = Integer.parseInt(emailSQL.split(",")[1]) / 1000;
            emailSQL = emailSQL.split(",")[0];
            Cookie newEmail = new Cookie("email", emailSQL);
            newEmail.setMaxAge(time);
            response.addCookie(newEmail);

            Cookie newFunctie = new Cookie("functie", SQL.getJob(emailSQL));
            newFunctie.setMaxAge(time);
            response.addCookie(newFunctie);

            return true;
        } else
            deleteRememberMeCookie(response);
        return false;
    }

    private static String[] makeSelectorValidator(String email) throws NoSuchAlgorithmException, SQLException, ClassNotFoundException {
        String selector = RandomStringUtils.randomAlphanumeric(12);
        String rawValidator = RandomStringUtils.randomAlphanumeric(64);
        String hashedValidator = Hash.genHash(rawValidator);

        while (SQL.checkSelectorExists(selector)) {
            selector = RandomStringUtils.randomAlphanumeric(12);
        }

        SQL.insertRememberMe(email, selector, hashedValidator);

        return new String[]{selector, rawValidator};
    }

    public static void addRememberMe(HttpServletRequest request, HttpServletResponse response) throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        if (request.getParameter("remember") != null && request.getParameter("remember").equals("yes")) {
            String[] selVal = makeSelectorValidator(request.getParameter("email"));
            Cookie selector = new Cookie("selector", selVal[0]);
            Cookie validator = new Cookie("validator", selVal[1]);
            Cookie ckEmail = new Cookie("email", request.getParameter("email"));
            Cookie fct = new Cookie("functie",SQL.getJob(request.getParameter("email")));
            selector.setMaxAge(60 * 60);
            validator.setMaxAge(60 * 60);
            ckEmail.setMaxAge(60 * 60);
            fct.setMaxAge(60*60);
            response.addCookie(selector);
            response.addCookie(validator);
            response.addCookie(ckEmail);
            response.addCookie(fct);
        }else{
            deleteRememberMeCookie(response);
            Cookie ckEmail = new Cookie("email", request.getParameter("email"));
            Cookie fct = new Cookie("functie",SQL.getJob(request.getParameter("email")));
            ckEmail.setMaxAge(60*10);
            fct.setMaxAge(60*10);
            response.addCookie(ckEmail);
            response.addCookie(fct);
        }
    }


}
