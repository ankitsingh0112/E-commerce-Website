package com.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.Entities.Category;
import com.Entities.Product;
import com.provider.FactoryProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductOperationServlet() {
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Session session = null;
		Transaction tx = null;
		boolean flag = false;
		try {
			String op = request.getParameter("operation");
			if (op.trim().equals("add_category")) {
				// add category
				String catName = request.getParameter("category_name");
				String catDesc = request.getParameter("category_decription");

				Category category = new Category();
				category.setCategoryTitle(catName);
				category.setCategoryDescription(catDesc);

				// saving in db
				session = FactoryProvider.getSessionFactory().openSession();
				tx = session.beginTransaction();

				session.persist(category);
				flag = true;

				int catId = category.getCategoryId();

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category added successfully! Category Id : " + catId);
				response.sendRedirect("admin.jsp");
				return;

			} else if (op.trim().equals("add_product")) {
				// add product
				String pName = request.getParameter("product_name");
				int pPrice = Integer.parseInt(request.getParameter("product_price"));
				int pCategory = Integer.parseInt(request.getParameter("product_category"));
				int pDiscount = Integer.parseInt(request.getParameter("product_discount"));
				int pQuantity = Integer.parseInt(request.getParameter("product_quantity"));
				String pDescription = request.getParameter("product_description");
				Part part = request.getPart("product_image");

				/* phele kya kiya n ki image of part ki help se fetch kr liye uske baad uske naam ko database me store kr liya
				 * uske baad ab hmlog ko image chaiye to kya kiya ki usko code ki help se us image ko ek folder me daal diya
				 * ab jb v image chaiye to database se name lenge image ka usko uss folder me khoj lenge.....*/
				Product p = new Product();
				p.setpTitle(pName);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpDescription(pDescription);
				p.setpPhoto(part.getSubmittedFileName());

				session = FactoryProvider.getSessionFactory().openSession();
				tx = session.beginTransaction();
				Category category = session.get(Category.class, pCategory);
				p.setCategory(category);

				// saving in db
				session.persist(p);
				flag = true;

				// image/photo upload on a folder
				// find out the path to upload photo
				String path = request.getServletContext().getRealPath("images") + File.separator + "products" + File.separator;

				System.out.println(path);

				// Uploading code
				try {
					String fileName = part.getSubmittedFileName();

					// Creating the complete file path
					String filePath = path + File.separator + fileName;

					// Creating a FileOutputStream with the correct file path
					FileOutputStream fos = new FileOutputStream(filePath);

					// Reading data from the part (file upload)
					InputStream is = part.getInputStream();
					// Reading data
					byte[] data = new byte[is.available()];
					is.read(data);
					// Writing the data to the output stream
					fos.write(data);
					fos.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
				/* ------------Uploading code END------------- */

				int pId = p.getPid();

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Product added successfully! Product Id : " + pId);
				response.sendRedirect("admin.jsp");
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (flag) {
				tx.commit();
			} else {
				tx.rollback();
			}
			session.close();
		}

	}

}
