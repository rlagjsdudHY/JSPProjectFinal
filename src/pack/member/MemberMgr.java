package pack.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import pack.dbcp.DBConnectionMgr;
 
public class MemberMgr {
	
	Connection				conn 		=		null;
	Statement				stmt			=		null;	
	ResultSet				rS			=		null;  	
	PreparedStatement 		pStmt 		=		null; 
	DBConnectionMgr 		pool 		= 		null;
	

	public MemberMgr() {   // DB 접속완료
		try {
			pool = DBConnectionMgr.getInstance();
			conn = pool.getConnection();

			System.out.println("DB Access OK!!");

		} catch (Exception e) {
			System.out.println("exception : " + e.getMessage());
		}
	}
	
	
/* 관리자 강제 회원탈퇴 시작 */
	
	public String adelMemberName(String uid)  {
		
		String sql ="select uid from member where uid = ?";
		
		
		
		try {			
			
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			
			rS = pStmt.executeQuery();
			
			if(rS.next()) {
			sql = "delete from member where uid= ?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			
			int result = pStmt.executeUpdate();
			if (result > 0) {
				return uid;
			}
		}
		} catch (Exception e) {	
			System.out.println("Exception 이슈 : " + e.getMessage());	
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}
		
		return  null;
		
	}

	
	/* 회원탈퇴 끝 */
	
	
	/* 회원 목록 조회 시작 */
	
	public List<MemberBean> memberList() throws Exception{
		  conn = pool.getConnection();
		  List<MemberBean> memberList = new ArrayList<MemberBean>();
		try{
		    String sql = "SELECT * FROM member order by num desc";
		    pStmt = conn.prepareStatement(sql);
		    rS = pStmt.executeQuery();
		    while(rS.next()) {
		    	MemberBean member = new MemberBean();
		      member.setUid(rS.getString("uid"));
		      member.setUname(rS.getString("uname"));
		      memberList.add(member);
		    } 
		  }catch (Exception e) {
		    	System.out.println("Exception : " + e.getMessage());
		        e.printStackTrace();
		  } finally {
			  pool.freeConnection(conn, pStmt, rS);
		    }
		  return memberList;
		}
	
	
	
	/* 회원 목록 조회 끝 */
	
	/* admin 회원 목록 조회 시작 */
	
	public List<MemberBean> admemberList() throws Exception{
		  conn = pool.getConnection();
		  List<MemberBean> admemberList = new ArrayList<MemberBean>();
		try{
		    String sql = "SELECT * FROM member order by num desc";
		    pStmt = conn.prepareStatement(sql);
		    rS = pStmt.executeQuery();
		    while(rS.next()) {
		    	MemberBean member = new MemberBean();
		      member.setUid(rS.getString("uid"));
		      member.setUname(rS.getString("uname"));
		      member.setGender(rS.getString("Gender"));
		      member.setUbirthday(rS.getString("Ubirthday"));
		      admemberList.add(member);
		    } 
		  }catch (Exception e) {
		    	System.out.println("Exception : " + e.getMessage());
		        e.printStackTrace();
		  } finally {
			  pool.freeConnection(conn, pStmt, rS);
		    }
		  return admemberList;
		}
	
	
	
	/* admin 회원 목록 조회 끝 */
	
/* 로그인 기록 테이블 입력 시작 폐기 */
	
	public String InputLoginData(String uid, int logincnt, String loginip,  String conndev) {
	    try {
	        String sql = "INSERT INTO logininfo (uid, logincnt, loginip, conndev) VALUES (?, ?, ?, ?)";
	        pStmt = conn.prepareStatement(sql);

	        if (rS.next()) {
	            logincnt = rS.getInt("logincnt") + 1;
	        } else {
	            logincnt = 1;
	        }

	        pStmt.setString(1, uid);
	        pStmt.setInt(2, logincnt);
	        pStmt.setString(3, loginip);
	        pStmt.setString(4, conndev);

	        int cnt = pStmt.executeUpdate();

	        if (cnt > 0) {
	            return "success";
	        } else {
	            return "fail";
	        }
	    } catch (Exception e) {
	    	System.out.println("Exception : " + e.getMessage());
	        e.printStackTrace();
	        return "fail : " + e.getMessage();
	    } finally {
	        pool.freeConnection(conn, pStmt, rS);
	    }
	}
	 
	
	/* 로그인 기록 테이블 입력 끝 폐기 */
	
