package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.Entities.User;
import com.provider.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        // TODO Auto-generated constructor stub
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session = null;
		Transaction tx = null;
		boolean flag = false;
		PrintWriter pw = response.getWriter();
		try {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_phone");
			String userAddress = request.getParameter("user_address");

			/* Password Encryption */

			/* MessageDigest instance for MD5. */
            MessageDigest m = MessageDigest.getInstance("MD5");

            /* Add plain-text password bytes to digest using MD5 update() method. */
            m.update(userPassword.getBytes());

            /* Convert the hash value into bytes */
            byte[] bytes = m.digest();

            /* The bytes array has bytes in decimal form. Converting it into hexadecimal format. */
            StringBuilder s = new StringBuilder();
            for (byte element : bytes) {
                s.append(Integer.toString((element & 0xff) + 0x100, 16).substring(1));
            }

            /* Complete hashed password in hexadecimal format */
            String encryptedPassword = s.toString();



			User user = new User(userName, userEmail, encryptedPassword, userPhone, "default.jpg", userAddress, "normal");

			session = FactoryProvider.getSessionFactory().openSession();
			tx = session.beginTransaction();

			session.persist(user);
			flag = true;
			int userId = user.getUserId();

			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("message", "Sign Up Successfully!!! Your Id : " + userId);
			response.sendRedirect("register.jsp");
			return;

			//pw.println("Successfully registered!!! <br> Your Id : " + userId);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(flag) {
				tx.commit();
			}
			else {
				tx.rollback();
			}
			session.close();
			pw.close();
		}
	}

}
