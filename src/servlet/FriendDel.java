package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class FriendDel
 */
@WebServlet("/FriendDel")
public class FriendDel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendDel() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String friendName=new String(request.getParameter("friendName").getBytes("iso-8859-1"),"utf-8");
		String ownName=request.getSession().getAttribute("username").toString();
		ConnDb con=new ConnDb();
		con.deleteFriend(ownName, friendName);
		if(request.getParameter("mark").equals("1")){
			response.sendRedirect("front_develop/articleList.jsp?username="+request.getParameter("friendName"));
		}else{
			response.sendRedirect("front_develop/articleContent.jsp?username="+request.getParameter("friendName")+"&&id="+request.getParameter("id"));
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
