
public class UserException {
	public static void main(String[] args) {
		Check c = new Check();
		try {
//			c.checkScore(-5);
//			c.checkScore(105);
			c.checkScore(70);
		}
		catch(MinusException | OverException e) {
			System.out.println(e.getMessage());
		}
	}
}

class MinusException extends Exception {
	public MinusException() {
		super();
	}
	public MinusException(String message) {
		super(message);
	}
}

class OverException extends Exception {
	public OverException() {
		super();
	}
	public OverException(String message) {
		super(message);
	}
}

class Check {
	void checkScore(int score) throws MinusException, OverException {
		if(score<0) {
			throw new MinusException("예외 발생: 음수 입력");
		}
		else if(score>100) {
			throw new OverException("예외 발생: 100점 초과");
		}
		else {
			System.out.println("정상적인 값");
		}
	}
}