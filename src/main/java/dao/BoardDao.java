package dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import utils.ConnectionUtil;
import vo.Board;
import vo.BoardType;
import vo.Hit;
import vo.User;

public class BoardDao {

	private static BoardDao self = new BoardDao();
	private BoardDao() {}
	public static BoardDao getInstance() {
		return self;
	}
	
	/**
	 * 작성댓글수 반환
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public int getMyCommentCount(int userNo) throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from ( "
				+ "      select * "
				+ "      from ( "
				+ "            select * from tb_diablo_board_comments "
				+ "            union "
				+ "            select * from tb_animal_board_comments "
				+ "            union "
				+ "            select * from tb_stock_board_comments "
				+ "            union "
				+ "            select * from tb_soccer_board_comments "
				+ "            union "
				+ "            select * from tb_coin_board_comments "
				+ "            union "
				+ "            select * from tb_hotplace_board_comments "
				+ "             ) "
				+ "     )c, tb_comm_users u "
				+ "where c.comment_writer_no = u.user_no "
				+ "and c.comment_deleted = 'N' "
				+ "and user_no = ? ";
		
		int count = 0;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		pstmt.executeQuery();
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		count = rs.getInt("cnt");
		
		rs.close();		
		pstmt.close();
		connection.close();
		
		return count;
		
	}	
	
	
	
	/**
	 * 작성글수 반환
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public int getMyPostingCount(int userNo) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from ( "
				+ "      select * "
				+ "      from ( "
				+ "            select * from tb_diablo_boards "
				+ "            union "
				+ "            select * from tb_animal_boards "
				+ "            union "
				+ "            select * from tb_stock_boards "
				+ "            union "
				+ "            select * from tb_soccer_boards "
				+ "            union "
				+ "            select * from tb_coin_boards "
				+ "            union "
				+ "            select * from tb_hotplace_boards "
				+ "             )A "
				+ "     ) b, tb_boards_type t, tb_comm_users u "
				+ "where b.board_writer_no = u.user_no "
				+ "and b.board_type_code = t.board_type_code "
				+ "and user_no = ? ";
		
		int count = 0;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		pstmt.executeQuery();
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		count = rs.getInt("cnt");
		
		rs.close();		
		pstmt.close();
		connection.close();
		
		return count;
		
	}	
	
	
	
	/**
	 * 작성댓글 조회
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<Hit> getMyComment(int userNo) throws SQLException{
		
		String sql = "select * "
				+ "from ( "
				+ "      select * "
				+ "      from ( "
				+ "            select * from tb_diablo_board_comments "
				+ "            union "
				+ "            select * from tb_animal_board_comments "
				+ "            union "
				+ "            select * from tb_stock_board_comments "
				+ "            union "
				+ "            select * from tb_soccer_board_comments "
				+ "            union "
				+ "            select * from tb_coin_board_comments "
				+ "            union "
				+ "            select * from tb_hotplace_board_comments "
				+ "             ) "
				+ "     )c, tb_boards_type t, tb_comm_users u "
				+ "where c.comment_writer_no = u.user_no "
				+ "and c.board_type_code = t.board_type_code "
				+ "and c.comment_deleted = 'N' "
				+ "and user_no = ? ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		List<Hit> hitList = new ArrayList<>();
		
		while(rs.next()) {
			
			Hit hit = new Hit();				
			Board board = new Board();
			BoardType boardType = new BoardType();
			
			board.setContent(rs.getString("comment_content"));
			board.setCreatedDate(rs.getDate("comment_created_date"));
			board.setType(rs.getInt("board_type_code"));
			
			boardType.setName("board_type_name");
			boardType.setBoard(board);
			
			hit.setBoard(board);
			hit.setBoardType(boardType);
			
			hitList.add(hit);
			
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return hitList;
		
	}	
	
	/**
	 * 작성글 조회
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<Hit> getMyPosting(int userNo) throws SQLException{
		
		String sql = "select * "
				+ "from ( "
				+ "      select * "
				+ "      from ( "
				+ "            select * from tb_diablo_boards"
				+ "            union "
				+ "            select * from tb_animal_boards "
				+ "            union "
				+ "            select * from tb_stock_boards "
				+ "            union "
				+ "            select * from tb_soccer_boards "
				+ "            union "
				+ "            select * from tb_coin_boards "
				+ "            union "
				+ "            select * from tb_hotplace_boards "
				+ "             )A "
				+ "     ) b, tb_boards_type t, tb_comm_users u "
				+ "where b.board_type_code = t.board_type_code "
				+ "and b.board_writer_no = u.user_no "
				+ "and user_no = ?";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		List<Hit> hitList = new ArrayList<>();
		
		while(rs.next()) {
			
			Hit hit = new Hit();				
			Board board = new Board();
			BoardType boardType = new BoardType();
			User user = new User();
			
			board.setType(rs.getInt("board_type_code"));
			board.setTitle(rs.getString("board_title"));
			board.setNo(rs.getInt("board_no"));
			board.setCreatedDate(rs.getTimestamp("board_created_date"));
			board.setLikeCount(rs.getInt("board_like_count"));
			board.setViewCount(rs.getInt("board_view_count"));
			board.setCommentCount(rs.getInt("board_comment_count"));
			
			boardType.setName(rs.getString("board_type_name"));
			
			user.setName(rs.getString("user_name"));
			
			hit.setBoard(board);
			hit.setBoardType(boardType);
			hit.setUser(user);
			
			hitList.add(hit);
			
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return hitList;
		
	}
	
	/**
	 * 힛갤 게시글 갯수
	 * @return
	 * @throws SQLException
	 */
	public int getHitRecords() throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from ( "
				+ "      select A.* "
				+ "      from ( "
				+ "            select * from tb_diablo_boards "
				+ "            union "
				+ "            select * from tb_animal_boards "
				+ "            union "
				+ "            select * from tb_stock_boards "
				+ "            union "
				+ "            select * from tb_soccer_boards "
				+ "            union "
				+ "            select * from tb_coin_boards "
				+ "            union "
				+ "            select * from tb_hotplace_boards "
				+ "            ) A "
				+ "      where a.board_like_count >= 5 "
				+ "      ) b, tb_boards_type t, tb_comm_users u "
				+ "where b.board_type_code = t.board_type_code "
				+ "and b.board_writer_no = u.user_no";
		
		int hitRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		hitRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return hitRecords;
	}
	
