package dao6;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import utils.ConnectionUtil;
import vo.Board;
import vo.BoardLiker;
import vo.User;

/**
 * 게시판에 대한 기능을 담고 있는 클래스
 * @author lee
 *
 */
public class HotPlaceBoardDao {
	
	// 싱글턴 객체 생성
	private static HotPlaceBoardDao self = new HotPlaceBoardDao();
	private HotPlaceBoardDao() {}
	public static HotPlaceBoardDao getInstance() {
		return self;
	}
	
	/**
	 * 지정된 게시글을 삽입하는 메서드
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(Board board) throws SQLException {
		String sql = "insert into tb_hotplace_boards (board_type_code, board_no, "
				   + "								  board_title, board_writer_no, "
				   + "								  board_content) "
				   + "values (6,comm_board_seq.nextval, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setInt(2,board.getWriter().getNo());
		pstmt.setString(3, board.getContent());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	/*
	 * public void insertBoard(Board board, int typeCode) throws SQLException {
	 * String sql = "insert into tb_hotplace_boards (board_type_code, board_no, " +
	 * "								  board_title, board_writer_no, " +
	 * "								  board_content) " +
	 * "values (?,comm_board_seq.nextval, ?, ?, ?)";
	 * 
	 * Connection connection = getConnection(); PreparedStatement pstmt =
	 * connection.prepareStatement(sql); pstmt.setInt(1, typeCode);
	 * pstmt.setString(2, board.getTitle());
	 * pstmt.setInt(3,board.getWriter().getNo()); pstmt.setString(4,
	 * board.getContent()); pstmt.executeUpdate();
	 * 
	 * pstmt.close(); connection.close(); }
	 */
	
