import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class BlockingQueueTest {
	public static void main(String[] args) {
		BlockingQueue<Integer> queue = new ArrayBlockingQueue<>(1);  // 크기가 1인 블로킹 큐 생성
		
		Producer producer = new Producer(queue);  // 생산자 생성
		Consumer consumer = new Consumer(queue);  // 소비자 생성
		
		producer.start();  // 생산자 스레드 시작
		consumer.start();  // 소비자 스레드 시작
	}
}

class Producer extends Thread {
    private BlockingQueue<Integer> queue;

    public Producer(BlockingQueue<Integer> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        try {
            for (int i = 0; i < 5; i++) {
                queue.put(i);  // 큐에 데이터 넣기 (블로킹 방식)
                System.out.println("생산자: " + i + " 생산");
                Thread.sleep(1000);  // 1초 대기
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

class Consumer extends Thread {
    private BlockingQueue<Integer> queue;

    public Consumer(BlockingQueue<Integer> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        try {
            for (int i = 0; i < 5; i++) {
                Integer data = queue.take();  // 큐에서 데이터 가져오기 (블로킹 방식)
                System.out.println("소비자: " + data + " 소비");
                Thread.sleep(1500);  // 1.5초 대기
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}