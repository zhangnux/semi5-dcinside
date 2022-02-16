package dao5;

import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.CoinBoard;
import vo.BoardBookmarker;
import vo.BoardComment;
import vo.BoardLiker;
import vo.User;

public class CoinBoardDao {
	
	private static CoinBoardDao self = new CoinBoardDao();
	private CoinBoardDao() {}
	public static CoinBoardDao getInstance() {
		return self;
	}

	/**
	 * 지정된 게시글 정보를 테이블에 저장한다.
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(CoinBoard board) throws SQLException {
		String sql = "insert into tb_coin_boards (board_no, board_title, board_writer_no, board_content) "
				   + "values (tb_coin_board_seq.nextval, ?, ?, ?)";
		
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
	 * 수정된 정보가 포함된 게시글 정보를 테이블에 반영한다.
	 * @param board
	 * @throws SQLException
	 */
	public void updateBoard(CoinBoard board) throws SQLException {
		String sql = "update tb_coin_boards "
				   + "set "
				   + "	board_title = ?, "
				   + "	board_content = ?, "
				   + "	board_like_count = ?, "
				   + "	board_view_count = ?, "
				   + "  board_comment_count = ? "
				   + "where board_no = ? ";
		
		Connection connection = getConnection();
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
	 * 지정된 번호의 게시글을 삭제처리한다.
	 * @param no 글번호
	 * @throws SQLException
	 */
	public void deleteBoard(int no) throws SQLException {
		String sql = "update tb_coin_boards "
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
	 * 테이블에 저장된 게시글정보의 갯수를 반환한다.
	 * @return 게시글 정보 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_coin_boards "
				   + "where board_deleted = 'N' ";
		
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
	
	public int getBookmarkRecords(int userNo) throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_bookmark_boards "
				   + "where bookmark_user_no = ? ";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	/**
	 * 지정된 범위에 속하는 게시글 정보를 반환한다.
	 * @param begin 시작 순번번호
	 * @param end 끝 순번번호
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<CoinBoard> getBoardList(int begin, int end) throws SQLException {
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, board_comment_count, "
				   + "       board_view_count, board_like_count, board_deleted,  board_created_date "
				   + "from (select row_number() over (order by B.board_no desc) rn, "
				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				   + "             B.board_view_count, B.board_like_count, B.board_deleted, B.board_comment_count, B.board_created_date "
				   + "      from tb_coin_boards B, tb_comm_users U "
				   + "      where B.board_writer_no = U.user_no "
				   + "		and B.board_deleted = 'N') "
				   + "where rn >= ? and rn <= ? ";
		
		List<CoinBoard> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		
		while (rs.next()) {
			CoinBoard board = new CoinBoard();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setCommentCount(rs.getInt("board_comment_count"));
			
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
	
	public List<CoinBoard> getBoardList() throws SQLException {
		String sql="select board_no, board_title, board_content, board_like_count, "
				+ "		   board_view_count, board_created_date, user_name, user_id, user_no "
				+ "from ( select * "
				+ "       from TB_COIN_BOARDS b, TB_COMM_USERS u "
				+ "       where b.board_writer_no = u.user_no "
				+ "		  and b.board_deleted = 'N') "
				+ "order by board_no desc ";
		
		List<CoinBoard> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			CoinBoard board = new CoinBoard();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
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
	
	public List<CoinBoard> getBoardListBy(int boardNo) throws SQLException {
		String sql="select board_no, board_title, board_content, board_like_count, "
				+ "		   board_view_count, board_created_date, user_name, user_id, user_no "
				+ "from ( select * "
				+ "       from TB_COIN_BOARDS b, TB_COMM_USERS u "
				+ "       where b.board_writer_no = u.user_no "
				+ "		  and b.board_deleted = 'N' "
				+ "		  and b.board_no = ?) "
				+ "order by board_no desc ";
		
		List<CoinBoard> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			CoinBoard board = new CoinBoard();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
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
	
	public List<CoinBoard> getBoardListByView() throws SQLException {
		String sql="select board_no, board_title, board_content, board_like_count, "
				+ "		   board_view_count, board_created_date, user_name, user_id, user_no "
				+ "from ( select * "
				+ "       from TB_COIN_BOARDS b, TB_COMM_USERS u "
				+ "       where b.board_writer_no = u.user_no "
				+ "		  and b.board_deleted = 'N') "
				+ "order by board_view_count desc ";
		
		List<CoinBoard> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			CoinBoard board = new CoinBoard();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
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
	
	public List<CoinBoard> getBoardListByView(int begin, int end) throws SQLException {
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, board_comment_count, "
				   + "       board_view_count, board_like_count, board_deleted,  board_created_date "
				   + "from (select row_number() over (order by B.board_view_count desc) rn, "
				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				   + "             B.board_view_count, B.board_like_count,  B.board_deleted, B.board_comment_count, B.board_created_date "
				   + "      from tb_coin_boards B, tb_comm_users U "
				   + "      where B.board_writer_no = U.user_no "
				   + "		and B.board_deleted = 'N') "
				   + "where rn >= ? and rn <= ? ";
		
		List<CoinBoard> boardList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		
		while (rs.next()) {
			CoinBoard board = new CoinBoard();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setCommentCount(rs.getInt("board_comment_count"));
			
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
	 * 지정된 번호의 게시글 정보를 반영한다.
	 * @param no 게시긃ㄴ호
	 * @return 게시글 정보
	 * @throws SQLException
	 */
	public CoinBoard getBoardDetail(int no) throws SQLException {
		String sql = "select B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content, B.board_comment_count, "
				   + "       B.board_view_count, B.board_like_count, B.board_deleted, B.board_created_date "
				   + "from tb_coin_boards B, tb_comm_users U "
				   + "where B.board_writer_no = U.user_no "
				   + "and B.board_no = ? ";
		
		CoinBoard board = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			board = new CoinBoard();
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
	 * 게시글 추천 정보를 저장한다.
	 * @param boardLiker 게시글 추천정보(게시글번호, 로그인한 사용자번호 포함)
	 * @throws SQLException
	 */
	public void insertBoardLiker(BoardLiker boardLiker) throws SQLException {
		String sql = "insert into tb_like_users (like_board_no, like_user_no, like_board_type_code) "
				   + "values (?, ? , ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardLiker.getBoardNo());
		pstmt.setInt(2, boardLiker.getUserNo());
		pstmt.setInt(3, 1);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
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
	
	/**
	 * 지정된 번호의 글에 추천한 사용자의 목록을 반환한다.
	 * @param boardNo 글번호
	 * @return 사용자 목록
	 * @throws SQLException
	 */
	public List<User> getLikeUsers(int boardNo) throws SQLException {
		String sql = "select U.like_user_no "
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
			
			user.setNo(1);
			user.setId(rs.getString("user_id"));
			user.setName(rs.getString("user_name"));
			
			userList.add(user);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return userList;
	}
	
	
	public void insertBookmark(BoardBookmarker boardbookmarker) throws SQLException {
		String sql = "insert into tb_bookmark_boards (bookmark_board_no, bookmark_user_no, bookmark_board_type_code) "
				   + "values (?, ? , ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardbookmarker.getBoardNo());
		pstmt.setInt(2, boardbookmarker.getUserNo());
		pstmt.setInt(3, boardbookmarker.getCategoryNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정된 글번호와 사용자번호로 추천정보를 조회해서 반환한다.
	 * @param boardNo 글번호
	 * @param userNo 사용자번호
	 * @return 추천정보
	 * @throws SQLException
	 */
	public BoardLiker getBookmark(int boardNo, int userNo) throws SQLException {
		String sql = "select bookmark_board_no ,  bookmark_user_no "
				   + "from tb_bookmark_boards "
				   + "where bookmark_board_no = ? and bookmark_user_no = ? ";
		
		BoardLiker boardLiker = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, userNo);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			
			boardLiker = new BoardLiker();
			boardLiker.setBoardNo(rs.getInt("bookmark_board_no"));
			boardLiker.setUserNo(rs.getInt("bookmark_user_no"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardLiker;
	}
	
	public BoardLiker getBookmarkCategory(int boardNo, int userNo, int boardTypeCode) throws SQLException {
		String sql = "select bookmark_board_no ,  bookmark_user_no "
				+ "from tb_bookmark_boards "
				+ "where bookmark_board_no = ? and bookmark_user_no = ? "
				+ "bookmark_board_type_code = ? ";
		
		BoardLiker boardLiker = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, userNo);
		pstmt.setInt(3, boardTypeCode);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			
			boardLiker = new BoardLiker();
			boardLiker.setBoardNo(rs.getInt("bookmark_board_no"));
			boardLiker.setUserNo(rs.getInt("bookmark_user_no"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return boardLiker;
	}
	
	
	// 즐겨찾기 번호 구분
	public List<BoardBookmarker> getBookmarksByCategorys(int userNo, int categoryNo) throws SQLException {
		
		String sql = null;
		
		if(categoryNo==0) {
			
			sql = "select bookmark_board_no, bookmark_board_type_code "
					+ "from tb_bookmark_boards "
					+ "where bookmark_user_no = ? ";
			
		}else {
			sql = "select bookmark_board_no, bookmark_board_type_code "
					+ "from tb_bookmark_boards "
					+ "where bookmark_user_no = ? "
					+ "and bookmark_board_type_code = ? ";
		}
		
		List<BoardBookmarker> bookmarkList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		if(categoryNo!=0) {
			pstmt.setInt(2, categoryNo);
		}
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			
			BoardBookmarker boardBookmarker = new BoardBookmarker();
			
			boardBookmarker = new BoardBookmarker();
			boardBookmarker.setBoardNo(rs.getInt("bookmark_board_no"));
			boardBookmarker.setCategoryNo(rs.getInt("bookmark_board_type_code"));
			
			bookmarkList.add(boardBookmarker);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return bookmarkList;
	}
	
	// 즐겨찾기 전체 개수 구하기
	// 각 목록별 즐겨찾기 개수 구하기
		public int getBookmarkAllCount(int userNo, int categoryNo) throws SQLException {
			
			String sql = "select count(*) cnt "
					+ "from tb_bookmark_boards "
					+ "where bookmark_user_no = ? ";
			
			int getBookmarkCount=0;
			
			List<BoardBookmarker> bookmarkList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			getBookmarkCount = rs.getInt("cnt");
			
			rs.close();
			pstmt.close();
			connection.close();
			
			return getBookmarkCount;
		}
	// 목록별 즐겨찾기 개수 구하기	
	public int getBookmarkCount(int userNo, int categoryNo) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from tb_bookmark_boards "
				+ "where bookmark_user_no = ? "
				+ "and bookmark_board_type_code = ? ";
		
		int getBookmarkCount=0;
		
		List<BoardBookmarker> bookmarkList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		pstmt.setInt(2, categoryNo);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		getBookmarkCount = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return getBookmarkCount;
	}
	
	
	// 보드번호에 따른 세부사항 조회
	public CoinBoard getBoardBookmark(int boardNo, int begin, int end) throws SQLException {
		
		
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, "
				+ "       board_view_count, board_like_count, board_deleted,  board_created_date "
				+ "from (select row_number() over (order by B.board_no desc) rn, "
				+ "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				+ "             B.board_view_count, B.board_like_count, B.board_deleted,B.board_created_date "
				+ "      from tb_coin_boards B, tb_comm_users U "
				+ "      where B.board_writer_no = U.user_no "
				+ "		and B.board_deleted = 'N' "
				+ "		and B.board_no = ?) "
				+ "where rn >= ? and rn <= ? ";
		
		CoinBoard board = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			board = new CoinBoard();
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
	// 보드번호에 따른 세부사항 조회
	public CoinBoard getBoardBookmarks(int boardNo, int categoryNo, int begin, int end) throws SQLException {
		
		
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, board_type_code, "
				+ "       board_view_count, board_like_count, board_deleted,  board_created_date "
				+ "from (	"
				+ "      select row_number() over (order by B.board_created_date desc) rn, B.* , U.* "
				+ "        from ( "
				+ "           select * from tb_coin_boards  "
				+ "           union "
				+ "           select * from tb_stock_boards "
				+ "           union "
				+ "           select * from tb_diablo_boards "
				+ "           union "
				+ "           select * from tb_animal_boards "
				+ "           union "
				+ "           select * from tb_soccer_boards "
				+ "           union "
				+ "           select * from tb_hotplace_boards "
				+ "           )  B , tb_comm_users U  "
				+ "     where B.board_writer_no = U.user_no "
				+ "		and B.board_deleted = 'N' "
				+ "		and B.board_no = ? "
				+ "		and B.board_type_code = ?) "
				+ "where rn >= ? and rn <= ? ";
		
		CoinBoard board = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, boardNo);
		pstmt.setInt(2, categoryNo);
		pstmt.setInt(3, begin);
		pstmt.setInt(4, end);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			board = new CoinBoard();
			User user = new User();
			
			board.setNo(rs.getInt("board_no"));
			board.setTitle(rs.getString("board_title"));
			board.setContent(rs.getString("board_content"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setDeleted(rs.getString("board_deleted"));
			board.setCreatedDate(rs.getDate("board_created_date"));
			board.setTypeCode(rs.getInt("board_type_code"));
			
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
	
	
	
	//////////// 댓글부분 
	
	/**
	 * 댓글 등록(대댓글 아님)
	 * @param no
	 * @throws SQLException
	 */
	public void insertComment(BoardComment comment) throws SQLException{
														 
		String sql = "insert into tb_coin_board_comments(comment_no, coin_board_no, comment_writer_no, comment_content, comment_group) "
				+ "values(comm_comment_seq.nextval, ?, ?, ?, comm_commentgroup_seq.nextval) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, comment.getBoard().getNo());
		pstmt.setInt(2, comment.getUser().getNo());
		pstmt.setString(3, comment.getContent());
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
	public List<BoardComment> getAllComment(int no) throws SQLException {
		
//		String sql = "select comment_no, comment_content, comment_deleted, comment_created_date, comment_order, "
//				+ "			comment_group, board_no, user_no, user_name "
//				+ "from (select * "
//				+ "      from tb_coin_boards b, tb_coin_board_comments c "
//				+ "      where b.board_no = c.coin_board_no) board, tb_comm_users u "
//				+ "where board.comment_writer_no = u.user_no "
//				+ "and board.comment_deleted = 'N' "
//				+ "and board.board_no = ? "
//				+ "order by board.comment_group, board.comment_created_date ";
		
		String sql = "select * "
	               + "from (select c.comment_no, c.comment_content, c.comment_deleted, c.comment_created_date, c.comment_order, c.comment_group, b.board_no, c.comment_writer_no "
	               + "   from tb_coin_boards b, tb_coin_board_comments c "
	               + "   where b.board_no = c.coin_board_no) board, tb_comm_users u "
	               + "where board.comment_writer_no = u.user_no "
	               + "and board.comment_deleted = 'N' "
	               + "and board.board_no = ? "
	               + "order by board.comment_group, board.comment_created_date ";

		BoardComment comment = null;
		List<BoardComment> commentList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			
			comment = new BoardComment();
			User user = new User();
			CoinBoard board = new CoinBoard();
			
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setDeleted(rs.getString("comment_deleted"));
			comment.setCreatedDate(rs.getDate("comment_created_date"));
			comment.setOrder(rs.getString("comment_order"));
			comment.setGroup(rs.getString("comment_group"));
			
			board.setNo(rs.getInt("board_no"));
			
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			user.setId(rs.getString("user_id"));
			user.setTel(rs.getString("user_tel"));
			user.setEmail(rs.getString("user_email"));
			
			comment.setBoard(board);
			comment.setUser(user);
			
			commentList.add(comment);
			
		}
		
		rs.close();
		pstmt.close();
		connection.close();

		return commentList;
	}
	
	/**
	 * 덧글번호 전달받아 덧글 삭제
	 * @param no
	 * @throws SQLException
	 */
	public void deleteComment(int no) throws SQLException{
		
		String sql = "update tb_coin_board_comments "
				+ "set comment_deleted = 'Y' "
				+ "where comment_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
}