	/* 비밀번호 변경 */
	
	public boolean changePassword(String uid, String upw, String newupw) throws Exception {
	    boolean result = false;
	    try {
	        conn = pool.getConnection();
	        String query = "SELECT * FROM member WHERE uid=? AND upw=?";
	        pStmt = conn.prepareStatement(query);
	        pStmt.setString(1, uid);
	        pStmt.setString(2, upw);
	        rS = pStmt.executeQuery();
	        if (rS.next()) { // 현재 비밀번호가 맞을 경우
	            query = "UPDATE member SET upw=? WHERE uid=?";
	            pStmt = conn.prepareStatement(query);
	            pStmt.setString(1, newupw);
	            pStmt.setString(2, uid);
	            int updatedRows = pStmt.executeUpdate();
	            if (updatedRows > 0) {
	                result = true;
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("SQLException: " + e.getMessage());
	    } finally {
	    	pool.freeConnection(conn, pStmt, rS);
	    
	    }
	    return result;
	}
	
	
	/* 비밀번호 변경 끝 */
	
	/* 비밀번호 변경 확인 과정 */
	public String getPasswordById(String uid ) throws Exception {
	     
		  Connection conn = null;
		    PreparedStatement pStmt = null;
		    ResultSet rS = null;
		    String upw = null;

	    try {
	        conn = pool.getConnection();
	        String sql = "SELECT upw FROM member WHERE uid = ?";
	        pStmt = conn.prepareStatement(sql);
	        pStmt.setString(1, uid);
	        rS = pStmt.executeQuery();

	        if (rS.next()) {
	            upw = rS.getString("upw");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	    	pool.freeConnection(conn, pStmt, rS);
	    }

	    return upw;
	}


	/* 비밀번호 변경 확인과정 끝 */
	
	/* 회원탈퇴 시작 */
	
	public String delMemberName(String uid, String upw) {
		
		String sql ="select uid from member where uid = ? and upw = ?";
		
		
		
		try {			
			
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			pStmt.setString(2, upw);
			
			rS = pStmt.executeQuery();
			
			if(rS.next()) {
			sql = "delete from member where uid= ?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			
			int result = pStmt.executeUpdate();
			if (result > 0) {
				return uid;
			}
		}
		} catch (Exception e) {	
			System.out.println("Exception 이슈 : " + e.getMessage());	
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}
		
		return  null;
		
	}

	
	/* 회원탈퇴 끝 */
	
	
	



	
	/* 아이디 중복 검사 시작(/member/idCheck.jsp) */
	public boolean checkId(String uid) {
				
		boolean res = false;   // 임시 초기화, ID 사용 가능여부를 판별하는 변수
		                                    // true면 입력한 ID는 사용불가
		                                    // false면 입력한 ID는 사용가능		
		try {
						
			String sql = "select count(*) from member where uid = ?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			rS = pStmt.executeQuery();
			
			if (rS.next()) {
				//System.out.println("DB의 테이블에 저장된 입력한 ID의 갯수 : " + rS.getInt(1));
				// rS.getInt(1) 의 반환값이 1이라면 => 사용중인 아이디를 의미함
				// res값에는 true 저장해야 함.
				// rS.getInt(1) 의 반환값이 0이라면 => 사용가능한 아이디를 의미함
				// res값에는 false 저장해야 함, 그러나 이미 false로 초기화되어 있으므로
				// 별도의 작업이 필요없음
				int recordCnt = rS.getInt(1);
				if (recordCnt == 1) res = true;   
				// DB에서 반환된 데이터가 1이라면 입력한 ID로 조회한 데이터가 
				// 있다는 뜻이므로 다시 말하면 사용할 수 없는 아이디를 의미한다.
				
			}
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}
		
		return res;
	}	
	/* 아이디 중복 검사 끝(/member/idCheck.jsp) */
	
	
	
	/* 우편번호 찾기 시작(/member/zipCheck.jsp) */
	public List<ZipcodeBean> zipcodeRead(String area3) {
		
		List<ZipcodeBean> list = new Vector<>(); 
		
		try {
						
			String sql = "select zipcode, area1, area2, area3, area4 ";
			         sql += " from tblZipcode where area3 like ?";

			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, "%"+ area3 +"%");
			rS = pStmt.executeQuery();
			
			while (rS.next()) {
				ZipcodeBean zipBean = new ZipcodeBean();
				zipBean.setZipcode(rS.getString(1));
				zipBean.setArea1(rS.getString(2));
				zipBean.setArea2(rS.getString(3));
				zipBean.setArea3(rS.getString(4));
				zipBean.setArea4(rS.getString(5));
				
				list.add(zipBean);
			}
			
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		} 
		
		return list;
		
	}
	
	/* 우편번호 찾기 끝(/member/zipCheck.jsp) */
	
	

	/* 회원가입 시작 (/member/memberProc.jsp) */
	public boolean insertMember(MemberBean bean) {
	    // 회원 가입이 성공적으로 이루어졌는지 여부를 저장할 변수
	    boolean flag = false;

	    try {
	        // SQL 쿼리문을 작성합니다.
	        String sql = "insert into member (";
	        sql += "uid, upw, uname, uemail, gender, ubirthday, ";
	        sql += "uzipcode, uaddr, uhobby, ujob, jointm) values (";
	        sql += "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now()";
	        sql += ")";
	        // 데이터베이스 연결 객체로부터 PreparedStatement 객체를 생성합니다.
	        pStmt = conn.prepareStatement(sql);
	        // PreparedStatement 객체에 파라미터 값을 설정합니다.
	        pStmt.setString(1, bean.getUid());
	        pStmt.setString(2, bean.getUpw());
	        pStmt.setString(3, bean.getUname());
	        pStmt.setString(4, bean.getUemail());
	        pStmt.setString(5, bean.getGender());
	        pStmt.setString(6, bean.getUbirthday());
	        pStmt.setString(7, bean.getUzipcode());
	        pStmt.setString(8, bean.getUaddr());

	        // 취미(hobby) 값을 쿼리문에 추가합니다.
	        String[] hobby = bean.getUhobby();  // {"여행", "게임", "운동"}
	        String[] hobbyName = {"인터넷", "여행", "게임", "영화", "운동"};
	        char[] hobbyCode = {'0', '0', '0', '0', '0'};
	        // 회원의 취미(hobby)에 해당하는 값을 hobbyCode 배열에 1로 설정합니다.
	        if (hobby != null) {
	            for (int i=0; i<hobby.length; i++) {
	                for (int j=0; j<hobbyName.length; j++) {
	                    if (hobby[i].equals(hobbyName[j])) {    // i : 1, j : 2
	                        hobbyCode[j] = '1';
	                    }
	                }
	            }
	        }
	        // hobbyCode 배열을 문자열로 변환하여 PreparedStatement 객체에 추가합니다.
	        pStmt.setString(9, new String(hobbyCode));

	        pStmt.setString(10, bean.getUjob());
	        // SQL 쿼리문을 실행하고, 영향을 받은 레코드 수(row count)를 반환합니다.
	        int rowCnt = pStmt.executeUpdate();

	        // 영향을 받은 레코드 수가 1일 경우 회원 가입이 성공적으로 이루어졌음을 의미합니다.
	        if (rowCnt == 1) flag = true;

	    } catch (Exception e) {
	        System.out.println("Exception : " + e.getMessage());
	    } finally {
	        // 사용한 데이터베이스 연결 객체와 PreparedStatement 객체를 반납합니다.
	        pool.freeConnection(conn, pStmt);
	    }
	    // 회원 가입이 성공적으로 이루어졌는지 여부를 반환합니다.
	    return flag;
	}
	/* 회원가입 끝 (/member/memberProc.jsp) */
	
	

	/* 로그인 처리 시작 (/member/loginProc.jsp) */
	public boolean loginMember(String uid, String upw, String loginIp, String connDev) throws Exception {
	    boolean loginChkTF = false;
	    Connection conn = null;
	    PreparedStatement pStmt = null;
	    ResultSet rS = null;

	    try {
	        conn = pool.getConnection(); // 데이터베이스 연결 확인

	        String sql = "SELECT COUNT(*) FROM member WHERE uid = ? AND upw = ?";
	        // 로그인시 Union으로 관리자 테이블까지 조회하기
//	        String sql = "SELECT COUNT(*) FROM (SELECT uid, upw FROM member UNION SELECT uid, upw FROM admin ) AS users WHERE users.uid = ? AND users.upw = ?";
	        // Select count(*) from (select uid, upw from member union select uid, upw from admin) as user where user.uid = ? and users.upw = ?;
	        pStmt = conn.prepareStatement(sql);
	        pStmt.setString(1, uid);
	        pStmt.setString(2, upw);
	        rS = pStmt.executeQuery();

	        if (rS.next()) {
	            int recordCnt = rS.getInt(1);
	            if (recordCnt == 1) {
	                loginChkTF = true;

	                // 로그인 정보를 logininfo 테이블에 저장
	                String selectSql = "SELECT logincnt FROM logininfo WHERE uid = ? ORDER BY logintime DESC LIMIT 1";
	                pStmt = conn.prepareStatement(selectSql);
	                pStmt.setString(1, uid);
	                rS = pStmt.executeQuery();

	                int logincnt = 1;
	                if (rS.next()) {
	                    Integer cnt = rS.getInt(1);
	                    if(cnt != null) {
	                        logincnt = cnt + 1;
	                    }
	                }

	                String insertSql = "INSERT INTO logininfo (uid, logincnt, loginip, conndev) VALUES (?, ?, ?, ?) "
	                        + "ON DUPLICATE KEY UPDATE logincnt = logincnt + 1, loginip = ?, conndev = ?";
	                pStmt = conn.prepareStatement(insertSql);
	                pStmt.setString(1, uid);
	                pStmt.setInt(2, logincnt);
	                pStmt.setString(3, loginIp);
	                pStmt.setString(4, connDev);
	                pStmt.setString(5, loginIp);
	                pStmt.setString(6, connDev);
	                int rowsAffected = pStmt.executeUpdate();
	                if (rowsAffected == 1) {
	                    System.out.println("로그인 정보가 성공적으로 저장되었습니다.");
	                } else {
	                    System.out.println("로그인 정보를 저장하는 데 문제가 발생했습니다.");
	                }
	            } else {
	                System.out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("SQLException: " + e.getMessage());
	    } finally {
	        try {
	            if (rS != null) {
	                rS.close();
	            }
	        } catch (SQLException e) {
	            System.out.println("SQLException: " + e.getMessage());
	        }
	        try {
	            if (pStmt != null) {
	                pStmt.close();
	            }
	        } catch (SQLException e) {
	            System.out.println("SQLException: " + e.getMessage());
	        }
	        try {
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            System.out.println("SQLException: " + e.getMessage());
	        }
	    }
	    return loginChkTF;
	}
	/* 로그인 처리 끝 (/member/loginProc.jsp) */
	
	/* 관리자 로그인 처리 시작*/
	public boolean loginAdmin(String uid, String upw) {
		
		
		boolean loginChkTF = false;
		try {		
			
			String sql = "select count(*) from admin where uid = ? and upw = ?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			pStmt.setString(2, upw);
			rS = pStmt.executeQuery();
			
			if (rS.next()) {
				
				int recordCnt = rS.getInt(1);
				if (recordCnt == 1) loginChkTF = true;   
				
			}
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}
		
		return loginChkTF;
		
	}
	
	/* 관리자 로그인 처리 끝*/

	

	
	
	
	/* 회원정보 수정 입력양식 시작 (/member/memberMod.jsp) */
	public MemberBean modifyMember(String uid) {
		
		MemberBean mBean = new MemberBean();
		// Statement => 매개변수가 없을 경우
		// PreparedStatement => 매개변수가 있을 경우
		
		try {
			String sql = "select * from member ";
					sql += "where uid = ?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
			rS = pStmt.executeQuery();
		
			if (rS.next()) {
				mBean.setUid(rS.getString("uid"));
				mBean.setUpw(rS.getString("upw"));
				mBean.setUname(rS.getString("uname"));
				mBean.setUemail(rS.getString("uemail"));
				mBean.setGender(rS.getString("gender"));
				mBean.setUbirthday(rS.getString("ubirthday"));
				mBean.setUzipcode(rS.getString("uzipcode"));
				mBean.setUaddr(rS.getString("uaddr"));
				String hobby = rS.getString("uhobby");
				if (hobby != null) {
					String[] hobbyAry = hobby.split("");
					// "가나다AB"
					hobbyAry = hobby.split("");	// 인덱스0 "가" 인덱스1 "나"
					mBean.setUhobby(hobbyAry);
				}
				mBean.setUjob(rS.getString("ujob"));
			}
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}
		return mBean;
	}
	/* 회원정보 수정 입력양식 끝 (/member/memberMod.jsp) */
	

	
	/* 회원정보 수정 시작 (/member/memberModProc.jsp) */
	public boolean modifyMemberProc(MemberBean bean) {
		
		MemberBean mBean = new MemberBean();
		boolean modRes = false;
		
		try {
			String sql = "update member set upw=?, uname=?, uemail=?, ";
					sql += "gender=?, ubirthday=?, uzipcode=?, ";
					sql += "uaddr=?, uhobby=?, ujob=? ";
					sql += "where uid = ?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, bean.getUpw());
			pStmt.setString(2, bean.getUname());
			pStmt.setString(3, bean.getUemail());
			pStmt.setString(4, bean.getGender());
			pStmt.setString(5, bean.getUbirthday());
			pStmt.setString(6, bean.getUzipcode());
			pStmt.setString(7, bean.getUaddr());
			
			String[] hobby = bean.getUhobby(); // {"여행", "게임", "운동"}
			if (hobby != null) {
				String[] hobbyName = {"인터넷", "여행", "게임", "영화", "운동"};
				char[] hobbyCode = {'0', '0', '0', '0', '0'};
				for (int i=0; i<hobby.length; i++) {
					for (int j=0; j<hobbyName.length; j++) {
						if (hobby[i].equals(hobbyName[j])) { // i : 1, j : 2
							hobbyCode[j] = '1';
						}
					}	
				}
				pStmt.setString(8, new String(hobbyCode));
			} else {
				pStmt.setString(8, null);
			}
			pStmt.setString(9, bean.getUjob());
			pStmt.setString(10, bean.getUid());
			int modCnt = pStmt.executeUpdate();
			if (modCnt == 1) modRes = true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return modRes;
	}
	/* 회원정보 수정 끝 (/member/memberModProc.jsp) */
	
	/* admin 회원정보 수정 시작 (/admin/admemberMod.jsp) */
	public MemberBean getMemberByUid(String uid) {
	    MemberBean mBean = new MemberBean();

	    try {
	    	String sql = "SELECT * FROM member WHERE uid = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, uid);
	    	ResultSet rs = pstmt.executeQuery();

	    	if (rs.next()) {
	    	    mBean.setUid(rs.getString("uid"));
	    	    mBean.setUpw(rs.getString("upw"));
	    	    mBean.setUname(rs.getString("uname"));
	    	    mBean.setUemail(rs.getString("uemail"));
	    	    mBean.setGender(rs.getString("gender"));
	    	    mBean.setUbirthday(rs.getString("ubirthday"));
	    	    mBean.setUzipcode(rs.getString("uzipcode"));
	    	    mBean.setUaddr(rs.getString("uaddr"));
	    	    String hobby = rs.getString("uhobby");
	    	    if (hobby != null) {
	    	        String[] hobbyAry = hobby.split(",");
	    	        mBean.setUhobby(hobbyAry);
	    	    }
	    	    mBean.setUjob(rs.getString("ujob"));
	    	}
	        pstmt.close();
	        rs.close();
	    } catch (SQLException e) {
	        System.out.println("Exception : " + e.getMessage());
	    }
	    return mBean;
	}	

	/* admin 회원정보 수정 입력양식 끝 (/admin/admemberMod.jsp) */	
	
	/* admin 회원정보 수정 시작 (/admin/amemberModProc.jsp) */
	public boolean admodifyMemberProc(MemberBean bean) {
	    boolean admodRes = false;
	    
	    try {
	        String sql = "UPDATE member SET uname = ?, uemail = ?, gender = ?, ubirthday = ?, uzipcode = ?, uaddr = ?, uhobby = ?, ujob = ? WHERE uid = ?";
	        pStmt = conn.prepareStatement(sql);
	        pStmt.setString(1, bean.getUname());
	        pStmt.setString(2, bean.getUemail());
	        pStmt.setString(3, bean.getGender());
	        pStmt.setString(4, bean.getUbirthday());
	        pStmt.setString(5, bean.getUzipcode());
	        pStmt.setString(6, bean.getUaddr());

	        String[] hobby = bean.getUhobby();
	        if (hobby != null) {
	            String[] hobbyName = {"인터넷", "여행", "게임", "영화", "운동"};
	            char[] hobbyCode = {'0', '0', '0', '0', '0'};
	            for (int i=0; i<hobby.length; i++) {
	                for (int j=0; j<hobbyName.length; j++) {
	                    if (hobby[i].equals(hobbyName[j])) {
	                        hobbyCode[j] = '1';
	                    }
	                }   
	            }
	            pStmt.setString(7, new String(hobbyCode));
	        } else {
	            pStmt.setString(7, null);
	        }
	        pStmt.setString(8, bean.getUjob());
	        pStmt.setString(9, bean.getUid());
	        int modCnt = pStmt.executeUpdate();
	        if (modCnt == 1) admodRes = true;
	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	    
	    return admodRes;
	}
	/* admin 회원정보 수정 끝 (/admin/memberModProc.jsp) */
	
	/* 회원탈퇴 시작 (/member/memberQuitProc.jsp) */
	
	
	/* 회원탈퇴 끝 (/member/memberQuitProc.jsp) */
	
	

	
	
	/* 로그인 사용자 이름 반환(/bbs/write.jsp) 시작 */

	public String getMemberName(String uid) {
	
		String uname = "";		
		String sql = null;
		
		try {			
			sql = "select uname from member where uid=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, uid);
		
			rS = pStmt.executeQuery();
			if (rS.next()) {
				uname = rS.getNString(1);				
			}
		
		} catch (Exception e) {	
			System.out.println("Exception 이슈 : " + e.getMessage());	
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}
		
		
		return uname;
	}
	
	/* 로그인 사용자 이름 반환(/bbs/write.jsp) 끝 */
	
	

}







