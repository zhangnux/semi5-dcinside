package dao1;

import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import utils.ConnectionUtil;
import vo.Board;
import vo.BoardLiker;
import vo.Comment;
import vo.User;

public class AnimalBoardDao {

	// 외부에서 생성자 호출 금지
	// 기능을 제공하는 객체는 그 객체에서 여러 가지 기능을 제공하기 때문에 
	//  각 기능을 사용할 때마다 그 객체를 생성할 필요가 없다.
	private static AnimalBoardDao self = new AnimalBoardDao();
	private AnimalBoardDao() {}
	public static AnimalBoardDao getInstance() {
		return self;
	}
	
	/**
	 * 게시글 정보를 테이블에 저장
	 * @param board
	 * @throws SQLException
	 */
	public void insertBoard(Board board) throws SQLException{
		String sql = "insert into tb_animal_boards (board_no, board_title, board_writer_no, board_content) "
				   + "values (tb_animal_boards_seq.nextval, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setInt(2, board.getWriter().getNo());
		pstmt.setString(3, board.getContent());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 게시글 수정
	 * @param board
	 * @throws SQLException
	 */
	public void updateBoard(Board board) throws SQLException {
		String sql ="update tb_animal_boards "
				   + "set "
				   + "	board_title = ?, "
				   + "	board_content = ?, "
				   + "	board_like_count = ?,"
				   + "  board_view_count = ?, "
				   + "	board_comment_count = ? "
				   + "where board_no = ?";
			
			Connection connection = ConnectionUtil.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getLikeCount());
			pstmt.setInt(4, board.getViewCount());
			pstmt.setInt(5, board.getCommentCount());
			pstmt.setInt(6, board.getNo());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			connection.close();
	}
	
