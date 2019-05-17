package happy.land.people.dto;

public class LPSketchbookDto {
	
	private String sketch_id;
	private String user_email;
	private String sketch_title;
	private String sketch_theme;
	private String sketch_share;
	private String sketch_delflag;
	private String sketch_content;
	private String sketch_block;
	private String sketch_spath;
	
	private String serviceImplYn;
	private String input;
	private String rows;
	private String page;
	
	public LPSketchbookDto() {
	}
	
	public LPSketchbookDto(String sketch_id, String user_email, String sketch_title, String sketch_theme,
			String sketch_share, String sketch_delflag, String sketch_content, String sketch_block, String sketch_spath,
			String serviceImplYn, String input, String rows, String page) {
		super();
		this.sketch_id = sketch_id;
		this.user_email = user_email;
		this.sketch_title = sketch_title;
		this.sketch_theme = sketch_theme;
		this.sketch_share = sketch_share;
		this.sketch_delflag = sketch_delflag;
		this.sketch_content = sketch_content;
		this.sketch_block = sketch_block;
		this.sketch_spath = sketch_spath;
		this.serviceImplYn = serviceImplYn;
		this.input = input;
		this.rows = rows;
		this.page = page;
	}

	public String getSketch_id() {
		return sketch_id;
	}

	public void setSketch_id(String sketch_id) {
		this.sketch_id = sketch_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getSketch_title() {
		return sketch_title;
	}

	public void setSketch_title(String sketch_title) {
		this.sketch_title = sketch_title;
	}

	public String getSketch_theme() {
		return sketch_theme;
	}

	public void setSketch_theme(String sketch_theme) {
		this.sketch_theme = sketch_theme;
	}

	public String getSketch_share() {
		return sketch_share;
	}

	public void setSketch_share(String sketch_share) {
		this.sketch_share = sketch_share;
	}

	public String getSketch_delflag() {
		return sketch_delflag;
	}

	public void setSketch_delflag(String sketch_delflag) {
		this.sketch_delflag = sketch_delflag;
	}

	public String getSketch_content() {
		return sketch_content;
	}

	public void setSketch_content(String sketch_content) {
		this.sketch_content = sketch_content;
	}

	public String getSketch_spath() {
		return sketch_spath;
	}

	public void setSketch_spath(String sketch_spath) {
		this.sketch_spath = sketch_spath;
	}

	public String getSketch_block() {
		return sketch_block;
	}

	public void setSketch_block(String sketch_block) {
		this.sketch_block = sketch_block;
	}

	public String getServiceImplYn() {
		return serviceImplYn;
	}

	public void setServiceImplYn(String serviceImplYn) {
		this.serviceImplYn = serviceImplYn;
	}

	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}
	
	
}
