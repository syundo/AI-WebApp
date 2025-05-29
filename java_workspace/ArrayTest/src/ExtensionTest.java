import java.util.Scanner;

public class ExtensionTest {
	public static void main(String[] args) {
		Scanner s=new Scanner(System.in);
		System.out.print("파일명 : ");
		String fileName=s.nextLine(); //공백포함 한줄 전체 읽어들임
		System.out.println(fileName.lastIndexOf("."));
		int positionOfDot=fileName.lastIndexOf(".");
		System.out.println(fileName.substring(positionOfDot+1));		
		String[] result=fileName.split("\\."); // '.'을 regular express에서 사용중. '\\'로 escape
		for(String word : result) {
			System.out.println(word);
		}
		System.out.println(result[result.length-1]);//배열의 index의 최대값==배열의 크기-1
		//System.out.println(result[-1]); //자바에서는 불가. python가능.
		s.close();
	}
}