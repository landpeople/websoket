package happy.land.people.dto.kim;

import java.util.Date;

public class LPDaysDto {
	public String days_id;
	public String can_id;
	public String days_title;
	public String days_content;
	public Date days_sdate;
	public Date days_edate;
	public String days_x;
	public String days_y;
	public String days_address;
	
	public LPDaysDto() {
		
	}

	public LPDaysDto(String can_id, String days_title, String days_content, Date days_sdate, Date days_edate,
			String days_x, String days_y, String days_address) {
		super();
		this.can_id = can_id;
		this.days_title = days_title;
		this.days_content = days_content;
		this.days_sdate = days_sdate;
		this.days_edate = days_edate;
		this.days_x = days_x;
		this.days_y = days_y;
		this.days_address = days_address;
	}
	
	public String getDays_id() {
		return days_id;
	}

	public void setDays_id(String days_id) {
		this.days_id = days_id;
	}

	public String getCan_id() {
		return can_id;
	}

	public void setCan_id(String can_id) {
		this.can_id = can_id;
	}

	public String getDays_title() {
		return days_title;
	}

	public void setDays_title(String days_title) {
		this.days_title = days_title;
	}

	public String getDays_content() {
		return days_content;
	}

	public void setDays_content(String days_content) {
		this.days_content = days_content;
	}

	public Date getDays_sdate() {
		return days_sdate;
	}

	public void setDays_sdate(Date days_sdate) {
		this.days_sdate = days_sdate;
	}

	public Date getDays_edate() {
		return days_edate;
	}

	public void setDays_edate(Date days_edate) {
		this.days_edate = days_edate;
	}

	public String getDays_x() {
		return days_x;
	}

	public void setDays_x(String days_x) {
		this.days_x = days_x;
	}

	public String getDays_y() {
		return days_y;
	}

	public void setDays_y(String days_y) {
		this.days_y = days_y;
	}

	public String getDays_address() {
		return days_address;
	}

	public void setDays_address(String days_address) {
		this.days_address = days_address;
	}

	@Override
	public String toString() {
		return "LPDaysDto [days_id=" + days_id + ", can_id=" + can_id + ", days_title=" + days_title + ", days_content="
				+ days_content + ", days_sdate=" + days_sdate + ", days_edate=" + days_edate + ", days_x=" + days_x
				+ ", days_y=" + days_y + ", days_address=" + days_address + "]";
	}
	
	
}
