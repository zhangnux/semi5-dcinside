package dao3;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Board;
import vo.BoardLiker;
import vo.BoardType;
import vo.Comment;
import vo.Hit;
import vo.User;

public class StockBoardDao {

	//싱글턴 객체
	private static StockBoardDao self = new StockBoardDao();
	private StockBoardDao() {}
	public static StockBoardDao getInstance() {
		return self;
	}
	
	public List<Hit> getPostCount() throws SQLException {
		String sql = "select B.board_type_code, B.board_type_name, A.cnt "
				+ "from ("
				+ "        select 1 board_type_code, (select count(*) "
				+ "                                   from tb_animal_boards "
				+ "                                   where board_created_date >= trunc(sysdate) " 
				+ "                                  ) cnt "
				+ "        from dual "
				+ "        union all "
				+ "        select 2 board_type_code, (select count(*) "
				+ "                                   from tb_diablo_boards "
				+ "                                   where board_created_date >= trunc(sysdate) "
				+ "                                   ) cnt        "
				+ "        from dual "
				+ "        union "
				+ "        select 3 board_type_code, (select count(*) "
				+ "                                   from tb_stock_boards "
				+ "                                   where board_created_date >= trunc(sysdate) "
				+ "                                   ) cnt        "
				+ "        from dual "
				+ "        union "
				+ "        select 4 board_type_code, (select count(*) "
				+ "                                   from tb_soccer_boards "
				+ "                                   where board_created_date >= trunc(sysdate) "
				+ "                                   ) cnt        "
				+ "        from dual "
				+ "        union "
				+ "        select 5 board_type_code, (select count(*) "
				+ "                                   from tb_coin_boards "
				+ "                                   where board_created_date >= trunc(sysdate) "
				+ "                                   ) cnt        "
				+ "        from dual "
				+ "        union "
				+ "        select 6 board_type_code, (select count(*) "
				+ "                                   from tb_hotplace_boards "
				+ "                                   where board_created_date >= trunc(sysdate) "
				+ "                                   ) cnt        "
				+ "        from dual "
				+ "    ) A, tb_boards_type B "
				+ "where A.board_type_code = B.board_type_code "
				+ "order by cnt desc";
			
	       Connection connection = getConnection();
	       PreparedStatement pstmt = connection.prepareStatement(sql);
	       ResultSet rs = pstmt.executeQuery();
	      
	       List<Hit> boardList = new ArrayList<>();
	       
	      while(rs.next()) {
	      Board board = new Board();
	      BoardType boardType = new BoardType();
	      Hit hit = new Hit();
	      
	      boardType.setName(rs.getString("board_type_name"));
	      board.setType(rs.getInt("board_type_code"));
	      board.setCommentCount(rs.getInt("cnt"));
	      
	      hit.setBoard(board);
	      hit.setBoardType(boardType);
	      
	      boardList.add(hit);
	      
	      }
	      rs.close();
	      pstmt.close();
	      connection.close();
	      
	      return boardList;
		
	}
	/**
	 * 지정된 번호로 게시글 삭제
	 * @param no 글번호
	 * @throws SQLException
	 */
	public void deleteBoard(int no) throws SQLException{
		String sql = "update tb_stock_boards "
				   + "set "
				   + "	board_deleted = 'Y' "
				   + "where board_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	/**
	 * 수정된 정보가 포함된 게시글 정보 테이블에 반영
	 * @param board 
	 * @throws SQLException
	 */
	public void updateBoard(Board board) throws SQLException{
		String sql = "update tb_stock_boards "
					+"set "
					+" 	board_title = ?, "
					+" 	board_content = ?, "
					+" 	board_view_count = ?, "
					+" 	board_like_count = ? "
					+" where board_no = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setString(2, board.getContent());
		pstmt.setInt(3, board.getViewCount());
		pstmt.setInt(4, board.getLikeCount());
		
		pstmt.setInt(5, board.getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정된 게시글 정보를 테이블에 저장
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(Board board) throws SQLException {
		String sql = "insert into tb_stock_boards (board_no, board_title, board_writer_no, board_content) "
				   + "values (tb_stock_boards_seq.nextval, ?,?,?) ";
		
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
	 * 지정된 번호의 게시글 정보 반환
	 * @param no 번호
	 * @return 게시글 정보
	 * @throws SQLException
	 */
	public Board getBoardDetail(int no) throws SQLException {
		String sql = "select B.board_no, B.board_title, U.user_no, U.user_id ,U.user_name, B.board_content, "
					+"B.board_like_count, B.board_view_count, B.board_deleted, B.board_created_date "
					+"from tb_stock_boards B, tb_comm_users U "
					+"where B.board_writer_no = U.user_no "
					+"and B.board_no = ? ";
		
		Board board = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
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
	 * 지정된 범위에 속하는 게시글 정보 반환
	 * @param begin 시작 번호
	 * @param end 끝 번호
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<Board> getBoardList(int begin, int end) throws SQLException{
		String sql =  "select board_no, board_title, user_no, user_id, user_name, board_content, "
				   + "       board_view_count, board_like_count, board_deleted, board_created_date "
				   + "from (select row_number() over (order by B.board_no desc) rn, "
				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				   + "             B.board_view_count, B.board_like_count, B.board_deleted, B.board_created_date "
				   + "      from tb_stock_boards B, tb_comm_users U "
				   + "      where B.board_writer_no = U.user_no "
				   + "		and b.board_deleted = 'N') "
				   + "where rn >= ? and rn <= ? ";
		List<Board> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
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
	 * 테이블 저장된 게시글정보의 갯수 반환
	 * @return 게시글 정보 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords() throws SQLException{
		String sql = "select count(*) cnt "
					+"from tb_stock_boards";
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
	
	/**
	 * 지정된 번호의 글에 추천한 사용자의 목록을 반환한다.
	 * @param boardNo 글번호
	 * @return 사용자 목록
	 * @throws SQLException
	 */
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
	
	public void insertBoardLiker(BoardLiker boardLiker) throws SQLException{
		 String sql = "insert into tb_like_users (like_board_no, like_user_no) "
				   + "values (?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardLiker.getBoardNo());
		pstmt.setInt(2, boardLiker.getBoardNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
					
	}
	
	/**
	 * 게시물 조회
	 * @return
	 * @throws SQLException
	 */
	public List<Board> getBoardList() throws SQLException{
		
		String sql="select board_no, board_title, board_content, board_like_count, "
				+ "		   board_view_count, board_created_date, user_name, user_id, user_no "
				+ "from ( select * "
				+ "       from TB_STOCK_BOARDS b, TB_COMM_USERS U "
				+ "       where b.board_writer_no = u.user_no "
				+ "		  and b.board_deleted = 'N') "
				+ "order by board_no desc";
		
		Board board = null;
		List<Board> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery(); 
		
		while(rs.next()) {
			
			board = new Board();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			
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
	 * 대댓글 등록
	 * @param comment
	 * @throws SQLException
	 */
	public void insertCommentReply(Comment comment) throws SQLException{
		String sql ="insert into tb_stock_board_comments(comment_no, stock_board_no, comment_writer_no, comment_content, comment_order, coment_group) "
				+ "values(comm_comment_seq.nextval, ?, ?, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, comment.getNo());
		pstmt.setInt(2, comment.getBoard().getNo());
		pstmt.setInt(3, comment.getWriter().getNo());
		pstmt.setString(4, comment.getContent());
		pstmt.setInt(5, comment.getOrder());
		pstmt.setInt(6, comment.getGroup());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 댓글 등록
	 * @param comment 댓글
	 * @throws SQLException
	 */
	public void insertComment(Comment comment) throws SQLException{
		String sql = "insert into tb_stock_board_comments (comment_no, stock_board_no, comment_writer_no, comment_content, comment_group) "
					+"values(comm_comment_seq.nextval,?, ?, ?, comm_commentgroup_seq.nextval) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, comment.getBoard().getNo());
		pstmt.setInt(2, comment.getWriter().getNo());
		pstmt.setString(3, comment.getContent());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
	/**
	 *  댓글 삭제 
	 * @param no 번호로 입력받아 삭제
	 * @throws SQLException
	 */
	public void deleteComment(int no) throws SQLException{
		String sql = "update tb_stock_board_comments "
					+"set comment_deleted = 'Y' "
					+" where comment_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
		
	}
	
	/**
	 * 글번호 별 댓글 조회
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public List<Comment> getAllComment(int no) throws SQLException{
		String sql = "select comment_no, comment_content, comment_deleted, comment_created_date, comment_order,"
				+ "			 comment_group, board_no, user_no, user_name "
					+"from (select *  "
					+ "		from tb_stock_boards b, tb_stock_board_comments c	"
					+ "		where b.board_no = c.stock_board_no	)board, tb_comm_users u "
					+"where u.user_no = board.comment_writer_no "
					+"and board.board_no = ? "
					+"order by board.comment_group, board.comment_created_date" ;
		
		Comment comment = null;
		List<Comment> commentList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			
			comment = new Comment();
			Board board = new Board();
			User user = new User();
			
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setDeleted(rs.getString("comment_deleted"));
			comment.setCreatedDate(rs.getDate("comment_created_date"));
			comment.setOrder(rs.getInt("comment_order"));
			
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
	
	
	
}
