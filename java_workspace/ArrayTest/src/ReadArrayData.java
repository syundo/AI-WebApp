import java.util.Arrays;

public class ReadArrayData {
	public static void main(String[] args) {
		int [] array = new int[] {3,4,5,6,7};
		System.out.println(array.length);
		for(int k:array) {
			System.out.print(k+" ");
		}
		System.out.println();
		System.out.println(Arrays.toString(array));
	}
}