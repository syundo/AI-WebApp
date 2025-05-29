

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class BufferedInputOutputStream {
	public static void main(String[] args) {
		File orgfile = new File("src/files/universe.tif");
		File copyfile1 = new File("src/files/universe_copy1.tif");
		File copyfile2 = new File("src/files/universe_copy2.tif");
		long start, end, time1, time2;
		// no buffer
		start = System.nanoTime();
		try(InputStream is = new FileInputStream(orgfile);
			OutputStream os = new FileOutputStream(copyfile1);) {
			int data;
			while((data = is.read()) != -1) {
				os.write(data);
			}
		}
		catch(IOException e) {e.printStackTrace();}
		end = System.nanoTime();
		time1 = end-start;
		System.out.println("Without BufferedXXXStream: "+time1);
		// buffer
		start = System.nanoTime();
		try(InputStream is = new FileInputStream(orgfile);
			BufferedInputStream bis = new BufferedInputStream(is);
			OutputStream os = new FileOutputStream(copyfile2);
			BufferedOutputStream bos = new BufferedOutputStream(os);) {
			int data;
			while((data = bis.read()) != -1) {
				bos.write(data);
			}
		}
		catch(IOException e) {e.printStackTrace();}
		end = System.nanoTime();
		time2 = end-start;
		System.out.println("With BufferedXXXStream: "+time2);
		// 비교
		System.out.println(time1/time2);
	}
}