package happy.land.people.dto;

import java.io.Serializable;

public class LPCollectDto implements Serializable {

	private static final long serialVersionUID = -6468354052971510360L;
	private String col_id;
	private String user_email;
	private String sketch_id;
	private String col_scrape;
	private String col_like;
	
	public LPCollectDto() {
	}

	public LPCollectDto(String col_id, String user_email, String sketch_id, String col_scrape, String col_like) {
		super();
	
		this.user_email = user_email;
		this.sketch_id = sketch_id;
		
	}

	public String getCol_id() {
		return col_id;
	}

	public void setCol_id(String col_id) {
		this.col_id = col_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getSketch_id() {
		return sketch_id;
	}

	public void setSketch_id(String sketch_id) {
		this.sketch_id = sketch_id;
	}

	public String getCol_scrape() {
		return col_scrape;
	}

	public void setCol_scrape(String col_scrape) {
		this.col_scrape = col_scrape;
	}

	public String getCol_like() {
		return col_like;
	}

	public void setCol_like(String col_like) {
		this.col_like = col_like;
	}

	@Override
	public String toString() {
		return "LpcollectDto [col_id=" + col_id + ", user_email=" + user_email + ", sketch_id=" + sketch_id
				+ ", col_scrape=" + col_scrape + ", col_like=" + col_like + "]";
	}
	
	
	
	
	
}
