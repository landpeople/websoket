package happy.land.people.dto.kim;

public class LPCanvasDto {
	public String can_id;
	public String sketch_id;
	public String can_title;
	public String can_content;
	public String can_type;
	public String can_pageno;
	
	public LPCanvasDto() {
		// TODO Auto-generated constructor stub
	}
	
	public LPCanvasDto(String can_id, String sketch_id, String can_title, String can_content, String can_type,
			String can_pageno) {
		super();
		this.can_id = can_id;
		this.sketch_id = sketch_id;
		this.can_title = can_title;
		this.can_content = can_content;
		this.can_type = can_type;
		this.can_pageno = can_pageno;
	}

	public String getCan_id() {
		return can_id;
	}
	public void setCan_id(String can_id) {
		this.can_id = can_id;
	}
	public String getSketch_id() {
		return sketch_id;
	}
	public void setSketch_id(String sketch_id) {
		this.sketch_id = sketch_id;
	}
	public String getCan_title() {
		return can_title;
	}
	public void setCan_title(String can_title) {
		this.can_title = can_title;
	}
	public String getCan_content() {
		return can_content;
	}
	public void setCan_content(String can_content) {
		this.can_content = can_content;
	}
	public String getCan_type() {
		return can_type;
	}
	public void setCan_type(String can_type) {
		this.can_type = can_type;
	}
	public String getCan_pageno() {
		return can_pageno;
	}
	public void setCan_pageno(String can_pageno) {
		this.can_pageno = can_pageno;
	}

	@Override
	public String toString() {
		return "LPCanvasDto [can_id=" + can_id + ", sketch_id=" + sketch_id + ", can_title=" + can_title
				+ ", can_content=" + can_content + ", can_type=" + can_type + ", can_pageno=" + can_pageno + "]";
	}	
}
