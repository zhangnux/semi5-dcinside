package vo;
import java.util.Date;
public class BoardComment {

		private int no;
		private User user;
		private CoinBoard board; 
		private String content;
		private String deleted;
		private Date createdDate;
		private String order;
		private String group;
		
		
		
		public String getDeleted() {
			return deleted;
		}
		public void setDeleted(String deleted) {
			this.deleted = deleted;
		}
		public Date getCreatedDate() {
			return createdDate;
		}
		public void setCreatedDate(Date createdDate) {
			this.createdDate = createdDate;
		}
		public int getNo() {
			return no;
		}
		public void setNo(int no) {
			this.no = no;
		}
		public User getUser() {
			return user;
		}
		public void setUser(User user) {
			this.user = user;
		}
		public CoinBoard getBoard() {
			return board;
		}
		public void setBoard(CoinBoard board) {
			this.board = board;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getOrder() {
			return order;
		}
		public void setOrder(String order) {
			this.order = order;
		}
		public String getGroup() {
			return group;
		}
		public void setGroup(String group) {
			this.group = group;
		}
		
		
}
