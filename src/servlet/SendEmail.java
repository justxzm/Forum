package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ConnDb;

/**
 * Servlet implementation class SendEmail
 */
@WebServlet("/SendEmail")
public class SendEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SendEmail() {
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
		String userName=new String(request.getParameter("username").getBytes("iso-8859-1"),"utf-8");
		try {
			ConnDb con = new ConnDb();
			ResultSet rs = con.getSelect("select * from admin where userName='"+userName+"'");
			String message = "";
			if (rs.next()) {
				String username = rs.getString("userName");
				String password = rs.getString("password");
				String email=rs.getString("email");
				SimpleDateFormat format=new SimpleDateFormat("yyyy.MM.dd");
				String date=format.format(new Date());
//				System.out.println(date);
				
				Properties props = new Properties();
				props.setProperty("mail.smtp.auth", "true");
				props.setProperty("mail.transport.protocol", "smtp");

				props.setProperty("mail.host", "smtp.163.com");

				Session session = Session.getInstance(props, new Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication("emailAccount", "emailPassword");
					}
				});
//				session.setDebug(true);

				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("\"" + MimeUtility.encodeText("Try.Catch") + "\" <justxzm@163.com>"));
				msg.setSubject("Find Password~");
				// msg.setText("666");
				msg.setRecipients(RecipientType.TO, InternetAddress
						.parse(email));
				msg
						.setContent(
								"<div style=\"width: 666px;height: 333px;margin: auto;border: 1px solid grey;border-radius:20px;\"><div style=\"margin:30px 30px 30px 30px;color: #000000\"><strong>尊敬的用户:</strong><div style=\"margin:20px 0px 0px 38px;color: #808080\">请妥善保管你的密码~</div></div><table border=\"1px\" width=\"80%\" style=\"margin: auto;height: 66px;text-align: center;border-color: #d8ecf6;\" cellspacing=\"0\"><tr><th>用户名</th><th>密码</th><th>重新登录</th></tr><tr style=\"color: #808080\"><td>"+username+"</td><td>"+password+"</td><td><a style=\"text-decoration: none;color: #808080\" href=\"http://www.justxzm.cn\">http://www.justxzm.cn</a></td></tr></table><div style=\"margin:40px 0px 0px 68px;color: #808080\">谢谢！</div><div style=\"margin:20px 20px 20px 20px;color: #808080;float: right\">Try.Catch<div style=\"margin:5px 10px 10px 0px;\">"+date+"</div></div></div>",
								"text/html;charset=utf-8");

				Transport.send(msg);
				response.sendRedirect("front_develop/index.jsp");
			}
			rs.close();
			con.closeAll();		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
