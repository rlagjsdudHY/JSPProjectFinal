package pack.bbs;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack.bbs.UtilMgr;
import pack.dbcp.DBConnectionMgr;

public class BoardMgr {

	private DBConnectionMgr pool;
	
	Connection 				conn 		= 		null;
	PreparedStatement 		pStmt 		= 		null;
	Statement				stmt 		= 		null;
	ResultSet 				rS 			= 		null;
	
	private static final String SAVEFOLER = "D:\\AJR_20230126\\HY\\silsp\\p08_JSP\\230502projectFile\\WebContent\\fileupload";
	// 작업자의 워크스페이스가 다르다면 파일이 업로드되는 경로도 그에 맞게 설정해야 함.
	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;     // 5Mbyte 제한

	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
			conn = pool.getConnection();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}

	}
	
/* 댓글 불러오기 메서드 시작 */
	
	public Vector<String[]> getCommentList(int board_idx) {
		String sql = null;
		Vector<String[]> commentList = new Vector<String[]>();
	    
		try {
		    sql = "SELECT * FROM Comment WHERE board_idx=?";
		    pStmt = conn.prepareStatement(sql);
		    pStmt.setInt(1, board_idx);
		    rS = pStmt.executeQuery();

		    while (rS.next()) {
		        String[] comment = new String[5];
		        comment[0] = rS.getString("uid");
		        comment[1] = rS.getString("uname");
		        comment[2] = rS.getString("content");
		        comment[3] = rS.getString("ip");
		        comment[4] = rS.getTimestamp("regtm").toString();
		        commentList.add(comment);
		    }
		} catch (SQLException e) {
		    e.printStackTrace();
		} finally {
		    pool.freeConnection(conn, pStmt, rS);
		}

		return commentList;
	}
	
	/* 댓글 불러오기 메서드 끝  */
	
	/* 댓글 달기 메서드 시작*/
	public void comment(HttpServletRequest req) {
		   String sql = null;

		    try {
		        sql = "insert into Comment (uid, uname, content, ip,board_idx) values (?,?,?,?,?)";
		        pStmt = conn.prepareStatement(sql);
		        pStmt.setString(1, req.getParameter("uid"));
		        pStmt.setString(2, req.getParameter("uname"));
		        pStmt.setString(3, req.getParameter("comment"));
		        pStmt.setString(4, req.getParameter("ip"));
		        pStmt.setString(5, req.getParameter("num"));
		        int exeCnt = pStmt.executeUpdate(); // 쿼리 실행 및 실제 적용된 데이터 개수 반환
		        // exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		    } catch (Exception e) {
		        System.out.println("Exception : " + e.getMessage());
		    } finally {
		        pool.freeConnection(conn, pStmt);
		    }
		}
	/* 댓글 달기 메서드 끝*/
	
	
	/* 게시글 수정페이지 (/bbs/updateProc.jsp) 시작 */
	public int updateBoard(BoardBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {
			sql = "update tblboard set uname=?, subject=?, content=? where num=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, bean.getUname());
			pStmt.setString(2, bean.getSubject());
			pStmt.setString(3, bean.getContent());
			pStmt.setInt(4, bean.getNum());
			exeCnt = pStmt.executeUpdate();
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt);
		}

		return exeCnt;
	}

	/* 게시글 수정페이지 (/bbs/updateProc.jsp) 끝 */
	
	/* 게시글 수정 페이지 테스트 시작*/
	
	public void updateBoardRe(HttpServletRequest req) {
	    String sql = null;
	    MultipartRequest multi = null;
	    int filesize = 0;
	    File file = new File(SAVEFOLER);

	    String filename = null;
	    try {
	        multi = new MultipartRequest(req, SAVEFOLER, maxSize, encType, new DefaultFileRenamePolicy());
	        sql = "update tblboard set uname=?, subject=?, content=? where num=?";
	        pStmt = conn.prepareStatement(sql);
	        pStmt.setString(1, multi.getParameter("uname"));
	        pStmt.setString(2, multi.getParameter("subject"));
	        pStmt.setString(3, multi.getParameter("content"));
	        pStmt.setInt(4, Integer.parseInt(multi.getParameter("num")));
	        int exeCnt = pStmt.executeUpdate(); // 쿼리 실행 및 실제 적용된 데이터 개수 반환
	        // exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

	    } catch (Exception e) {
	        System.out.println("Exception : " + e.getMessage());
	    } finally {
	        pool.freeConnection(conn, pStmt);
	    }
	}
	/* 게시글 수정 페이지 테스트 끝 */
	

	

