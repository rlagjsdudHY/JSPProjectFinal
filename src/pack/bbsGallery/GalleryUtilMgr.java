package pack.bbsGallery;

public class GalleryUtilMgr {

public static String replace(String str, String pattern, String replace) {
		
		int s = 0, e = 0;
		StringBuffer result = new StringBuffer();
		
		while ((e = str.indexOf(pattern, s)) >= 0) {
			      // 지역변수 e의 값이 0보다 크면 true, 즉 1이상이면 true
			
			      result.append(str.substring(s, e));
			      result.append(replace);
			      s = e + pattern.length();
			      
		}
		result.append(str.substring(s));
		
		// "가BC가나다".indexOf("가", 1) =>  3
		//  0 123 4 5    
		//  "가BC가나다".indexOf("가", 0) => 0
		//   
		return result.toString();
	}   // replace( )
	
}

