package servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class ReplyAdd
 */
@WebServlet("/ReplyAdd")
public class ReplyAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyAdd() {
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
		String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
		String username=new String(request.getParameter("username").getBytes("iso-8859-1"),"utf-8");
		String commentId=new String(request.getParameter("commentId").getBytes("iso-8859-1"),"utf-8");
		String replyContent=new String(request.getParameter("reply").getBytes("iso-8859-1"),"utf-8");
		String commentAuthor=new String(request.getParameter("commentAuthor").getBytes("iso-8859-1"),"utf-8");
		String replyAuthor=request.getSession().getAttribute("username").toString();
		Date day=new Date();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date=format.format(day);
		ConnDb con=new ConnDb();
		con.insertReply(date, commentAuthor, replyAuthor, replyContent, commentId);
		response.sendRedirect("front_develop/articleContent.jsp?id="+id+"&&username="+username);
	}

}
