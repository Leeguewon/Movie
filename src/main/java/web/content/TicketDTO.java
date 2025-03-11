package web.content;

public class TicketDTO {
	private String memberid;
	private String moviename;
	private String place;
	private String date;
	private String time;
	private String[] seat;
	
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getMovieName() {
		return moviename;
	}
	public void setMovieName(String moviename) {
		this.moviename = moviename;
	}
	
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String[] getSeat() {
		return seat;
	}
	public void setSeat(String[] selectedSeats) {
		this.seat = selectedSeats;
	}
	
	
}