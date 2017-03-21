package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.junit.Test;

import db.ConnDb;

/**
 * Servlet implementation class ArticleUpdate
 */
@WebServlet("/ArticleUpdate")
public class ArticleUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArticleUpdate() {
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
		String title=new String(request.getParameter("title").getBytes("iso-8859-1"),"utf-8");
		String modularName=new String(request.getParameter("modular").getBytes("iso-8859-1"),"utf-8");
		String author=request.getSession().getAttribute("username").toString();
		String content=null;
		if(request.getParameter("editorValue")==null){
			content="";
		}else{
			content=new String(request.getParameter("editorValue").getBytes("iso-8859-1"),"utf-8");
		}
		ConnDb con=new ConnDb();
		Date day=new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date=df.format(day);
		con.updateArticle(id,date, title, author,content,modularName);
		response.sendRedirect("back_manage/articleList_Manage.jsp");
	}
}
