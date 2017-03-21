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
 * Servlet implementation class HobbyDel
 */
@WebServlet("/HobbyDel")
public class HobbyDel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HobbyDel() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
		String ownName=request.getSession().getAttribute("username").toString();
		ConnDb con=new ConnDb();
		ResultSet rs=con.getSelect("select * from modular where id='"+id+"'");
		String modularName=null;
		try {
			rs.next();
			modularName = rs.getString("modularName");
			con.deleteHobby(ownName, modularName);
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("front_develop/modular_articleList.jsp?id="+id);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}
