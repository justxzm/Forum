package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class ArticleDel
 */
@WebServlet("/ArticleDel")
public class ArticleDel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArticleDel() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String id=new String(request.getParameter("id").getBytes(),"utf-8");
		String modularId=new String(request.getParameter("modularId").getBytes(),"utf-8");
		ConnDb test=new ConnDb();
		test.deleteArticle(id);
		if(request.getParameter("mark").equals("1")){
			response.sendRedirect("back_manage/articleList_Manage.jsp");
		}else{
			response.sendRedirect("back_manage/modular_ArticleList.jsp?id="+modularId);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
