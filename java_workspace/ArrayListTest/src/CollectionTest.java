import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class CollectionTest {
	public static void main(String[] args) {
		// ArrayList + Student
		ArrayList<Student> list = new ArrayList<Student>();
		list.add(new Student("홍길동","컴퓨터공학"));
		list.add(new Student("이순신","철학"));
		list.add(new Student());
		list.add(new Student());
		list.add(new Student());
		for(Student s:list) {
			System.out.println("이름: "+s.name+"\t학과: "+s.department);
		}
		// HashMap + Student
		Map<String,Student> students = new HashMap<String,Student>();
		students.put("wg",new Student("왕건","국어국문학"));
		students.put("ssid",new Student("신사임당","수학"));
		Set<String> keySet = students.keySet();
		for(String k:keySet) {
			Student s = students.get(k);
			System.out.println(k);
			System.out.println("이름: "+s.name+" \t학과: "+s.department);
		}
	}
}

class Student {
	String name;
	String department;
	Student() {}
	Student(String name, String department) {
		this.name = name;
		this.department = department;
	}
}