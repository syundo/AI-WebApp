import java.util.HashSet;
import java.util.Set;

public class SetTest {
	public static void main(String[] args) {
		Set<String> hSet = new HashSet<>();
		hSet.add("가");
		hSet.add("나");
		hSet.add("가");
		for(String s:hSet) {
			System.out.print(s+" ");
		}
		System.out.println();
		hSet.add("다");
		hSet.add("라");
		for(String s:hSet) {
			System.out.print(s+" ");
		}
	}
}