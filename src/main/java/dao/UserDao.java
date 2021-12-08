package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import utils.ConnectionUtil;
import vo.User;

public class UserDao {

	private static UserDao self = new UserDao();
	private UserDao() {}
	
	public static UserDao getInstance() {
		return self;
	}
	
	public void insertUser(User user) throws SQLException{
		
		String sql = "insert into tb_comm_users(user_no, user_id, user_password, user_name, user_tel, user_email) "
				+ "values(comm_user_seq.nextval, ?, ?, ?, ?, ?)";
		
		Connection connection = ConnectionUtil.getConnection();
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
	
	/**
	 * 메일로 정보 찾기(중복 확인용)
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public User getUserByEmail(String email) throws SQLException{
		
		String sql = "select * "
				+ "from tb_comm_users "
				+ "where user_email = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
				
		User user = null;
		
		if(rs.next()) {
			
			user = new User();
			
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreateDate(rs.getDate("user_created_date"));
			
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	
	/**
	 * 아이디로 정보 찾기(중복 확인용)
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public User getUserById(String id) throws SQLException {
		
		String sql = "select * "
				+ "from tb_comm_users "
				+ "where user_id=?";
		
		User user = null;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			user = new User();
			
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreateDate(rs.getDate("user_created_date"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
	
		return user;
	}
	
	
	
}
