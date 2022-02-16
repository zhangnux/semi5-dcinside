package dao6;

import vo.User;
import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	
	private static UserDao self = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return self;
	}
	
	public User getUserById(String id) throws SQLException {
		User user = null;
		
		String sql = "select user_no, user_id, user_password "
				   + "      ,user_name, user_tel, user_email "
				   + "from   tb_comm_users "
				   + "where  user_id = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	public User getUserByEmail(String email) throws SQLException {
		User user = null;
		
		String sql = "select user_no, user_id, user_password "
				   + "      ,user_name, user_tel, user_email "
				   + "from   tb_comm_users "
				   + "where  user_email = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	public void insertUser(User user) throws SQLException {
		String sql = "insert into tb_comm_users (user_no, user_id, user_password, "
				   + "user_name, user_tel, user_email) "
				   + "values (comm_user_seq.nextval, ?, ?, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, user.getId());
		pstmt.setString(2, user.getPassword());
		pstmt.setString(3, user.getName());
		pstmt.setString(4, user.getTel());
		pstmt.setString(5, user.getEmail());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
}
