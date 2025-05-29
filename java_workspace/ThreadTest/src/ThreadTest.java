
public class ThreadTest {
	public static void main(String[] args) {
		MyThread t1 = new MyThread();
		t1.start();
		MyThread2 t2 = new MyThread2();
		t2.start();
	}
}

class MyThread extends Thread {
	@Override
	public void run() {
		for(int i=0;i<100;i++) {
			System.out.println("Thread"+i);
			try {
				Thread.sleep(500);
			}
			catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

class MyThread2 extends Thread {
	@Override
	public void run() {
		for(int i=0;i<100;i++) {
			System.out.println("Thread");
			try {
				Thread.sleep(500);
			}
			catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}