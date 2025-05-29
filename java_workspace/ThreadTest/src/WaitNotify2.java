
public class WaitNotify2 {

	public static void main(String[] args) {
		DataBox2 dataBox = new DataBox2() {};
		// Anonymous class
		Thread t1 = new Thread() {
			@Override
			public void run() {
				for(int i=1;i<9;i++) {
					dataBox.inputData(i);
				}
			}
		};
		// Anonymous class
		Thread t2 = new Thread() {
			@Override
			public void run() {
				for(int i=1;i<9;i++) {
					dataBox.outputData();
				}
			}
		};
		t1.start();
		t2.start();
	}
}

class DataBox2 {
	boolean isEmpty = true;
	int data;
	synchronized void inputData(int data) {
		if(!isEmpty) {
			try {
				wait();
			}
			catch(InterruptedException e) {}
		}
		this.data=data;
		isEmpty = false;
		System.out.println("입력 데이터: "+data);
		notify();
	}
	synchronized void outputData() {
		if(isEmpty) {
			try {
				wait();
			}
			catch(InterruptedException e) {}
		}
		isEmpty = true;
		System.out.println("출력 데이터: "+data);
		notify();
	}
}