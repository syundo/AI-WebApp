
public class ThreadProperties {
	public static void main(String[] args) {
		System.out.println("코어 수: "+Runtime.getRuntime().availableProcessors());
		for(int i=0;i<3;i++) {
			Thread t3 = new MyThread3();
			t3.start();
		}
		try {
			Thread.sleep(1000);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		for(int i=0;i<10;i++) {
			Thread t3 = new MyThread3();
			t3.setName(i+"번째 쓰레드");
			if(i==9) {
				t3.setPriority(10);
			}
			t3.start();
		}
	}
}

class MyThread3 extends Thread {
	@Override
	public void run() {
		for(long i=0;i<1000000000;i++) {
		}
		System.out.println(getName()+"우선순위: "+getPriority());
	}
}