package dao4;

import static utils.ConnectionUtil.getConnection;



import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.User;
import vo.Board;
import vo.BoardLiker;
import vo.Comment;

import utils.ConnectionUtil;

public class SoccerBoardDao {
	
	private static SoccerBoardDao self = new SoccerBoardDao();
	private SoccerBoardDao() {}
	public static SoccerBoardDao getInstance() {
		return self;
	}
	
	public List<Board> getAllBoard() throws SQLException {
		String sql = "	select  board_no, board_title, board_content, board_like_count, "
	            + "         	board_view_count, board_created_date, user_name, user_id, user_no "
	            + "		from ( select * "
	            + "        		from 	TB_SOCCER_BOARDS b, TB_COMM_USERS u "
	            + "        		where 	b.board_writer_no = u.user_no "
	            + "       		and		b.board_deleted = 'N') "
	            + "		order by board_no desc";

	    
		List<Board> allBoard = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			
			Board board = new Board();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			
			user.setName(rs.getString("user_name"));
			
			board.setWriter(user);
			
			allBoard.add(board);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return allBoard;
	}


	/**
	 * 지정된 게시글정보를 테이블에 저장한다.
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(Board board) throws SQLException {
		String sql = "insert into tb_soccer_boards (board_no, board_title, board_writer_no, board_content) "
					+ "values (tb_soccer_boards_seq.nextval, ?, ?, ?)";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setInt(2, board.getWriter().getNo());
		pstmt.setString(3, board.getContent());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 수정된 게시글 정보를 테이블에 반영한다.
	 * @param board 수정된 게시글 정보
	 * @throws SQLException
	 */
	public void updateBoard(Board board) throws SQLException {
		String sql = "update tb_soccer_boards "
					+ "set "
					+ "	board_title = ?, "
				    + "	board_content = ?, "
					+ "	board_like_count = ?, "
					+ "	board_view_count = ? "				
					+ "where board_no = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setString(2, board.getContent());
		pstmt.setInt(3, board.getLikeCount());
		pstmt.setInt(4, board.getViewCount());
		pstmt.setInt(5, board.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정된 번호의 게시글을 삭제한다.
	 * @param no 게시글 번호
	 * @throws SQLException
	 */
	public void deleteBoard(int no) throws SQLException {
		String sql = "update tb_soccer_boards "
					+ "set "
					+ " board_deleted = 'Y' "
					+ " where board_no = ?";
					
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		pstmt.close();
		connection.close();
		
	}
	
	/**
	 * 지정된 범위에 속하는 게시글 정보를 반환한다.
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<Board> getBoardList(int begin, int end) throws SQLException {
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, "
				   + "       board_view_count, board_like_count, board_deleted, "
				   + "		 board_created_date "
				   + "from (select row_number() over (order by B.board_no desc) rn, "
				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				   + "             B.board_view_count, B.board_like_count, B.board_deleted, "
				   + "			   B.board_created_date "
				   + "      from tb_soccer_boards B, tb_comm_users U "
				   + "      where B.board_writer_no = U.user_no "
				   + "		and b.board_deleted = 'N') "
				   + "where rn >= ? and rn <= ? ";
				   
		
		List<Board> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Board board = new Board();
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
			
			boardList.add(board);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardList;
	}
	
	/**
	 * 지정된 번호로 게시글 상세정보를 반영한다.
	 * @param no 게시글번호
	 * @return 게시글 정보
	 * @throws SQLException
	 */
	public Board getBoardDetail(int no) throws SQLException {
		String sql = "select B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content, B.board_comment_count, "
				   + "       B.board_view_count, B.board_like_count, B.board_deleted, "
				   + "		 B.board_created_date "
				   + "from tb_soccer_boards B, tb_comm_users U "
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
			board.setCommentCount(rs.getInt("board_comment_count"));
			
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
	 * 테이블에 저장된 게시글정보의 갯수를 반환한다.
	 * @return 게시글 정보 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_soccer_boards";
		
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
	 * 지정된 글번호와 사용자번호로 추천정보를 조회해서 반환한다.
	 * @param boardNo 글번호
	 * @param userNo 사용자번호
	 * @return 추천정보
	 * @throws SQLException
	 */
	public BoardLiker getBoardLiker(int boardNo, int userNo) throws SQLException {
		String sql = "select like_board_no, like_user_no "
				   + "from tb_like_users "
				   + "where like_board_no = ? and like_user_no = ?";
		
		BoardLiker boardLiker = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, userNo);
		
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			boardLiker = new BoardLiker();
			boardLiker.setBoardNo(rs.getInt("like_board_no"));
			boardLiker.setUserNo(rs.getInt("like_user_no"));	
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardLiker;
	}
	
	
	public void insertBoardLiker(BoardLiker boardLiker) throws SQLException {
		String sql ="insert into tb_like_users(like_board_No, like_user_No) "
				+ "values(?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardLiker.getBoardNo());
		pstmt.setInt(2, boardLiker.getUserNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
					
	}
	
	public List<User> getLikeUsers(int boardNo) throws SQLException {
		String sql = "select U.user_no, U.user_id, U.user_name "
				   + "from tb_like_users L, tb_comm_users U "
				   + "where L.like_user_no = U.user_no "
				   + "and L.like_board_no = ? ";
		
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
	 * 댓글 등록
	 * @param comment
	 * @throws SQLException
	 */
	public void insertComment(Comment comment) throws SQLException{
		 
		String sql = "insert into tb_soccer_board_comments(comment_no, soccer_board_no, comment_writer_no, comment_content, comment_group) "
				+ "values(tb_soccer_board_comments_seq.nextval, ?, ?, ?, tb_soccer_commentsgroup_seq.nextval) ";
		
		
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
	 * 댓글번호를 전달받아서 댓글 삭제
	 * @param no
	 * @throws SQLException
	 */
	public void deleteComment(int no) throws SQLException{
		
		String sql = "update tb_soccer_board_comments "
				+ "set comment_deleted = 'Y' "
				+ "where comment_no = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
	public List<Comment> getAllComment(int no) throws SQLException {
		
		String sql = "select comment_no, comment_content, comment_deleted, comment_created_date, comment_order, "
				+ "			comment_group, board_no, user_no, user_name "
				+ "from (select * "
				+ "      from tb_soccer_boards b, tb_soccer_board_comments c "
				+ "      where b.board_no = c.soccer_board_no) board, tb_comm_users u "
				+ "where board.comment_writer_no = u.user_no "
				+ "and board.board_no = ? "
				+ "order by board.comment_group, board.comment_created_date";

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
	
	public int getGroupCount(int no) throws SQLException{
		
		String sql ="select count(*) cnt "
				+ "from tb_soccer_board_comments "
				+ "where comment_group = ? ";

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
	
	public void deleteCommentGroup(int groupNo) throws SQLException{
		
		String sql ="delete from tb_soccer_board_comments "
				+ "where comment_group = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, groupNo);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}	
}
