<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="bcpms.Conn" %>
<%@ page import="org.json.JSONObject" %>
<%
String id=(String)session.getAttribute("user_session_key");
String execute=request.getParameter("run");
if(id!=null){
	if(execute.equals("load")){
		PreparedStatement ps=new Conn().con.prepareStatement("select student_identity_card,first_name,last_name,adhaar_number,contact_number,email_id from student where student_identity_card=?");
		ps.setString(1,id);
		ResultSet rs=ps.executeQuery();
		if(rs.next())
		{
			JSONObject responseObject=new JSONObject();
			responseObject.put("s_id",rs.getString(1));
			responseObject.put("s_name",rs.getString(2)+" "+rs.getString(3));
			responseObject.put("s_adhaar",rs.getString(4));
			responseObject.put("s_contact",rs.getString(5));
			responseObject.put("s_email",rs.getString(6));
			response.setContentType("application/json");
			response.getWriter().write(responseObject.toString());
		}
		response.getWriter().close();
		ps.close();
		rs.close();
	}
	else if(execute.equals("button")){
		String fatherName=request.getParameter("father_name");
		String motherName=request.getParameter("mother_name");
		String guardianName=request.getParameter("guardianname");
		String DOB=request.getParameter("dob");
		String selected_language=request.getParameter("language");
		String student_hostel=request.getParameter("hostel");
		String currentCourse=request.getParameter("current_course");
		String enrolmentNo=request.getParameter("enrolment_no");
		String state=request.getParameter("state");
		String pincode=request.getParameter("pincode");
		String address=request.getParameter("address");
		String short_course=request.getParameter("short_term_course");
		//System.out.println("father_name:"+fatherName+"Mother name:"+motherName+"enrollment"+enrolmentNo);
		PreparedStatement ps=new Conn().con.prepareStatement("update student set father_name=?,mother_name=?,dob=?,enrolment_no=?,hostel_name=?,language=?,address=?,current_course=?,state=?,pincode=? where student_identity_card=?");
		ps.setString(1,fatherName);
		ps.setString(2,motherName);
		ps.setString(3,DOB);
		ps.setString(4,enrolmentNo);
		ps.setString(5,student_hostel);
		ps.setString(6,selected_language);
		ps.setString(7,address);
		ps.setString(8,currentCourse);
		ps.setString(9,state);
		ps.setString(10,pincode);
		ps.setString(11,id);
	
		PreparedStatement ps1=new Conn().con.prepareStatement("select course_id from course_details where name=?");
		ps1.setString(1,short_course);
		ResultSet rs1=ps1.executeQuery();
		String c_id="";
		if(rs1.next())
		{
			c_id=rs1.getString(1);
		}
		PreparedStatement ps2=new Conn().con.prepareStatement("insert into student_enrolment_details (student_identity_card,course_id) values(?,?) ");
		ps2.setString(1,id);
		ps2.setString(2,c_id);
		if((ps.executeUpdate()>0)&&(ps2.executeUpdate()>0)){
			response.getWriter().write("../../pages/forms/2enroll.html");
		}
		response.getWriter().close();
		ps.close();
		rs1.close();
		ps1.close();
		ps2.close();
	}
	
	
}
else
{
	response.getWriter().write("invalid");
	response.getWriter().close();
}

%>