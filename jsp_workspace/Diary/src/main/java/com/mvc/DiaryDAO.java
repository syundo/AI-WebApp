package com.mvc;

import common.DBCP;

public class DiaryDAO extends DBCP {
	public DiaryDAO() {
		super();
	}

    // 일기 데이터를 받아 DB에 추가
    public int insertWrite(DiaryVO dVo) {
        int result = 0;
        try {
            String query = "INSERT INTO diary ( "
                         + " no, weather, title, content, wdate) "
                         + " VALUES (seq_diary.nextval,?,?,?,sysdate)";
            psmt = con.prepareStatement(query);
            psmt.setString(1, dVo.getWeather());
            psmt.setString(2, dVo.getTitle());
            psmt.setString(3, dVo.getContent());
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("일기 작성 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }
}