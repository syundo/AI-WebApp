
public class WaitNotify {

	public static void main(String[] args) {
		DataBox dataBox = new DataBox() {};
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

class DataBox {
	int data;
	synchronized void inputData(int data) {
		this.data=data;
		System.out.println("입력 데이터: "+data);
	}
	synchronized void outputData() {
		System.out.println("출력 데이터: "+data);
	}
}