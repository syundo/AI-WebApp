import java.util.LinkedList;
import java.util.List;

public class LinkedListTest {
	public static void main(String[] args) {
		List<Integer> linkedList = new LinkedList<>(); // upcasting
		linkedList.add(1);
		linkedList.add(2);
		linkedList.add(3);
		linkedList.add(4);
		linkedList.add(5);
		for(int v:linkedList) {
			System.out.println(v);
		}
	}
}