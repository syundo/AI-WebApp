import java.util.Stack;

public class StackTest {
	public static void main(String[] args) {
		Stack<Integer> stack = new Stack<Integer>();
		stack.push(1);
		stack.push(2);
		stack.push(3);
		for(int a:stack) {
			System.out.print(a+" ");
		}
		System.out.println();
		System.out.println(stack.pop());
		for(int a : stack) {
			System.out.print(a+" ");
		}
		System.out.println();
		System.out.println(stack.peek());
	}
}