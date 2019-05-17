package happy.land.people.dto.kim;

public class LPMapdataDto {
	private String map_id;
	private String map_x;
	private String map_y;
	private String map_type;
	private String map_title;
	private String map_content;
	
	public LPMapdataDto() {
		
	}
	
	public LPMapdataDto(String map_id, String map_x, String map_y, String map_type, String map_title,
			String map_content) {
		super();
		this.map_id = map_id;
		this.map_x = map_x;
		this.map_y = map_y;
		this.map_type = map_type;
		this.map_title = map_title;
		this.map_content = map_content;
	}

	public String getMap_id() {
		return map_id;
	}

	public void setMap_id(String map_id) {
		this.map_id = map_id;
	}

	public String getMap_x() {
		return map_x;
	}

	public void setMap_x(String map_x) {
		this.map_x = map_x;
	}

	public String getMap_y() {
		return map_y;
	}

	public void setMap_y(String map_y) {
		this.map_y = map_y;
	}

	public String getMap_type() {
		return map_type;
	}

	public void setMap_type(String map_type) {
		this.map_type = map_type;
	}

	public String getMap_title() {
		return map_title;
	}

	public void setMap_title(String map_title) {
		this.map_title = map_title;
	}

	public String getMap_content() {
		return map_content;
	}

	public void setMap_content(String map_content) {
		this.map_content = map_content;
	}

	@Override
	public String toString() {
		return "LPMapdataDto [map_id=" + map_id + ", map_x=" + map_x + ", map_y=" + map_y + ", map_type=" + map_type
				+ ", map_title=" + map_title + ", map_content=" + map_content + "]";
	}	
}
