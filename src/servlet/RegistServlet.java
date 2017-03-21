package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class RegistServlet
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username=new String(request.getParameter("username2").getBytes("iso-8859-1"),"utf-8");
		String password=new String(request.getParameter("password").getBytes("iso-8859-1"),"utf-8");
		String email=new String(request.getParameter("email").getBytes("iso-8859-1"),"utf-8");
		String imageName="defaultHead.png";
		ConnDb con=new ConnDb();
		con.insertAdmin(username, password, email, imageName);
		request.getSession().setAttribute("username", username);
		response.sendRedirect("front_develop/index.jsp");
	}

}