	/**
	 * Hit 게시글 출력용
	 * @return
	 * @throws SQLException
	 */
	public List<Hit> getHitPost(int begin, int end) throws SQLException {
		
		String sql = "select * "
				+ "from ( "
				+ "      select row_number() over (order by board_created_date desc) rn, A.* "
				+ "      from ( "
				+ "            select * from tb_diablo_boards "
				+ "            union "
				+ "            select * from tb_animal_boards "
				+ "            union "
				+ "            select * from tb_stock_boards "
				+ "            union "
				+ "            select * from tb_soccer_boards "
				+ "            union "
				+ "            select * from tb_coin_boards "
				+ "            union "
				+ "            select * from tb_hotplace_boards "
				+ "            ) A "
				+ "      where a.board_like_count >= 5 "
				+ "      ) b, tb_boards_type t, tb_comm_users u "
				+ "where b.board_type_code = t.board_type_code "
				+ "and b.board_writer_no = u.user_no "
				+ "and rn >= ? and rn <= ? " ;
		
		List<Hit> hitList = new ArrayList<>();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
	
		while(rs.next()) {
				Hit hit = new Hit();				
				Board board = new Board();
				BoardType boardType = new BoardType();
				User user = new User();
				
				board.setType(rs.getInt("board_type_code"));
				board.setTitle(rs.getString("board_title"));
				board.setNo(rs.getInt("board_no"));
				board.setCreatedDate(rs.getTimestamp("board_created_date"));
				board.setLikeCount(rs.getInt("board_like_count"));
				board.setViewCount(rs.getInt("board_view_count"));
				board.setCommentCount(rs.getInt("board_comment_count"));
				
				boardType.setName(rs.getString("board_type_name"));
				
				user.setName(rs.getString("user_name"));
				
				hit.setBoard(board);
				hit.setBoardType(boardType);
				hit.setUser(user);
				
				hitList.add(hit);
				
		}
	
		rs.close();
		pstmt.close();
		connection.close();	
		
		return hitList;
	}

	
}