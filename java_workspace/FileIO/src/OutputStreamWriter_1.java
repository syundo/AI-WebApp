import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;

public class OutputStreamWriter_1 {
	public static void main(String[] args) {
		// FileWriter
		File outputStreamWriter1 = new File("src/files/OutputStreamWriter1.txt");
		try(Writer writer = new FileWriter(outputStreamWriter1);) {
			writer.write("안녕하세요? Good Afternoon \n");
			writer.flush();
		}
		catch(IOException e) {}
		// OutputStreamWriter
		File outputStreamWriter2 = new File("src/files/OutputStreamWriter2.txt");
		try(OutputStream os = new FileOutputStream(outputStreamWriter2);
			OutputStreamWriter osw = new OutputStreamWriter(os,"UTF-8");) {
			osw.write("안녕하세요? Good Afternoon \n");
			osw.flush();
		}
		catch(IOException e) {}
	}
}