	/**
	 * 게시글 삭제
	 * @param no 게시글 번호
	 * @throws SQLException
	 */
	public void deleteBoard(int no) throws SQLException {
		String sql = "update tb_animal_boards "
				   + "set "
				   + "	board_deleted = 'Y' "
				   + "where board_no = ?";
		
		Connection connection  = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
	/**
	 * 게시글 정보 가져오기(전체글)
	 * @return
	 * @throws SQLException
	 */
	public List<Board> getBoardList(int begin, int end) throws SQLException{
		
		String sql="select board_no, board_title, board_content, board_like_count, board_comment_count, "
				+ "		   board_view_count, board_created_date, user_name, user_id, user_no "
				+ "from ( select row_number() over(order by B.board_no desc) rn,"
				+ "				 b.board_no, b.board_title, b.board_writer_no, b.board_content, "
				+ "				 b.board_like_count,b.board_view_count,b.board_deleted,b.board_created_date, "
				+ "				 b.board_comment_count, u.user_no, u.user_id, u.user_name"
				+ "       from tb_animal_boards b, tb_comm_users u "
				+ "       where b.board_writer_no = u.user_no "
				+ "		  and b.board_deleted = 'N') "
				+ "where rn >= ? and rn <= ? ";
		
		Board board = null;
		List<Board> boardList = new ArrayList<>();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery(); 
		
		while(rs.next()) {
			
			board = new Board();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCreatedDate(rs.getTimestamp("board_created_date"));
			board.setCommentCount(rs.getInt("board_comment_count"));
			
			user.setName(rs.getString("user_name"));
			
			board.setWriter(user);
			
			boardList.add(board);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardList;

	}
	
	/**
	 * 테이블에 저장된 게시글의 갯수
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRecords () throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_animal_boards";
				
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	/**
	 * 지정된 번호의 게시글 정보 반환
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public Board getBoardDetail(int no) throws SQLException {
		String sql = "select B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content, "
				   + "       B.board_view_count, B.board_like_count, B.board_deleted, B.board_created_date "
				   + "from tb_animal_boards B, tb_comm_users U "
				   + "where B.board_writer_no = U.user_no "
				   + "and B.board_no = ? ";
		
		Board board = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			board = new Board();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setDeleted(rs.getString("board_deleted"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			
			board.setWriter(user);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return board;
	}
	
	/**
	 * 게시글 추천정보 저장
	 * @param boardLiker
	 * @throws SQLException
	 */
	public void insertBoardLiker(BoardLiker boardLiker) throws SQLException {
		String sql = "insert into tb_like_users (like_board_no, like_user_no) "
				   + "values (?, ?)";
	
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardLiker.getBoardNo());
		pstmt.setInt(2, boardLiker.getUserNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 추천 정보 조회
	 * @param boardNo 글 번호
	 * @param userNo 추천인 번호
	 * @return
	 * @throws SQLException
	 */
	public BoardLiker getBoardLiker(int boardNo, int userNo) throws SQLException {
		String sql = "select like_board_no, like_user_no "
				   + "from tb_like_users "
				   + "where like_board_no = ? and like_user_no = ?";
				
		BoardLiker boardLiker = new BoardLiker();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, userNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			boardLiker = new BoardLiker();
			boardLiker.setBoardNo(rs.getInt("board_no"));
			boardLiker.setUserNo(rs.getInt("user_no"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardLiker;
	}
	
	/**
	 * 해당 게시글에 추천한 사용자 목록
	 * @param boardNo
	 * @return
	 * @throws SQLException
	 */
	public List<User> getLikeUsers(int boardNo) throws SQLException {
		String sql = "select u.user_no, u.user_id, u.user_name "
				   + "from tb_like_users l, tb_comm_users u "
				   + "where l.like_user_no = u.user_no "
				   + "and l.like_board_no = ?";
		
		List<User> userList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			User user = new User();
			
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			
			userList.add(user);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return userList;
	}
	
	/**
	 * 댓글 등록(대댓글 아님)
	 * @param no
	 * @throws SQLException
	 */
	public void insertComment(Comment comment) throws SQLException{
														 
		String sql = "insert into tb_animal_board_comments(comment_no, animal_board_no, comment_writer_no, comment_content, comment_group) "
				+ "values(comm_animal_comment_seq.nextval, ?, ?, ?, comm_animal_comment_group_seq.nextval) ";
		
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, comment.getBoard().getNo());
		pstmt.setInt(2, comment.getWriter().getNo());
		pstmt.setString(3, comment.getContent());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 글번호별 댓글 조회
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public List<Comment> getAllComment(int no) throws SQLException {
		
		String sql = "select comment_no, comment_content, comment_deleted, comment_created_date, comment_order, "
				+ "       	 comment_group, board_no, user_no, user_name "
				+ "from (select * "
				+ "      from tb_animal_boards b, tb_animal_board_comments c "
				+ "      where b.board_no = c.animal_board_no ) board, tb_comm_users u "
				+ "where board.comment_writer_no = u.user_no "
				+ "and board.board_no = ? "
				+ "order by board.comment_group, board.comment_no, board.comment_created_date";

		Comment comment = null;
		List<Comment> commentList = new ArrayList<>();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			
			comment = new Comment();
			User user = new User();
			Board board = new Board();
			
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setDeleted(rs.getString("comment_deleted"));
			comment.setCreatedDate(rs.getDate("comment_created_date"));
			comment.setOrder(rs.getInt("comment_order"));
			comment.setGroup(rs.getInt("comment_group"));
			
			board.setNo(rs.getInt("board_no"));
			
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			
			comment.setBoard(board);
			comment.setWriter(user);
			
			commentList.add(comment);
			
		}
		
		rs.close();
		pstmt.close();
		connection.close();

		return commentList;
	}
	
	/**
	 * 댓글 번호로 댓글 정보 조회
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public Comment getCommentInfo(int no) throws SQLException {
		
		String sql = "select * "
				+ "from tb_animal_board_comments "
				+ "where comment_no = ?";
	
		Comment comment = new Comment();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
		comment.setNo(rs.getInt("comment_no"));
		comment.setContent(rs.getString("comment_content"));
		comment.setDeleted(rs.getString("comment_deleted"));
		comment.setCreatedDate(rs.getDate("comment_created_date"));
		comment.setOrder(rs.getInt("comment_order"));
		comment.setGroup(rs.getInt("comment_group"));		
		}
		
		rs.close();		
		pstmt.close();
		connection.close();
		
		return comment;
	}
	
	/**
	 * 댓글번호를 받아 group 갯수 반환
	 * (대댓없음 = 1 / 대댓있음 = 2이상)
	 * @param no
	 * @throws SQLException
	 */
	public int getGroupCount(int no) throws SQLException{
		
		String sql ="select count(*) cnt "
				+ "from tb_animal_board_comments "
				+ "where comment_group = ?";

		int groupCount = 0;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.executeQuery();
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		groupCount = rs.getInt("cnt");
		
		rs.close();		
		pstmt.close();
		connection.close();
		
		return groupCount;
	}
	
	/**
	 * 댓글 그룹 전부 삭제
	 * @param groupNo
	 * @throws SQLException
	 */
	public void deleteCommentGroup(int groupNo) throws SQLException{
		
		String sql ="delete from tb_animal_board_comments "
				+ "where comment_group = ?";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, groupNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}	
	
	/**
	 * 댓글 컬럼 완전 삭제
	 * @param no
	 * @throws SQLException
	 */
	public void deleteCommentColumn(int commentNo) throws SQLException{
		
		String sql ="delete from tb_animal_board_comments "
				+ "where comment_no = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, commentNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
	/**
	 * 덧글번호 전달받아 덧글 삭제('삭제된 댓글입니다' 남기기)
	 * @param no
	 * @throws SQLException
	 */
	public void deleteComment(int no) throws SQLException{
		
		String sql = "update tb_animal_board_comments "
				+ "set comment_deleted = 'Y' "
				+ "where comment_no = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
	/**
	 * 대댓글 등록
	 * @param comment
	 * @throws SQLException
	 */
	public void insertCommetReply(Comment comment) throws SQLException {
		
		String sql = "insert into tb_animal_board_comments(comment_no, animal_board_no, comment_writer_no, comment_content, comment_order, comment_group) "
				+ "values (comm_comment_seq.nextval, ?, ?, ?, ?, ?) ";
		
		Connection connection = ConnectionUtil.getConnection();
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
	 * 조회순 정렬(개념글)
	 * @param begin
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<Board> getBoardArrange(int begin, int end) throws SQLException{
		
		String sql="select board_no, board_title, board_content, board_like_count, board_comment_count, "
				+ "		   board_view_count, board_created_date, user_name, user_id, user_no "
				+ "from ( select row_number() over(order by B.board_view_count desc) rn, "
				+ "				 b.board_no, b.board_title, b.board_writer_no, b.board_content, "
				+ "				 b.board_like_count,b.board_view_count,b.board_deleted,b.board_created_date, "
				+ "				 b.board_comment_count, u.user_no, u.user_id, u.user_name "
				+ "       from tb_animal_boards b, tb_common_users u "
				+ "       where b.board_writer_no = u.user_no "
				+ "		  and b.board_deleted = 'N') "
				+ "where rn >= ? and rn <= ? ";
		
		Board board = null;
		List<Board> boardList = new ArrayList<>();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			
			board = new Board();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCreatedDate(rs.getTimestamp("board_created_date"));
			board.setCommentCount(rs.getInt("board_comment_count"));
			
			user.setName(rs.getString("user_name"));
			
			board.setWriter(user);
			
			boardList.add(board);			
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardList;
		
	}
	
	
	
}