/*  게시판 입력(/bbs/postProc.jsp) 시작  */
	public void insertBoard(HttpServletRequest req) {

		String sql = null;
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;

		try {
			sql = "select max(num) from tblboard";
			pStmt = conn.prepareStatement(sql);
			rS = pStmt.executeQuery();

			int ref = 1; // 답변글 작성용, 원본글의 글번호(num)와 일치
			if (rS.next())
				ref = rS.getInt(1) + 1;
			// 현재 DB tblBoard에 데이터가 3개(num 컬럼에 1, 2, 3)가
			// 있다고 가정하면 max(num)는 3을 반환함. 
			// 그러므로 새 글번호를 참조하는 DB의 컬럼 ref는 4가 됨.

			File file = new File(SAVEFOLER);

			if (!file.exists())
				file.mkdirs();

			multi = new MultipartRequest(req, SAVEFOLER, maxSize, encType, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");

			if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}

			sql = "insert into tblboard (";
			sql += "uid, uname, subject, content, ref, pos, depth, ";
			sql += "regtm, ip, readcnt, filename, filesize) values (";
			sql += "?, ?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?)";

			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, multi.getParameter("uid"));
			pStmt.setString(2, multi.getParameter("uname"));
			pStmt.setString(3, multi.getParameter("subject"));
			pStmt.setString(4, content);
			pStmt.setInt(5, ref);
			pStmt.setString(6, multi.getParameter("ip"));
			pStmt.setString(7, filename);
			pStmt.setInt(8, filesize);
			pStmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

	}
	/*  게시판 입력(/bbs/postProc.jsp) 끝  */
	
	


	/*  게시판 리스트 출력 (/bbs/list.jsp) 시작    */
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {

		Vector<BoardBean> vList = new Vector<>();
		String sql = null;

		try {
			
			if (keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 경우
				sql = "select * from tblboard "
						+ "order by ref desc, pos asc limit ?, ?";
				pStmt = conn.prepareStatement(sql);
				pStmt.setInt(1, start);
				pStmt.setInt(2, end);
			} else {
				// 검색어가 있을 경우
				sql = "select * from tblboard "
						+ "where "+ keyField +" like ? "
						+ "order by ref desc, pos asc limit ?, ?";
				pStmt = conn.prepareStatement(sql);
				pStmt.setString(1, "%"+keyWord+"%");
				pStmt.setInt(2, start);
				pStmt.setInt(3, end);				
			}
			
			
			rS = pStmt.executeQuery();

			while (rS.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rS.getInt("num"));
				bean.setUname(rS.getString("uname"));
				bean.setSubject(rS.getString("subject"));
				bean.setPos(rS.getInt("pos"));
				bean.setRef(rS.getInt("ref"));
				bean.setDepth(rS.getInt("depth"));
				bean.setRegtm(rS.getString("regtm"));
				bean.setReadcnt(rS.getInt("readcnt"));
				bean.setFilename(rS.getString("filename"));
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

		return vList;
	}


	/*  게시판 리스트 출력(/bbs/list.jsp) 끝  */

	

	/* 총 게시물 수(/bbs/list.jsp) 시작  */
	public int getTotalCount(String keyField, String keyWord) {

		String sql = null;
		int totalCnt = 0;

		try {
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblboard";
				pStmt = conn.prepareStatement(sql);
			} else {
				sql = "select count(*) from tblboard ";
				sql += "where "+keyField+" like ?";
				pStmt = conn.prepareStatement(sql);
				pStmt.setString(1, "%" + keyWord + "%");
			}

			rS = pStmt.executeQuery();

			if (rS.next()) {
				totalCnt = rS.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

		return totalCnt;
	}
	/* 총 게시물 수(/bbs/list.jsp) 끝  */
	

	
	
	
	/* 게시판 뷰페이지 조회수 증가 시작 (/bbs/read.jsp, 내용보기 페이지) */
	public void upCount(int num) {
		String sql = null;

		try {
			sql = "update tblboard set readcnt = readcnt+1 where num=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, num);
			pStmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt);
		}

	} 
	/* 게시판 뷰페이지 조회수 증가 끝 (/bbs/read.jsp, 내용보기 페이지) */
	
	

	/*	상세보기 페이지 게시글 출력 시작 (/bbs/read.jsp, 내용보기 페이지) */
	public BoardBean getBoard(int num) {
		String sql = null;

		BoardBean bean = new BoardBean();
		try {
			sql = "select * from tblboard where num=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, num);
			rS = pStmt.executeQuery();

			if (rS.next()) {
				bean.setNum(rS.getInt("num"));
				bean.setUid(rS.getString("uid"));
				bean.setUname(rS.getString("uname"));
				bean.setSubject(rS.getString("subject"));
				bean.setContent(rS.getString("content"));
				bean.setPos(rS.getInt("pos"));
				bean.setRef(rS.getInt("ref"));
				bean.setDepth(rS.getInt("depth"));
				bean.setRegtm(rS.getString("regtm"));
				bean.setReadcnt(rS.getInt("readcnt"));
				bean.setFilename(rS.getString("filename"));
				bean.setFilesize(rS.getInt("filesize"));
				bean.setIp(rS.getString("ip"));
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

		return bean;
	} 
	/*	상세보기 게시글 출력 끝 (/bbs/read.jsp, 내용보기 페이지) */

	
	/*
	public static void main(String[] args) {
		System.out.println(len);
	}
	*/

	
	/* 상세보기 페이지 파일다운로드 시작 (/bbs/read.jsp) */
	public static int len;
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
		try {
			req.setCharacterEncoding("UTF-8");
			String filename = req.getParameter("filename"); // 다운로드할 파일 매개변수명 일치
			
			File file = new File(SAVEFOLER + File.separator + filename);

			byte[] b = new byte[(int) file.length()];			
			res.setHeader("Accept-Ranges", "bytes");
			req.getHeader("User-Agent");			
			res.setContentType("application/smnet;charset=UTF-8");
			
			res.setHeader("Content-Disposition", "attachment;fileName=" +
							new String(filename.getBytes("UTF-8"), "ISO-8859-1"));
			

			out.clear();
			out = pageContext.pushBody();

			if (file.isFile()) {
				BufferedInputStream fIn = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream fOuts = new BufferedOutputStream(res.getOutputStream());
				int read = 0;
				while ((read = fIn.read(b)) != -1) {
					fOuts.write(b, 0, read);
				}
				fOuts.close();
				fIn.close();

			}

		} catch (Exception e) {
			System.out.println("파일 처리 이슈 : " + e.getMessage());
		}

	}

	/* 상세보기 페이지 파일다운로드 끝 (/bbs/read.jsp) */
	
	

	/* 게시글 삭제(/bbs/delete.jsp) 시작 */
	public int deleteBoard(int num) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "select filename from tblboard where num=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, num);
			rS = pStmt.executeQuery();

			if (rS.next() && rS.getString(1) != null) {
				if (!rS.getString(1).equals("")) {
					String fName = rS.getString(1);
					
					String fileSrc = SAVEFOLER + "/" + fName;
					File file = new File(fileSrc);

					if (file.exists())  file.delete(); // 파일 삭제 실행

				}
			}
			//////////// 게시글의 파일 삭제 끝 ///////////////

			//////////// 게시글 삭제 시작 ///////////////
			sql = "delete from tblboard where num=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, num);
			exeCnt = pStmt.executeUpdate();
			//////////// 게시글 삭제 끝 ///////////////

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

		return exeCnt;
	}

	/* 게시글 삭제(/bbs/delete.jsp) 끝 */
		
	

	/* 게시글 답변 페이지 (/bbs/replyProc.jsp) 시작 */
	public int replyBoard(BoardBean bean) {

		String sql = null;
		int resCnt = 0;
	

		try {

			sql = "insert into tblboard (";
			sql += "uid, uname, content, subject, ";
			sql += "ref, pos, depth,  ";
			sql += "regtm, readcnt, ip) values (";
			sql += "?, ?, ?, ?, ?, ?, ?, now(), 0, ?)";

			int depth = bean.getDepth() + 1;
			int pos = bean.getPos() + 1;
			
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, bean.getUid());
			pStmt.setString(2, bean.getUname());
			pStmt.setString(3, bean.getContent());
			pStmt.setString(4, bean.getSubject());
			pStmt.setInt(5, bean.getRef());
			pStmt.setInt(6, pos);
			pStmt.setInt(7, depth);
			pStmt.setString(8, bean.getIp());
			resCnt = pStmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

		return resCnt;  
	}
	/* 게시글 답변 페이지 (/bbs/replyProc.jsp) 끝 */
	
	

	/* 답변글 끼어들기 시작 (/bbs/replyProc.jsp) */
	public int replyUpBoard(int ref, int pos) {

		String sql = null;
		int cnt = 0;		

		try {

			//////////// 게시글의 포지션 증가 시작 ///////////////
			sql = "update tblboard set pos = pos + 1 ";
			sql += "where ref = ? and pos > ?";
			
			pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, ref);
			pStmt.setInt(2, pos);
			cnt = pStmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			pool.freeConnection(conn, pStmt, rS);
		}

		
		return cnt;
	}	
	/* 답변글 끼어들기 끝 (/bbs/replyProc.jsp) */
	

}
