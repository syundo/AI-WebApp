import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class FileInputStream_1 {
	public static void main(String[] args) throws IOException {
		File inFile = new File("src/files/FileInputStream.txt");
		InputStream is2 = new FileInputStream(inFile);
		InputStreamReader isr = new InputStreamReader(is2,"UTF-8");
		BufferedReader br = new BufferedReader(isr);
//		byte[] byteArray1 = new byte[9];
		int str;
		while((str = br.read()) != -1) {
//			String str = new String(byteArray1, 0, count1, Charset.forName("UTF-8"));
			System.out.print((char)str);
//			System.out.println("count: "+count1);
		}
		is2.close();
	}
}