
public class ThreadTest2 {
	public static void main(String[] args) {
		MThread t1 = new MThread();
		Thread mt1 = new Thread(t1);
		mt1.start();
		MThread2 t2 = new MThread2();
		Thread mt2 = new Thread(t2);
		mt2.start();
	}
}

class MThread implements Runnable {
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

class MThread2 implements Runnable {
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