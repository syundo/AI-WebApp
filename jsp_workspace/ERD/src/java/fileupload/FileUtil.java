package java.fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class FileUtil {
	//�뙆�씪 �뾽濡쒕뱶
	public static String uploadFile(HttpServletRequest req, String sDirectory) 
			throws ServletException, IOException {
		//Part 媛앹껜瑜� �넻�빐 �꽌踰꾨줈 �쟾�넚�맂 �뙆�씪紐� �씫�뼱�삤湲� 
		Part part = req.getPart("ofile");					
		 
		//Part 媛앹껜�쓽 �뿤�뜑媛� 以� content-disposition �씫�뼱�삤湲� 
        String partHeader = part.getHeader("content-disposition");
        //異쒕젰寃곌낵 => form-data; name="attachedFile"; filename="�뙆�씪紐�.jpg"
        System.out.println("partHeader="+ partHeader);
         
        //�뿤�뜑媛믪뿉�꽌 �뙆�씪紐� �옒�씪�궡湲�
        String[] phArr = partHeader.split("filename=");
        String originalFileName = phArr[1].trim().replace("\"", "");
		
		//�쟾�넚�맂 �뙆�씪�씠 �엳�떎硫� �뵒�젆�넗由ъ뿉 ���옣
		if (!originalFileName.isEmpty()) {
			System.out.println(sDirectory);
			part.write(sDirectory+ File.separator +originalFileName);
		}
		 
		//�썝蹂� �뙆�씪紐� 諛섑솚
		return originalFileName;			
	}
	 
	//�뙆�씪紐� 蹂�寃�
	public static String renameFile(String sDirectory, String fileName) {
		//�썝蹂명뙆�씪�쓽 �솗�옣�옄 �옒�씪�궡湲�
		String ext = fileName.substring(fileName.lastIndexOf("."));
		//�궇吏� 諛� �떆媛꾩쓣 �넻�빐 �뙆�씪紐� �깮�꽦
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		//"�궇吏�_�떆媛�.�솗�옣�옄" �삎�깭�쓽 �깉濡쒖슫 �뙆�씪紐� �깮�꽦
		String newFileName = now + ext;  

		//湲곗〈 �뙆�씪紐낆쓣 �깉濡쒖슫 �뙆�씪紐낆쑝濡� 蹂�寃�
		File oldFile = new File(sDirectory + File.separator + fileName);
	    File newFile = new File(sDirectory + File.separator + newFileName);
	    oldFile.renameTo(newFile);
	    
	    //蹂�寃쎈맂 �뙆�씪紐� 諛섑솚
	    return newFileName;
	}
	
	//multiple �냽�꽦 異붽�濡� 2媛� �씠�긽�쓽 �뙆�씪 �뾽濡쒕뱶
	public static ArrayList<String> multipleFile(HttpServletRequest req, String sDirectory) throws ServletException, IOException {
		//�뙆�씪紐� ���옣�쓣 �쐞�븳 而щ젆�뀡 �깮�꽦
		ArrayList<String> listFileName = new ArrayList<>();
	
		//Part 媛앹껜瑜� �넻�빐 �꽌踰꾨줈 �쟾�넚�맂 �뙆�씪紐� �씫�뼱�삤湲� 
		Collection<Part> parts = req.getParts();
		for(Part part : parts) {
			//�뙆�씪�씠 �븘�땲�씪硫� �뾽濡쒕뱶�쓽 ���긽�씠 �븘�땲誘�濡� 臾댁떆
			if(!part.getName().equals("ofile"))
				continue;	
			
			//Part 媛앹껜�쓽 �뿤�뜑媛� 以� content-disposition �씫�뼱�삤湲� 
	        String partHeader = part.getHeader("content-disposition");
	        //異쒕젰寃곌낵 => form-data; name="attachedFile"; filename="�뙆�씪紐�.jpg"
	        System.out.println("partHeader="+ partHeader);
	        
	        //�뿤�뜑媛믪뿉�꽌 �뙆�씪紐� �옒�씪�궡湲�
	        String[] phArr = partHeader.split("filename=");
	        String originalFileName = phArr[1].trim().replace("\"", "");
			
			//�쟾�넚�맂 �뙆�씪�씠 �엳�떎硫� �뵒�젆�넗由ъ뿉 ���옣
			if (!originalFileName.isEmpty()) {				
				part.write(sDirectory+ File.separator +originalFileName);
			}
			
			//而щ젆�뀡�뿉 異붽�
			listFileName.add(originalFileName);
		}
	
		//�썝蹂� �뙆�씪紐� 諛섑솚
		return listFileName;			
	}
	
	//�뙆�씪 �떎�슫濡쒕뱶
	public static void download(HttpServletRequest req, HttpServletResponse resp,
            String directory, String sfileName, String ofileName) {
        String sDirectory = req.getServletContext().getRealPath(directory);
        try {
            // �뙆�씪�쓣 李얠븘 �엯�젰 �뒪�듃由� �깮�꽦
            File file = new File(sDirectory, sfileName);
            InputStream iStream = new FileInputStream(file);

            // �븳湲� �뙆�씪紐� 源⑥쭚 諛⑹�
            String client = req.getHeader("User-Agent");
            if (client.indexOf("WOW64") == -1) {
                ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
            }
            else {
                ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
            }

            // �뙆�씪 �떎�슫濡쒕뱶�슜 �쓳�떟 �뿤�뜑 �꽕�젙
            resp.reset();
            resp.setContentType("application/octet-stream");
            resp.setHeader("Content-Disposition",
                           "attachment; filename=\"" + ofileName + "\"");
            resp.setHeader("Content-Length", "" + file.length() );

            //out.clear();  // 異쒕젰 �뒪�듃由� 珥덇린�솕

            // response �궡�옣 媛앹껜濡쒕��꽣 �깉濡쒖슫 異쒕젰 �뒪�듃由� �깮�꽦
            OutputStream oStream = resp.getOutputStream();

            // 異쒕젰 �뒪�듃由쇱뿉 �뙆�씪 �궡�슜 異쒕젰
            byte b[] = new byte[(int)file.length()];
            int readBuffer = 0;
            while ( (readBuffer = iStream.read(b)) > 0 ) {
                oStream.write(b, 0, readBuffer);
            }

            // �엯/異쒕젰 �뒪�듃由� �떕�쓬
            iStream.close();
            oStream.close();
        }
        catch (FileNotFoundException e) {
            System.out.println("�뙆�씪�쓣 李얠쓣 �닔 �뾾�뒿�땲�떎.");
            e.printStackTrace();
        }
        catch (Exception e) {
            System.out.println("�삁�쇅媛� 諛쒖깮�븯���뒿�땲�떎.");
            e.printStackTrace();
        }
    }

    //�뙆�씪 �궘�젣 
    public static void deleteFile(HttpServletRequest req,
            String directory, String filename) {
        String sDirectory = req.getServletContext().getRealPath(directory);
        File file = new File(sDirectory + File.separator + filename);
        if (file.exists()) {
            file.delete();
        }
    }
}