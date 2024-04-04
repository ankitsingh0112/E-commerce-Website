package com.UserDao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.Entities.User;

public class UserDao {
	private SessionFactory factory;

	public UserDao(SessionFactory factory) {
		this.factory = factory;
	}

	// get user by email and password
	@SuppressWarnings("deprecation")
	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;

		try {
			String query = "FROM User where userEmail = :e AND userPassword = :p";

			Session session = this.factory.openSession();
			@SuppressWarnings("rawtypes")
			Query q = session.createQuery(query);
			q.setParameter("e", email);
			q.setParameter("p", password);

			user = (User)q.uniqueResult();

			session.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return user;
	}
}
