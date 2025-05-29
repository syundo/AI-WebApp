package ch20;

public class ELBean {
	//field는 모두 private
	private String siteName;
	// getter. 읽기용
	public String getSiteName() {
		return siteName;
	}
	// setter. 쓰기용
	public void setSiteName(String siteName) {
		this.siteName=siteName;
	}
}