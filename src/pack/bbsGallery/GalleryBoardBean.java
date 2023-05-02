package pack.bbsGallery;

public class GalleryBoardBean {
	private int num;    //글번호
	private String uid; //작성자ID
	private String uname; 
	private String subject; //글제목
	private String content; //글내용
	private int pos;  //답변글용(position, 답변글 순서)
	private int ref;  //답변글용(reference, 원본글/답변글 기준)
	private int depth;  //답변글용(답변글 들여쓰기)
	private String regtm;	// 게시글 등록시간
	private String ip;        // 게시글 작성자 IP주소
	private int readcnt;   // 조회수
	private String filename;  // 첨부파일
	private int filesize;         // 첨부파일 크기
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getRegtm() {
		return regtm;
	}
	public void setRegtm(String regtm) {
		this.regtm = regtm;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	
	
	
}
