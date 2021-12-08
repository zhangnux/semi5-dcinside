package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtil {

	private static final String user_name="semi_dc";
	private static final String password="zxcv1234";
	private static final String url="jdbc:oracle:thin:@localhost:1521:xe";
	
	static {
		try {
			// 드라이버 로드
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	public static Connection getConnection() throws SQLException{
		return DriverManager.getConnection(url, user_name, password);
	}
	
}

