package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class ModularAdd
 */
@WebServlet("/ModularAdd")
public class ModularAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModularAdd() {
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
		String modularName=new String(request.getParameter("modularName").getBytes("iso-8859-1"),"utf-8");
		String briefInfo=new String(request.getParameter("briefInfo").getBytes("iso-8859-1"),"utf-8");
		String creator=request.getSession().getAttribute("username").toString();
		String briefImage="defaultModular.jpg";
		ConnDb con=new ConnDb();
		con.insertModular(modularName, briefImage, briefInfo, creator);
		response.sendRedirect("back_manage/modular_Manage.jsp");
	}

}
