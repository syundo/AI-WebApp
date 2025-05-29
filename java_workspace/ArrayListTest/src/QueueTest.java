import java.util.LinkedList;
import java.util.Queue;

public class QueueTest {

	public static void main(String[] args) {
		Queue<Integer> queue = new LinkedList<Integer>(); // upcasting
		queue.offer(3);
		queue.offer(4);
		queue.offer(5);
		for(int i:queue) {
			System.out.print(i+" ");
		}
		System.out.println();
		System.out.println(queue.poll());
		for(int i:queue) {
			System.out.print(i+" ");
		}
		System.out.println();
		System.out.println(queue.poll());
		System.out.println(queue.poll());
		System.out.println(queue.poll());
		System.out.println(queue.remove());
	}
}