package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnDb {
	private String getDriver="com.mysql.jdbc.Driver";
	private String getConnection="jdbc:mysql://localhost:3306/forum";
	private String getName="";
	private String getPwd="";
	static Connection con;
	static PreparedStatement preStat;
	static ResultSet rs=null;
	
	public ConnDb(){
		try {
			Class.forName(getDriver);
			con=DriverManager.getConnection(getConnection,getName,getPwd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
	}
	public Connection getConnection(){
		return con;
	}
	public ResultSet getSelect(String sql){
		try {
			preStat=con.prepareStatement(sql);
			rs=preStat.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	public ResultSet getLoginSelect(String username,String password){
		try {
			String sql="select * from admin where username=? and password=?";
			preStat=con.prepareStatement(sql);
			preStat.setString(1, username);
			preStat.setString(2, password);
			rs=preStat.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	public void updateAdmin(String oldUserName,String password,String email){
		try {
			preStat=con.prepareStatement("update admin set password=?,email=? where userName='"+oldUserName+"'");
			preStat.setString(1, password );
			preStat.setString(2, email);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void updateModular(String id,String modularName,String briefInfo){
		try {
			preStat=con.prepareStatement("update modular set modularName=?,briefInfo=? where id='"+id+"'");
			preStat.setString(1, modularName );
			preStat.setString(2, briefInfo );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void updateArticlesModularName(String id,String newModularName){
		try {
			rs=getSelect("select * from modular where id='"+id+"'");
			rs.next();
			String oldModularName=rs.getString("modularName");
			preStat=con.prepareStatement("select article where modularName=?");
			preStat.setString(1, oldModularName);
			ResultSet rs2=preStat.executeQuery();
			while(rs2.next()){
				String id2=rs2.getInt("id")+"";
				System.out.println(id2);
				preStat=con.prepareStatement("update article set modularName=? where id='"+id2+"';");
				preStat.setString(1, newModularName );
				preStat.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void updateArticle(String id,String date,String title,String author,String content,String modularName){
		try {
			preStat=con.prepareStatement("update article set newDate=?,title=?,author=?,content=?,modularName=? where id='"+id+"'");
			preStat.setString(1, date );
			preStat.setString(2, title );
			preStat.setString(3, author);
			preStat.setString(4, content);
			preStat.setString(5, modularName);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void updateImageName(String userName,String imageName){
		try {
			preStat=con.prepareStatement("update admin set imageName=? where userName='"+userName+"'");
			preStat.setString(1, imageName );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void updateModularImageName(String id,String imageName){
		try {
			preStat=con.prepareStatement("update modular set briefImage=? where id='"+id+"'");
			preStat.setString(1, imageName );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void updatePraiseNumber(String praiser,String id){
		rs=getSelect("select * from article where id='"+id+"'");
		try {
			int commentNumber=0;
			if(rs.next()){
				commentNumber=rs.getInt("praiseNumber");
			}
			int newCommentNumber=commentNumber+1;
			preStat = con.prepareStatement("update article set praiseNumber=? where id='"+id+"'");
			preStat.setInt(1, newCommentNumber);
			preStat.executeUpdate();
			insertPraiseArticle(praiser, id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void updateCriticizeNumber(String criticize,String id){
		rs=getSelect("select * from article where id='"+id+"'");
		try {
			int commentNumber=0;
			if(rs.next()){
				commentNumber=rs.getInt("criticizeNumber");
			}
			int newCommentNumber=commentNumber+1;
			preStat = con.prepareStatement("update article set criticizeNumber=? where id='"+id+"'");
			preStat.setInt(1, newCommentNumber);
			preStat.executeUpdate();
			insertPraiseArticle(criticize, id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void insertAdmin(String userName,String password,String email,String imageName){
		try {
			preStat=con.prepareStatement("insert into admin(userName,password,email,imageName) values(?,?,?,?)");
			preStat.setString(1, userName );
			preStat.setString(2, password );
			preStat.setString(3, email);
			preStat.setString(4, imageName);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertArticle(String date,String title,String author,String content,String modularName){
		try {
			preStat=con.prepareStatement("insert into article(newDate,title,author,content,commentNumber,praiseNumber, criticizeNumber,modularName) values(?,?,?,?,?,?,?,?)");
			preStat.setString(1, date );
			preStat.setString(2, title );
			preStat.setString(3, author);
			preStat.setString(4, content);
			preStat.setInt(5, 0);
			preStat.setInt(6, 0);
			preStat.setInt(7, 0);
			preStat.setString(8, modularName);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertComment(String date,String comment,String articleId,String author){
		try {
			preStat=con.prepareStatement("insert into comment(date,content,articleId,author) values(?,?,?,?)");
			preStat.setString(1, date );
			preStat.setString(2, comment );
			preStat.setString(3, articleId);
			preStat.setString(4, author);
			preStat.executeUpdate();
			addArticleCommentNumber(articleId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertReply(String date,String commentAuthor,String replyAuthor,String replyContent,String commentId){
		try {
			preStat=con.prepareStatement("insert into replycomment(date,commentAuthor,replyAuthor,replyContent,commentId) values(?,?,?,?,?)");
			preStat.setString(1, date );
			preStat.setString(2, commentAuthor );
			preStat.setString(3, replyAuthor);
			preStat.setString(4, replyContent);
			preStat.setString(5, commentId);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertFriend(String ownName,String friendName){
		try {
			preStat=con.prepareStatement("insert into friend(ownName,friendName) values(?,?)");
			preStat.setString(1, ownName );
			preStat.setString(2, friendName );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertHobby(String ownName,String modularName){
		try {
			preStat=con.prepareStatement("insert into hobby(ownName,modularName) values(?,?)");
			preStat.setString(1, ownName );
			preStat.setString(2, modularName );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertPraiseArticle(String praiser,String articleId){
		try {
			preStat=con.prepareStatement("insert into praisearticle(praiser,articleId) values(?,?)");
			preStat.setString(1, praiser );
			preStat.setString(2, articleId );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertModular(String modularName,String briefImage,String briefInfo,String creator){
		try {
			preStat=con.prepareStatement("insert into modular(modularName,briefImage,briefInfo,creator) values(?,?,?,?)");
			preStat.setString(1, modularName );
			preStat.setString(2, briefImage );
			preStat.setString(3, briefInfo );
			preStat.setString(4, creator );
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void addArticleCommentNumber(String articleId){
		rs=getSelect("select * from article where id='"+articleId+"'");
		try {
			int commentNumber=0;
			if(rs.next()){
				commentNumber=rs.getInt("commentNumber");
			}
			int newCommentNumber=commentNumber+1;
			preStat = con.prepareStatement("update article set commentNumber=? where id='"+articleId+"'");
			preStat.setInt(1, newCommentNumber);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void deleteArticle(String id){
		try {
			preStat = con.prepareStatement("delete from article where id='"+id+"'");
			preStat.executeUpdate();
			preStat = con.prepareStatement("delete from praisearticle where articleId='"+id+"'");
			preStat.executeUpdate();
			rs=getSelect("select * from comment where articleId='"+id+"'");
			if(rs.next()){
				String commentId=rs.getInt("id")+"";
				deleteComment(commentId);
			}
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteComment(String id){
		try {
			rs=getSelect("select * from comment where id='"+id+"'");
			int articleId=0;
			if(rs.next()){
				articleId=rs.getInt("articleId");
			}
			reduceArticleCommentNumber(articleId);
			preStat = con.prepareStatement("delete from comment where id='"+id+"'");
			preStat.executeUpdate();
			preStat = con.prepareStatement("delete from replycomment where commentId='"+id+"'");
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void reduceArticleCommentNumber(int articleId){
		rs=getSelect("select * from article where id='"+articleId+"'");
		try {
			int commentNumber=0;
			if(rs.next()){
				commentNumber=rs.getInt("commentNumber");
			}
			int newCommentNumber=commentNumber-1;
			preStat = con.prepareStatement("update article set commentNumber=? where id='"+articleId+"'");
			preStat.setInt(1, newCommentNumber);
			preStat.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void deleteFriend(String ownName,String friendName){
		try {
			preStat = con.prepareStatement("delete from friend where ownName=? and friendName=?");
			preStat.setString(1, ownName);
			preStat.setString(2, friendName);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteHobby(String ownName,String modularName){
		try {
			preStat = con.prepareStatement("delete from hobby where ownName=? and modularName=?");
			preStat.setString(1, ownName);
			preStat.setString(2, modularName);
			preStat.executeUpdate();
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteAdmin(String username){
		try {
			preStat = con.prepareStatement("delete from friend where friendName='"+username+"'");
			preStat.executeUpdate();
			preStat = con.prepareStatement("delete from admin where userName=?");
			preStat.setString(1, username);
			preStat.executeUpdate();
			preStat = con.prepareStatement("delete from friend where ownName=? or friendName=?");
			preStat.setString(1, username);
			preStat.setString(2, username);
			preStat.executeUpdate();
			rs=getSelect("select * from article where author='"+username+"'");
			while(rs.next()){
				String id=rs.getInt("id")+"";
				preStat = con.prepareStatement("delete from article where id='"+id+"'");
				preStat.executeUpdate();
				preStat = con.prepareStatement("delete from comment where articleId='"+id+"'");
				preStat.executeUpdate();
			}
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteModular(String id){
		try {
			rs=getSelect("select * from modular where id='"+id+"'");
			if(rs.next()){
				String modularName=rs.getString("modularName");
				preStat = con.prepareStatement("delete from hobby where modularName='"+modularName+"'");
				preStat.executeUpdate();
			}
			preStat = con.prepareStatement("delete from modular where id=?");
			preStat.setString(1, id);
			preStat.executeUpdate();	
			closeAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public int ifhaspower(String username) throws SQLException{
		preStat=con.prepareStatement("select count(1) from article where author='"+username+"'");
		rs=preStat.executeQuery();
		rs.next();
		int articleNumber=rs.getInt(1);
		preStat=con.prepareStatement("select * from article where author='"+username+"'");
		rs=preStat.executeQuery();
		int parseNumber=0;
		while(rs.next()){
			parseNumber+=rs.getInt("praiseNumber");
		}
		preStat=con.prepareStatement("select * from article where author='"+username+"'");
		rs=preStat.executeQuery();
		int critiNumber=0;
		while(rs.next()){
			critiNumber+=rs.getInt("criticizeNumber");
		}
		if(articleNumber>0&&(parseNumber-critiNumber)>0){
			return 1;
		}else{
			return 0;
		}	
	}
	public void closeAll(){
		try {
			if(rs!=null){
				rs.close();
			}
			if(preStat.isClosed()==false){
				preStat.close();
			}
			if(con.isClosed()==false){
				con.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
