package com.watermark;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class TextMarkService implements MarkService {
	public String MARK_TEXT;
	public int FONT_SIZE;

	public Color FONT_COLOR=Color.BLACK;
	
	public Color getFONT_COLOR() {
		return FONT_COLOR;
	}

	public void setFONT_COLOR(Color fONT_COLOR) {
		FONT_COLOR = fONT_COLOR;
	}

	public String getMARK_TEXT() {
		return MARK_TEXT;
	}

	public void setMARK_TEXT(String mARK_TEXT) {
		MARK_TEXT = mARK_TEXT;
	}

	public int getFONT_SIZE() {
		return FONT_SIZE;
	}

	public void setFONT_SIZE(int fONT_SIZE) {
		FONT_SIZE = fONT_SIZE;
	}

	@Override
	public String watermark(File image, String imageFileName, String uploadPath, String realUploadPath) {
		// TODO Auto-generated method stub
		
		String logoFileName="logo_"+imageFileName;
		OutputStream os=null;
		try{
			Image image2=ImageIO.read(image);
			int width=image2.getWidth(null);
			int height=image2.getHeight(null);
			
			BufferedImage bufferedImage=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
			
			Graphics2D g=bufferedImage.createGraphics();
			
			g.drawImage(image2, 0, 0, width, height,null);
			
			g.setFont(new Font(FONT_NAME,FONT_STYLE,FONT_SIZE));
			g.setColor(FONT_COLOR);
			int width1=FONT_SIZE*getTextLength(MARK_TEXT);
			int height1=FONT_SIZE;
			
			int widthDff=width-width1;
			int heightDff=height-height1;
			
			int x=X;
			int y=Y;
			
			if(x<widthDff){
				x=widthDff-50;
			}
			if(y<heightDff){
				y=heightDff-50;
			}
			
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,ALPHA));
			
			g.drawString(MARK_TEXT, x, y+FONT_SIZE);
			g.dispose();
			
			os=new FileOutputStream(realUploadPath+"/"+logoFileName);
			JPEGImageEncoder en=JPEGCodec.createJPEGEncoder(os);
			en.encode(bufferedImage);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(os!=null){
				try{
					os.close();
				}catch(Exception e2){
					e2.printStackTrace();
				}
			}
		}
		
		return uploadPath+"/"+logoFileName;
	}

	public int getTextLength(String text){
		int length=text.length();
		
		for(int i=0;i<text.length();i++){
			String s=String.valueOf(text.charAt(i));
			if(s.getBytes().length>1){
				length++;
			}
		}
		
		length=length%2==0? length/2:length/2+1;
		return length;
	}
}
