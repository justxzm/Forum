package com.watermark;

import java.awt.Color;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

public class WaterMarkAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{
	private File image;
	private String imageFileName;
	
	private String uploadPath;

	private String markContent;
	private String markSize;
	private String markColor;
	public String getMarkColor() {
		return markColor;
	}
	public void setMarkColor(String markColor) {
		this.markColor = markColor;
	}
	public String getMarkSize() {
		return markSize;
	}
	public void setMarkSize(String markSize) {
		this.markSize = markSize;
	}
	public String getMarkContent() {
		return markContent;
	}
	public void setMarkContent(String markContent) {
		this.markContent = markContent;
	}

	HttpServletRequest request;
	HttpServletResponse response;
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
	public void watermark() throws Exception{
//		System.out.println(markColor);
		String realUploadPath=ServletActionContext.getServletContext().getRealPath(uploadPath);
//		System.out.println(markContent);
		TextMarkService tms=new TextMarkService();
		tms.setMARK_TEXT(markContent);
		tms.setFONT_SIZE(Integer.parseInt(markSize));
		String hex_r=markColor.substring(1,3);
		String hex_g=markColor.substring(3, 5);
		String hex_b=markColor.substring(5, 7);
		int r=Integer.parseInt(hex_r, 16);
		int g=Integer.parseInt(hex_g,16);
		int b=Integer.parseInt(hex_b,16);
		Color color=new Color(r,g,b);
		tms.setFONT_COLOR(color);
	/*	System.out.println(image);
		System.out.println(imageFileName);
		System.out.println(uploadPath);
		System.out.println(realUploadPath);*/
		UploadService uploadService=new UploadService();
		String oldUrl=uploadService.uploadImage(image, imageFileName, uploadPath, realUploadPath);
		String newUrl=tms.watermark(image, imageFileName, uploadPath, realUploadPath);
/*		request.setAttribute("oldUrl", oldUrl);
		request.setAttribute("newUrl", newUrl);*/
		/*System.out.println(oldUrl);
		System.out.println(newUrl);*/
		request.getRequestDispatcher("front_develop/tools/watermark.jsp?url=create&oldUrl="+oldUrl+"&newUrl="+newUrl).forward(request, response);
	}
	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}


}
