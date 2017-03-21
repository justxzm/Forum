package com.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

import db.ConnDb;

/**
 * Description:
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br/>Copyright (C), 2001-2016, Yeeku.H.Lee
 * <br/>This program is protected by copyright laws.
 * <br/>Program Name:
 * <br/>Date:
 * @author  Yeeku.H.Lee kongyeeku@163.com
 * @version  1.0
 */

public class UploadAction extends ActionSupport implements ServletRequestAware,ServletResponseAware
{
	private File upload;
	private String uploadFileName;
	HttpServletRequest request;
	ServletResponse response;
	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}
	@Override
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response=response;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	private String savePath;
	public String getSavePath() {
		return ServletActionContext.getServletContext().getRealPath(savePath).replace('\\', '/');
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String test() throws IOException, SQLException
	{
		ConnDb con=new ConnDb();
		
		String username=request.getSession().getAttribute("username").toString();
		ResultSet rs=con.getSelect("select * from admin where userName='"+username+"'");
		String newImageName=null;
		if(rs.next()){
			 newImageName=rs.getInt("userId")+"_"+getUploadFileName();
		}
		String imagePath=getSavePath()+File.separator+newImageName;
		FileOutputStream out=new FileOutputStream(imagePath);
		FileInputStream in=new FileInputStream(upload);
		byte[] tom=new byte[1024];
		int len=0;
		while((len=in.read(tom))!=-1){
			out.write(tom,0,len);
		}
		out.close();
		in.close();
		con.updateImageName(username, newImageName);
		return SUCCESS;
	}
	public String test2() throws IOException, SQLException, ServletException
	{
		ConnDb con=new ConnDb();
		String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
		String username=request.getSession().getAttribute("username").toString();
		String newImageName="modular_"+id+"_"+getUploadFileName();
		String imagePath=getSavePath()+File.separator+newImageName;
		FileOutputStream out=new FileOutputStream(imagePath);
		FileInputStream in=new FileInputStream(upload);
		byte[] tom=new byte[1024];
		int len=0;
		while((len=in.read(tom))!=-1){
			out.write(tom,0,len);
		}
		out.close();
		in.close();
		request.getSession().setAttribute("modularEditId", id);
		con.updateModularImageName(id, newImageName);
		return SUCCESS;
	}
	
}