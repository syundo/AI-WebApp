package com.saeyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.saeyan.dto.MemberVO;


public class MemberDAO {
	//singleton pattern
	//→ 생성자를 private로 설정. 직접 instance를 private static으로 생성해서 공유. 메모리 절약
	
	//private 생성자
	private MemberDAO() {}
	
	//instance 생성
	private static MemberDAO instance=new MemberDAO();
	
	// instance return
	public static MemberDAO getInstance() {
		return instance;
	}
	
	//DBCP 연결 + connection 객체 생성
	public Connection getConnection() throws Exception {
		Connection conn = null;
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/myoracle");
		conn = ds.getConnection();
		return conn;
	}
	
	//login method
	public int userCheck(String userid, String pwd) {
		int result=-1;
		String sql="select pwd from member where userid=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("pwd")!=null && rs.getString("pwd").equals(pwd)) {
					result=1; //비밀번호 일치
				}
				else {
					result=0; //비밀번호 불일치
				}
			}else {
				result=-1;//비밀번호
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)    { rs.close(); }
				if(pstmt!=null) { pstmt.close(); }
				if(conn!=null)  { conn.close(); }
			} catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	//id 중복 확인
	public int confirmID(String userid) {
		int result = -1;
		String sql = "select userid from member where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			} else {
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 회원 등록
	public int insertMember(MemberVO mVo) {
		int result = -1;
		String sql = "insert into member values(?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mVo.getName());
			pstmt.setString(2, mVo.getUserid());
			pstmt.setString(3, mVo.getPwd());
			pstmt.setString(4, mVo.getEmail());
			pstmt.setString(5, mVo.getPhone());
			pstmt.setInt(6, mVo.getAdmin());
			result = pstmt.executeUpdate();// 영향을 받은 행의 수 리턴. insert하면 1행이 추가되므로 1이 리턴됨.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 회원 정보 검색
	public MemberVO getMember(String userid) {
		MemberVO mVo = null;
		String sql = "select * from member where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//Model 객체에 입력한 값을 저장
				mVo = new MemberVO();
				mVo.setName(rs.getString("name"));
				mVo.setUserid(rs.getString("userid"));
				mVo.setPwd(rs.getString("pwd"));
				mVo.setEmail(rs.getString("email"));
				mVo.setPhone(rs.getString("phone"));
				mVo.setAdmin(rs.getInt("admin"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)    rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null)  conn.close();
			} catch (Exception e) { e.printStackTrace(); }
		}
		return mVo;
	}

	//회원 정보 수정
	public int updateMember(MemberVO mVo) {
		int result = -1;
		String sql = "update member set pwd=?, email=?,"
				+ "phone=?, admin=? where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mVo.getPwd());
			pstmt.setString(2, mVo.getEmail());
			pstmt.setString(3, mVo.getPhone());
			pstmt.setInt(4, mVo.getAdmin());
			pstmt.setString(5, mVo.getUserid());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}