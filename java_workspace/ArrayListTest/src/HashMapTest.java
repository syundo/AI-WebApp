import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class HashMapTest {

	public static void main(String[] args) {
		// key, value 모두 String
		Map<String,String> colors = new HashMap<String,String>();
		colors.put("white", "#000000");
		colors.put("red", "#ff0000");
		colors.put("green", "#00ff00");
		colors.put("blue", "#0000ff");
		colors.put("black", "#ffffff");
		System.out.println(colors.get("white")+" : "+"white");
		System.out.println(colors.get("red")+" : "+"red");
		System.out.println(colors.get("green")+" : "+"green");
		System.out.println(colors.get("blue")+" : "+"blue");
		System.out.println(colors.get("black")+" : "+"black");
		Set<String> keySet = colors.keySet();
		for(String s:keySet) {
			System.out.println(s+"\t"+colors.get(s));
		}
	}
}