	/**
	 * 모든 게시글을 조회하는 메서드 
	 * @return 조회된 게시글 리스트
	 * @throws SQLException
	 */
	public List<Board> getBoardListByTypeCode(int beginNo, int endNo) throws SQLException {
		List<Board> boards = new ArrayList<>();
		Board board = null;
		User user = null;
		
		String sql = "select RN, board_type_code, board_no, board_title, user_id, board_created_date "
			       + "      ,board_view_count, board_like_count, board_deleted "
				   + "from (select ROW_NUMBER() over (order by board_created_date desc) RN"
				   + "            ,board_type_code, board_no, board_title, user_id"
				   + "            ,board_created_date ,board_view_count, board_like_count, board_deleted "
				   + "      from   tb_hotplace_boards, tb_comm_users "
				   + "      where  tb_hotplace_boards.board_writer_no = tb_comm_users.user_no) "
				   + "where RN >= ? and RN <= ? ";
			
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, beginNo);
		pstmt.setInt(2, endNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			board = new Board();
			user = new User();
			
			user.setId(rs.getString("user_id"));
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setWriter(user);
			board.setCreatedDate(rs.getTimestamp("board_created_date"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setDeleted(rs.getString("board_deleted"));
			
			boards.add(board);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return boards;
	}
	
	/**
	 * 게시글의 상세정보를 조회하는 기능
	 * @param boardNo 게시글 번호
	 * @return 지정된 게시글 번호에 따른 게시글
	 * @throws SQLException
	 */
	public Board getBoardDetail(int boardNo) throws SQLException {
		Board board = null;
		User user = null;
		
		String sql = "select board_type_code, board_no, board_title, user_no, user_id, board_created_date "
				   + "      ,board_view_count, board_like_count, board_content "
				   + "from   tb_hotplace_boards, tb_comm_users "
				   + "where  tb_hotplace_boards.board_writer_no = tb_comm_users.user_no "
				   + "and    board_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			board = new Board();
			user = new User();
			
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			
			board.setType(rs.getInt("board_type_code"));
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setWriter(user);
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setContent(rs.getString("board_content"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return board;
	}
	
	/**
	 * 해당 타입의 전체 게시글 수를 계산한다.
	 * @return 전체 게시글 수 조회
	 * @throws SQLException
	 */
	public int getBoardCount() throws SQLException {
		int boardCnt = 0;
		
		String sql = "select count(*) cnt "
				   + "from tb_hotplace_boards ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		boardCnt = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardCnt;
	}
	
	/**
	 * 지정된 게시글을 업데이트하는 메서드
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void updateBoard(Board board) throws SQLException {
		String sql = "update tb_hotplace_boards "
				   + "set "
				   + "	 board_title= ?, "
				   + "   board_content= ?, "
				   + "   board_like_count= ?, "
				   + "   board_view_count= ? "
				   + "where board_no= ? ";
		
		Connection connection = getConnection();
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
	 * 지정된 게시글을 삭제하는 메서드
	 * @param boardNo 게시글 번호
	 * @throws SQLException
	 */
	public void deleteBoard(int boardNo) throws SQLException {
		String sql = "delete "
				   + "from tb_hotplace_boards "
				   + "where board_no= ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 
	 * @param typeCode
	 * @return
	 * @throws SQLException
	 */
	/*
	 * public Board getBoardTypeInfo(int typeCode) throws SQLException { Board board
	 * = null;
	 * 
	 * String sql = "select board_type_code, board_type_name " +
	 * "from tb_boards_type " + "where board_type_code= ? ";
	 * 
	 * Connection connection = getConnection(); PreparedStatement pstmt =
	 * connection.prepareStatement(sql); pstmt.setInt(1, typeCode); ResultSet rs =
	 * pstmt.executeQuery();
	 * 
	 * if (rs.next()) { board = new Board();
	 * 
	 * board.setType(rs.getInt("board_type_code"));
	 * board.setTypeName(rs.getString("board_type_name")); }
	 * 
	 * rs.close(); pstmt.close(); connection.close(); return board; }
	 */
	
	/**
	 * 
	 * @param boardLiker 
	 * @throws SQLException
	 */
	public void insertBoardLiker(BoardLiker boardLiker) throws SQLException {
		String sql = "insert into tb_like_users (like_user_no, like_board_no) "
				   + "values (?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardLiker.getUserNo());
		pstmt.setInt(2, boardLiker.getBoardNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 
	 * @param boardNo 
	 * @param userNo
	 * @return 
	 * @throws SQLException
	 */
	public BoardLiker getBoardLiker(int boardNo, int userNo) throws SQLException {
		BoardLiker boardLiker = null;
		
		String sql = "select like_board_no, like_user_no "
				   + "from tb_like_users "
				   + "where like_board_no = ? and like_user_no = ? ";
		
		
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
	
	public List<Board> getBoardsRankByVeiwCount() {
		List<Board> boards = new ArrayList<>();
		
		String sql = "select b.timeBest "
				   + "      ,b.board_view_count "
				   + "      ,b.board_type_code "
				   + "      ,b.board_type_name "
				   + "      ,b.board_title "
				   + "      ,b.board_created_date "
				   + "from  (select RANK() over (order by a.board_view_count desc) timeBest "
				   + "             ,a.board_view_count "
				   + "             ,a.board_type_code "
				   + "             ,a.board_type_name "
				   + "             ,a.board_title "
				   + "             ,a.board_created_date "
				   + "       from  (select hotb.board_view_count "
				   + "                    ,hotb.board_type_code "
				   + "                    ,bt.board_type_name "
				   + "                    ,hotb.board_title "
				   + "                    ,hotb.board_created_date "
				   + "              from   tb_hotplace_boards hotb, tb_boards_type bt "
				   + "              where  hotb.board_type_code = bt.board_type_code "
				   + "              union "
				   + "              select diab.board_view_count "
				   + "                    ,diab.board_type_code "
				   + "                    ,bt.board_type_name "
				   + "                    ,diab.board_title "
				   + "                    ,diab.board_created_date "
				   + "              from   tb_diablo_boards diab, tb_boards_type bt "
				   + "              where  diab.board_type_code = bt.board_type_code "
				   + "              union "
				   + "              select socb.board_view_count "
				   + "                    ,socb.board_type_code "
				   + "                    ,bt.board_type_name "
				   + "                    ,socb.board_title "
				   + "                    ,socb.board_created_date "
				   + "              from tb_soccer_boards socb, tb_boards_type bt "
				   + "              where socb.board_type_code = bt.board_type_code) a) b "
				   + "where  timeBest <= 18 "
				   + "order by b.board_view_count desc ";
		
		return boards;
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
				+ "from ( select row_number() over(order by B.board_view_count desc) rn,"
				+ "				 b.board_no, b.board_title, b.board_writer_no, b.board_content, "
				+ "				 b.board_like_count,b.board_view_count,b.board_deleted,b.board_created_date, "
				+ "				 b.board_comment_count, u.user_no, u.user_id, u.user_name"
				+ "       from TB_DIABLO_BOARDS b, TB_COMM_USERS U "
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
