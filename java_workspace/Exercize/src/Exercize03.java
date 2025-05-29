import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercize03 {
	public static void main(String[] args) {
		// 1. 주민등록번호(010101-123456)에서 생년월일을 추출
		String residentNumber = "010101-123456";
        String birthDate = residentNumber.split("-")[0];
        System.out.println("생년월일: " + birthDate);
		// 2. 전화번호(010-1234-5678)에서 '-'을 제거
        String phoneNumber = "010-1234-5678";
        String cleanNumber = phoneNumber.replace("-", "");
        System.out.println("하이픈 제거된 전화번호: " + cleanNumber);
		// 3. 상품코드(E20160001)에서 상품카테고리('E')를 추출
        String productCode = "E20160001";
        String category = productCode.substring(0, 1);
        System.out.println("상품 카테고리: " + category);
		// 4. 상품코드(E20160001)에서 년도('2016')를 추출
        String year = productCode.substring(1, 5);
        System.out.println("년도: " + year);
		// 5. 주소록 csv 데이터에서 데이터를 분리
        String csvData = "홍길동,010-1111-2222,hkd@hkd.com";
        String[] parts = csvData.split(",");
        String name = parts[0];
        String phone = parts[1];
        String email = parts[2];
        System.out.println("이름: " + name);
        System.out.println("전화번호: " + phone);
        System.out.println("이메일: " + email);
		// 6. 
        String filePath = "students.csv"; // CSV 파일 경로	
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            boolean isFirstLine = true; // 헤더를 건너뛰기 위한 플래그

            while ((line = br.readLine()) != null) {
                // 첫 번째 줄(헤더)은 건너뜀
                if (isFirstLine) {
                    isFirstLine = false;
                    continue;
                }

                // 콤마(,)를 기준으로 데이터 분리
                String[] part= line.split(",");

                // 학번과 학과명 추출
                if (part.length >= 3) {
                    String studentId = part[0].trim(); // 학번
                    String department = part[2].trim(); // 학과명

                    System.out.println("학번: " + studentId + ", 학과: " + department);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}