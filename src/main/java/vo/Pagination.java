package vo;

import dao2.DiabloBoardDao;

public class Pagination {

	private int rowsPerPage = 3;
	private int pagesPerBlock = 2;
	private int currentPageNo;
	private int totalRecords;

	private int totalPages;
	private int totalBlocks;
	private int currentBlock;
	private int beginPage;
	private int endPage;
	private int prevPage;
	private int nextPage;
	private int begin;
	private int end;
	
	public Pagination(String pageNo, int totalRecords) {

		totalPages = (int)(Math.ceil((double)totalRecords/rowsPerPage));
		totalBlocks = (int)(Math.ceil((double)totalPages/pagesPerBlock));
		
		currentPageNo = 1;
		try {
			currentPageNo = Integer.parseInt(pageNo);
		} catch (NumberFormatException e) {}
		
		if (currentPageNo <= 0) {
			currentPageNo = 1;
		}
		if (currentPageNo > totalPages) {
			currentPageNo = totalPages;
		}

		begin = (currentPageNo - 1)*rowsPerPage + 1;
		end = currentPageNo*rowsPerPage;


		currentBlock = (int)(Math.ceil((double)currentPageNo/pagesPerBlock));

		beginPage = (currentBlock - 1)*pagesPerBlock + 1;
		endPage = currentBlock*pagesPerBlock;
		
		if (currentBlock == totalBlocks) {
			endPage = totalPages;
		}
		
		if (currentBlock > 1) {
			prevPage = (currentBlock - 1)*pagesPerBlock;
		}
		
		if (currentBlock < totalBlocks) {
			nextPage = currentBlock*pagesPerBlock + 1;
		}
	}
	
	public void HitPagination(String pageNo, int totalRecords) {

		totalPages = (int)(Math.ceil((double)totalRecords/rowsPerPage));
		totalBlocks = (int)(Math.ceil((double)totalPages/pagesPerBlock));
		
		currentPageNo = 1;
		try {
			currentPageNo = Integer.parseInt(pageNo);
		} catch (NumberFormatException e) {}
		
		if (currentPageNo <= 0) {
			currentPageNo = 1;
		}
		if (currentPageNo > totalPages) {
			currentPageNo = totalPages;
		}

		begin = 1;
		end = 5;


		currentBlock = (int)(Math.ceil((double)currentPageNo/pagesPerBlock));

		beginPage = (currentBlock - 1)*pagesPerBlock + 1;
		endPage = currentBlock*pagesPerBlock;
		
		if (currentBlock == totalBlocks) {
			endPage = totalPages;
		}
		
		if (currentBlock > 1) {
			prevPage = (currentBlock - 1)*pagesPerBlock;
		}
		
		if (currentBlock < totalBlocks) {
			nextPage = currentBlock*pagesPerBlock + 1;
		}
	}

	/**
	 * 계산된 현재 페이지번호를 반환한다.
	 * @return 페이지번호
	 */
	public int getPageNo() {
		return currentPageNo;
	}

	/**
	 * 총 게시글 갯수를 반환한다.
	 * @return 총 게시글 갯수
	 */
	public int getTotalRecords() {
		return totalRecords;
	}

	/**
	 * 총 페이지 갯수를 반환한다.
	 * @return 총 페이지 갯수
	 */
	public int getTotalPages() {
		return totalPages;
	}

	/**
	 * 시작 페이지번호를 반환한다.
	 * @return 시작 페이지번호
	 */
	public int getBeginPage() {
		return beginPage;
	}

	/**
	 * 끝 페이지번호를 반환한다.
	 * @return 끝 페이지번호
	 */
	public int getEndPage() {
		return endPage;
	}

	/**
	 * 조회 시작 순번을 반환한다.
	 * @return  조회 시작 순번
	 */
	public int getBegin() {
		return begin;
	}
	
	/**
	 * 이전 블록의 페이지번호를 반환한다.
	 * @return 페이지번호
	 */
	public int getPrevPage() {
		return prevPage;
	}
	
	/**
	 * 이전 블록 존재여부를 반환한다.
	 * @return 이전 블록 존재 여부
	 */
	public boolean isExistPrev() {
		if (totalBlocks == 1) {
			return false;
		}
		return currentBlock > 1;
	}
	
	/**
	 * 다음 블록 존재여부를 반환한다.
	 * @return 다음 블록 존재 여부
	 */
	public boolean isExistNext() {
		if (totalBlocks == 1) {
			return false;
		}
		
		return currentBlock < totalBlocks;
	}
	
	/**
	 * 다음 블록의 페이지번호를 반환한다.
	 * @return 페이지번호
	 */
	public int getNextPage() {
		return nextPage;
	}

	/**
	 * 조회 끝 순번을 반환한다.
	 * @return 조회 끝 순번
	 */
	public int getEnd() {
		return end;
	}

	
}
