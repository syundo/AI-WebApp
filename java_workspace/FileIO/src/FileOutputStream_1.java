

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.Charset;

public class FileOutputStream_1 {

	public static void main(String[] args) throws IOException {
		File outFile = new File("src/files/FileInputStream.txt");
		OutputStream os2 = new FileOutputStream(outFile,true); // true:append(추가), false(기본값):overwrite(덮어쓰기)
		byte[] byteArray1 = "안녕하세요".getBytes(Charset.forName("UTF-8"));
		os2.write(byteArray1);
		os2.write('\n'); // 줄바꾸기
		os2.flush();
		os2.close();
	}
}