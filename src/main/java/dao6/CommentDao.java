package dao6;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Board;
import vo.Comment;
import vo.User;

/**
 * 게시판에 대한 기능을 담고 있는 클래스
 * 
 * @author lee
 *
 */
public class CommentDao {

	// 싱글턴 객체 생성
	private static CommentDao self = new CommentDao();
	private CommentDao() {}
	public static CommentDao getInstance() {
		return self;
	}

	/**
	 * 
	 * @param comment
	 * @throws SQLException
	 */
	public void insertComment(Comment comment) throws SQLException {
		String sql = "insert into tb_hotplace_board_comments (comment_no "
				   + "                                       ,hotplace_board_no "
				   + "                                       ,comment_writer_no "
				   + "                                       ,comment_content "
				   + "                                       ,comment_order "
				   + "                                       ,comment_group) "
				   + "values (comm_board_comment_seq.nextval, ?, ?, ?, ?, comm_board_comment_group_seq.nextval) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, comment.getBoard().getNo());
		pstmt.setInt(2, comment.getWriter().getNo());
		pstmt.setString(3, comment.getContent());
		pstmt.setInt(4, comment.getOrder());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void insertCommentReply(Comment comment) throws SQLException {
		
		String sql = "insert into tb_hotplace_board_comments(comment_no "
				   + "									     ,hotplace_board_no "
				   + "									     ,comment_writer_no "
				   + "									     ,comment_content "
				   + "									     ,comment_order "
				   + "   								     ,comment_group) "
				   + "values (comm_board_comment_seq.nextval, ?, ?, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, comment.getBoard().getNo());
		pstmt.setInt(2, comment.getWriter().getNo());
		pstmt.setString(3, comment.getContent());
		pstmt.setInt(4, comment.getOrder());
		pstmt.setInt(5, comment.getGroup());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}

	/**
	 * 
	 * @param comment
	 * @return
	 * @throws SQLException
	 */
	public List<Comment> getCommentListByBoard(Board board) throws SQLException { 
		List<Comment> comments = new ArrayList<>(); 
		Comment comment = null;
		User user = null;
	  
		String sql = "select * "
				   + "from (select *"
				   + "      from tb_hotplace_boards b, tb_hotplace_board_comments c "
				   + "      where b.board_no = c.hotplace_board_no) board, tb_comm_users u "
				   + "where board.comment_writer_no = u.user_no "
				   + "and board.board_no = ? "
				   + "order by board.comment_group, board.comment_created_date ";
		  
		Connection connection = getConnection(); 
		PreparedStatement pstmt = connection.prepareStatement(sql); 
		pstmt.setInt(1, board.getNo());
		ResultSet rs = pstmt.executeQuery();
		  
		while (rs.next()) { 
			comment = new Comment(); 
			
			user = new User();
			user.setId(rs.getString("user_id"));
			
			comment.setNo(rs.getInt("comment_no"));
			comment.setBoard(board); 
			comment.setWriter(user);
			comment.setContent(rs.getString("comment_content"));
			comment.setDeleted(rs.getString("comment_deleted"));
			comment.setCreatedDate(rs.getTimestamp("comment_created_date"));
			comment.setOrder(rs.getInt("comment_order"));
			comment.setGroup(rs.getInt("comment_group"));
			  
			comments.add(comment);
		}
		  
		rs.close();
		pstmt.close();
		connection.close();
		  
		return comments; 
	}
	
	public void deleteComment(int commentNo) throws SQLException {
		String sql = "delete "
				   + "from tb_hotplace_board_comments "
				   + "where comment_no= ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, commentNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public Comment getComment(int commentNo) throws SQLException {
		Comment comment = null;
		Board board = null;
		User user = null;
		
		String sql = "select * "
				   + "from tb_hotplace_board_comments "
				   + "where comment_no= ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, commentNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			comment = new Comment();
			user = new User();
			board = new Board();
			
			user.setNo(rs.getInt("comment_writer_no"));
			board.setNo(rs.getInt("hotplace_board_no"));
			
			comment.setNo(rs.getInt("comment_no"));
			comment.setBoard(board);
			comment.setWriter(user);
			comment.setContent(rs.getString("comment_content"));
			comment.setDeleted(rs.getString("comment_deleted"));
			comment.setCreatedDate(rs.getTimestamp("comment_created_date"));
			comment.setOrder(rs.getInt("comment_order"));
			comment.setGroup(rs.getInt("comment_group"));
		}
		
		pstmt.close();
		connection.close();
		
		return comment;
	}
}