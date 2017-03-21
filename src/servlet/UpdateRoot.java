package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class UpdateRoot
 */
@WebServlet("/UpdateRoot")
public class UpdateRoot extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateRoot() {
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
		String oldUserName=new String(request.getParameter("oldUserName").getBytes("iso-8859-1"),"utf-8");
//		String userName=new String(request.getParameter("userName").getBytes("iso-8859-1"),"utf-8");
		String password=new String(request.getParameter("password").getBytes("iso-8859-1"),"utf-8");
		String email=new String(request.getParameter("email").getBytes("iso-8859-1"),"utf-8");
		ConnDb con=new ConnDb();
		con.updateAdmin(oldUserName, password, email);
		request.getSession().removeAttribute("username");
		response.sendRedirect("index.jsp?source=UpdateRoot");
	}

}
