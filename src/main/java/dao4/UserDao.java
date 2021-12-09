package dao4;

import static utils.ConnectionUtil.getConnection;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.User;


public class UserDao {
	
	private static UserDao self = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return self;
	}
	
	/**
	 * 지정된 번호에 해당하는 사용자정보를 반환한다.
	 * @param no 사용자번호
	 * @return 사용자정보
	 * @throws SQLException
	 */
	public User getUserByNo(int no) throws SQLException {
		String sql = "select * from tb_comm_users where user_no = ?";
		User user = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	/**
	 * 지정된 이메일에 해당하는 사용자정보를 반환한다.
	 * @param email 사용자 이메일
	 * @return 사용자정보
	 * @throws SQLException
	 */
	public User getUserByEmail(String email) throws SQLException {
		String sql = "select * from tb_comm_users where user_email = ?";
		User user = null;
		
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
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	/**
	 * 지정된 아이디에 해당하는 사용자정보를 반환한다.
	 * @param id 사용자 아이디
	 * @return 사용자정보
	 * @throws SQLException
	 */
	public User getUserById(String id) throws SQLException {
		String sql = "select * from tb_comm_users where user_id = ?";
		User user = null;
		
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
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	/**
	 * 수정된 정보에 해당하는 사용자정보를 테이블에 반영한다.
	 * @param user 사용자정보
	 * @throws SQLException
	 */
	public void updateUser(User user) throws SQLException {
		String sql = "update tb_comm_users "
				   + "set "
				   + "	user_password = ?, "
				   + "	user_tel = ?, "
				   + "	user_email = ?, "
				   + "	user_updated_date = sysdate "
				   + "where"
				   + "	user_no = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, user.getPassword());
		pstmt.setString(2, user.getTel());
		pstmt.setString(3, user.getEmail());
		pstmt.setInt(4, user.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정된 사용자번호의 사용자정보를 삭제처리한다.
	 * @param no 사용자번호
	 * @throws SQLException
	 */
	public void deleteUser(int no) throws SQLException {
		String sql = "update tb_comm_users "
				   + "set "
				   + "	user_deleted = 'Y', "
				   + "	user_deleted_date = sysdate, "
				   + "	user_updated_date = sysdate "
				   + "where user_no = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정된 사용자정보를 테이블에 저장한다.
	 * @param user 사용자 정보
	 * @throws SQLException
	 */
	public void insertUser(User user) throws SQLException {
		String sql = "insert into tb_comm_users(user_no, user_id, user_password, user_name, user_tel, user_email) "
				   + "values(comm_user_seq.nextval, ?,?,?,?,?)";
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


