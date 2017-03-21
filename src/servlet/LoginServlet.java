package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		String username=new String(request.getParameter("username").getBytes("iso-8859-1"),"utf-8");
		String password=new String(request.getParameter("password").getBytes("iso-8859-1"),"utf-8");
//		String pass=password.split("'")[0];
		ConnDb con=new ConnDb();
		ResultSet rs=con.getLoginSelect(username,password);
		try {
			if(rs.next()){
				request.getSession().setAttribute("username", rs.getString("userName"));
				rs.close();
				response.sendRedirect("front_develop/index.jsp");
			}else{
				request.getSession().setAttribute("username", null);
				rs.close();
				response.sendRedirect("front_develop/index.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			con.closeAll();	
		}
	}

}
