package dao3;

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
	 * 사용자 email로 사용자 정보 반환
	 * @param Email
	 * @return
	 * @throws SQLException
	 */
	public User getUserByEmail(String Email) throws SQLException{
		String sql = "select * from tb_comm_users where user_email=? ";
		User user = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, Email);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			user =new User();
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
	 * 사용자 id로 사용자정보 반환
	 * @param id 사용자 아이디
	 * @return 사용자정보
	 * @throws SQLException
	 */
	public User getUserById(String id) throws SQLException {
		String sql = "select * from tb_comm_users where user_id=?";
		User user = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			user =new User();
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
	 * 지정된 사용자 번호에 해당하는 사용자 정보 반환
	 * @param no 사용자번호
	 * @return 사용자정보
	 * @throws SQLException
	 */
		public User getUserByNo(int no) throws SQLException{
		 String  sql = "select * from tb_comm_users where user_no =? ";
		 User user = null;
		 
		 Connection connection = getConnection();
		 PreparedStatement pstmt = connection.prepareStatement(sql);
		 pstmt.setInt(1, no);
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
	
		/**
		 * 수정된 정보가 포함한 사용자정보를 테이블에 반환
		 * @param user 사용자 정보
		 * @throws SQLException
		 */
	public void updateUser(User user) throws SQLException {
		String sql = "update tb_comm_users "
					+"set "
					+"		user_password =?, "
					+"		user_tel = ?, "	
					+"		user_email = ?, "
					+"		user_deleted = ?, "
					+"where "
					+"  user_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, user.getPassword());
		pstmt.setString(2, user.getTel());
		pstmt.setString(3, user.getEmail());
		pstmt.setString(4, user.getDeleted());
		pstmt.setInt(6, user.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
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
