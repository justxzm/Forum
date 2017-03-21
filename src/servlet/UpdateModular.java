package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class UpdateModular
 */
@WebServlet("/UpdateModular")
public class UpdateModular extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateModular() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
		String modularName=new String(request.getParameter("modularName").getBytes("iso-8859-1"),"utf-8");
		String briefInfo=new String(request.getParameter("briefInfo").getBytes("iso-8859-1"),"utf-8");
		ConnDb con=new ConnDb();
		Connection connection=con.getConnection();
		PreparedStatement preStat=null;
		ResultSet rs=null;
		try {
			preStat=connection.prepareStatement("select * from modular where id='"+id+"'");
			rs=preStat.executeQuery();
			rs.next();
			String oldModularName=rs.getString("modularName");
			preStat=connection.prepareStatement("select * from article where modularName='"+oldModularName+"'");
			rs=preStat.executeQuery();
			while(rs.next()){
				String id2=rs.getInt("id")+"";
				preStat=connection.prepareStatement("update article set modularName=? where id='"+id2+"'");
				preStat.setString(1, modularName);
				preStat.executeUpdate();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		con.updateModular(id,modularName,briefInfo);		
		response.sendRedirect("back_manage/modular_Preview.jsp?id="+id);
	}

}
