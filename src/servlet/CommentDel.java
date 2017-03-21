package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class CommentDel
 */
@WebServlet("/CommentDel")
public class CommentDel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentDel() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
		String aid=new String(request.getParameter("aid").getBytes("iso-8859-1"),"utf-8");
		int id2=Integer.parseInt(id);
		int aid2=Integer.parseInt(aid);
		ConnDb con=new ConnDb();
		con.deleteComment(id);
		if(request.getParameter("mark").equals("1")){
			response.sendRedirect("back_manage/commentList_Manage.jsp?id="+aid2);
		}else{
			response.sendRedirect("back_manage/modular_CommentList.jsp?id="+aid2);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
