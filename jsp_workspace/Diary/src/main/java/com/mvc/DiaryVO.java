package com.mvc;

public class DiaryVO {
	private String no; 
    private String weather;
    private String title;
    private String content;
    private java.sql.Date date;
    
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Date getDate() {
		return date;
	}
	public void setDate(java.sql.Date date) {
		this.date = date;
	}
}