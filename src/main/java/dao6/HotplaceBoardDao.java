package dao6;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Board;
import vo.BoardLiker;
import vo.User;

/**
 * 게시판에 대한 기능을 담고 있는 클래스
 * @author lee
 *
 */
public class HotplaceBoardDao {
	
	// 싱글턴 객체 생성
	private static HotplaceBoardDao self = new HotplaceBoardDao();
	private HotplaceBoardDao() {}
	public static HotplaceBoardDao getInstance() {
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
				   + "values (6,tb_hotplace_boards_seq.nextval, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setInt(2,board.getWriter().getNo());
		pstmt.setString(3, board.getContent());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
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
			
			board.setTypeCode(rs.getInt("board_type_code"));
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
	public Board getBoardTypeInfo(int typeCode) throws SQLException {
		Board board = null;
		
		String sql = "select board_type_code, board_type_name "
				   + "from tb_boards_type "
				   + "where board_type_code= ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, typeCode);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			board = new Board();
			 
			board.setTypeCode(rs.getInt("board_type_code"));
			board.setTypeName(rs.getString("board_type_name"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		return board;
	}
	
	/**
	 * 
	 * @param boardLiker 
	 * @throws SQLException
	 */
	public void insertBoardLiker(BoardLiker boardLiker) throws SQLException {
		String sql = "insert into tb_like_users (like_user_no, like_board_type_code, like_board_no) "
				   + "values (?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardLiker.getUserNo());
		pstmt.setInt(2, boardLiker.getBoardType());
		pstmt.setInt(3, boardLiker.getBoardNo());
		
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
	
	public List<Board> getBoardsRankByVeiwCount() throws SQLException {
		List<Board> boards = new ArrayList<>();
		Board board = null;
		
		String sql = "select rankboard.* "
				+ "   from (select  RANK() over (order by allboard.board_view_count desc) timeBest, allboard.*, userb.user_id, typeb.board_type_name "
				+ "        from (select hotb.board_no "
				+ "                    ,hotb.board_title "
				+ "                    ,hotb.board_writer_no "
				+ "                    ,hotb.board_content "
				+ "                    ,hotb.board_like_count "
				+ "                    ,hotb.board_view_count "
				+ "                    ,hotb.board_deleted "
				+ "                    ,hotb.board_comment_count "
				+ "                    ,hotb.board_created_date "
				+ "                    ,hotb.board_type_code "
				+ "               from  tb_hotplace_boards hotb "
				+ "               union "
				+ "               SELECT diab.board_no "
				+ ", diab.board_title "
				+ ", diab.board_writer_no "
				+ ", diab.board_content "
				+ ", diab.board_like_count "
				+ ", diab.board_view_count "
				+ ", diab.board_deleted "
				+ ", diab.board_comment_count "
				+ ", diab.board_created_date "
				+ ", diab.board_type_code "
				+ "from tb_diablo_boards diab "
				+ "union "
				+ "SELECT anib.board_no "
				+ ", anib.board_title "
				+ ", anib.board_writer_no "
				+ ", anib.board_content "
				+ ", anib.board_like_count "
				+ ", anib.board_view_count "
				+ ", anib.board_deleted "
				+ ", anib.board_comment_count "
				+ ", anib.board_created_date "
				+ ", anib.board_type_code "
				+ "from tb_animal_boards anib "
				+ "union "
				+ "SELECT socb.board_no "
				+ ", socb.board_title "
				+ ", socb.board_writer_no "
				+ ", socb.board_content "
				+ ", socb.board_like_count "
				+ ", socb.board_view_count "
				+ ", socb.board_deleted "
				+ ", socb.board_comment_count "
				+ ", socb.board_created_date "
				+ ", socb.board_type_code "
				+ "from tb_soccer_boards socb "
				+ "union "
				+ "SELECT coib.board_no "
				+ ", coib.board_title "
				+ ", coib.board_writer_no "
				+ ", coib.board_content "
				+ ", coib.board_like_count "
				+ ", coib.board_view_count "
				+ ", coib.board_deleted "
				+ ", coib.board_comment_count "
				+ ", coib.board_created_date "
				+ ", coib.board_type_code "
				+ "from tb_coin_boards coib "
				+ "union "
				+ "SELECT stob.board_no "
				+ ", stob.board_title "
				+ ", stob.board_writer_no "
				+ ", stob.board_content "
				+ ", stob.board_like_count "
				+ ", stob.board_view_count "
				+ ", stob.board_deleted "
				+ ", stob.board_comment_count "
				+ ", stob.board_created_date "
				+ ", stob.board_type_code "
				+ "from tb_stock_boards stob) allboard, tb_boards_type typeb, tb_comm_users userb "
				+ "where allboard.board_type_code = typeb.board_type_code "
				+ "and allboard.board_writer_no = userb.user_no) rankboard "
				+ "where rankboard.board_view_count >= 20  "
				+ "order by rankboard.board_view_count desc ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			board = new Board();
			
			board.setTitle(rs.getString("board_title"));
			board.setTypeName(rs.getString("board_type_name"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setNo(rs.getInt("board_no"));
			board.setTypeCode(rs.getInt("board_type_code"));
			
			boards.add(board);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return boards;
	}
	
	public List<Board> getBoardsRankByVeiwCountDetail(int beginNo, int endNo) throws SQLException {
		List<Board> boards = new ArrayList<>();
		Board board = null;
		User user = null;
		
		String sql = "select rankboard.* "
				+ "   from (select  RANK() over (order by allboard.board_view_count desc) timeBest, allboard.*, userb.user_id, typeb.board_type_name "
				+ "        from (select hotb.board_no "
				+ "                    ,hotb.board_title "
				+ "                    ,hotb.board_writer_no "
				+ "                    ,hotb.board_content "
				+ "                    ,hotb.board_like_count "
				+ "                    ,hotb.board_view_count "
				+ "                    ,hotb.board_deleted "
				+ "                    ,hotb.board_comment_count "
				+ "                    ,hotb.board_created_date "
				+ "                    ,hotb.board_type_code "
				+ "               from  tb_hotplace_boards hotb "
				+ "               union "
				+ "               SELECT diab.board_no "
				+ ", diab.board_title "
				+ ", diab.board_writer_no "
				+ ", diab.board_content "
				+ ", diab.board_like_count "
				+ ", diab.board_view_count "
				+ ", diab.board_deleted "
				+ ", diab.board_comment_count "
				+ ", diab.board_created_date "
				+ ", diab.board_type_code "
				+ "from tb_diablo_boards diab "
				+ "union "
				+ "SELECT anib.board_no "
				+ ", anib.board_title "
				+ ", anib.board_writer_no "
				+ ", anib.board_content "
				+ ", anib.board_like_count "
				+ ", anib.board_view_count "
				+ ", anib.board_deleted "
				+ ", anib.board_comment_count "
				+ ", anib.board_created_date "
				+ ", anib.board_type_code "
				+ "from tb_animal_boards anib "
				+ "union "
				+ "SELECT socb.board_no "
				+ ", socb.board_title "
				+ ", socb.board_writer_no "
				+ ", socb.board_content "
				+ ", socb.board_like_count "
				+ ", socb.board_view_count "
				+ ", socb.board_deleted "
				+ ", socb.board_comment_count "
				+ ", socb.board_created_date "
				+ ", socb.board_type_code "
				+ "from tb_soccer_boards socb "
				+ "union "
				+ "SELECT coib.board_no "
				+ ", coib.board_title "
				+ ", coib.board_writer_no "
				+ ", coib.board_content "
				+ ", coib.board_like_count "
				+ ", coib.board_view_count "
				+ ", coib.board_deleted "
				+ ", coib.board_comment_count "
				+ ", coib.board_created_date "
				+ ", coib.board_type_code "
				+ "from tb_coin_boards coib "
				+ "union "
				+ "SELECT stob.board_no "
				+ ", stob.board_title "
				+ ", stob.board_writer_no "
				+ ", stob.board_content "
				+ ", stob.board_like_count "
				+ ", stob.board_view_count "
				+ ", stob.board_deleted "
				+ ", stob.board_comment_count "
				+ ", stob.board_created_date "
				+ ", stob.board_type_code "
				+ "from tb_stock_boards stob) allboard, tb_boards_type typeb, tb_comm_users userb "
				+ "where allboard.board_type_code = typeb.board_type_code "
				+ "and allboard.board_writer_no = userb.user_no) rankboard "
				+ "where rankboard.board_view_count >= 20 "
				+ "and timeBest >= ? and timeBest <= ? "
				+ "order by rankboard.board_view_count desc ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, beginNo);
		pstmt.setInt(2, endNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			board = new Board();
			user = new User();
			
			user.setId(rs.getString("user_id"));
			
			board.setTitle(rs.getString("board_title"));
			board.setTypeName(rs.getString("board_type_name"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setTypeName(rs.getString("board_type_name"));
			board.setNo(rs.getInt("board_no"));
			board.setTypeCode(rs.getInt("board_type_code"));
			board.setWriter(user);
			board.setViewCount(rs.getInt("board_view_count"));
			board.setLikeCount(rs.getInt("board_like_count"));
			
			boards.add(board);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return boards;
	}
}
