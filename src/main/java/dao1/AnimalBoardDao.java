package dao1;

import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Board;
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
				   + "values (comm_board_seq.nextval, ?, ?, ?)";
		
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
	 * 지정된 범위의 게시글 정보 반환
	 * @param begin 시작 순번번호
	 * @param end 끝 순번번호
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<Board> getBoardList(int begin, int end) throws SQLException {
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, "
				   + "       board_view_count, board_like_count, board_deleted, board_created_date "
				   + "from (select row_number() over (order by B.board_no desc) rn, "
				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				   + "             B.board_view_count, B.board_like_count, B.board_deleted, B.board_created_date "
				   + "      from tb_animal_boards B, tb_comm_users U "
				   + "      where B.board_writer_no = U.user_no) "
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
	
	
	
	
	
	
	
	
	
	
	
	
}
