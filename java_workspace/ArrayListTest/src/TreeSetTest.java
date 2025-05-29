import java.util.NavigableSet;
import java.util.TreeSet;

public class TreeSetTest {
	public static void main(String[] args) {
		TreeSet<Integer> tSet = new TreeSet<>();
		for(int i=50; i>0; i-=2) {
			tSet.add(i);
		}
		for(int j:tSet) {
			System.out.print(j+" ");
		}
		System.out.println();
		System.out.println(tSet.first());
		System.out.println(tSet.last());
		System.out.println(tSet.lower(26));
		System.out.println(tSet.higher(26));
		
		NavigableSet<Integer> descendingSet = tSet.descendingSet();
		for(int k:descendingSet) {
			System.out.print(k+" ");
		}
		System.out.println();
		TreeSet<Integer> tSet2 = new TreeSet<>();
		tSet2.add(20);
		tSet2.add(10);
		tSet2.add(30);
		tSet2.add(50);
		tSet2.add(40);
		for(int l:tSet2) {
			System.out.print(l+" ");
		}
	}
}