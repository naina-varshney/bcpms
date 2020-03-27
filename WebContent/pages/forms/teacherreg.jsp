

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="bcpms.Conn"%>
<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.JSONObject" %>

<%
	String id = request.getParameter("session_link"); 
	boolean flag=Boolean.parseBoolean(request.getParameter("getValues"));
	
	String user_name = "", user_id = "", user_phone_no = "", user_aadhar_no = "", user_email = "", user_ques = "", user_ans = "";
	if (id != null) {
	
		
		if(flag){
			
			PreparedStatement ps = new Conn().con
				.prepareStatement("select teacher_identity_card,first_name,last_name,contact_number,email_id,adhaar_number,security_question,security_answer from teacher where teacher_identity_card=?");
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			user_id = rs.getString(1);
			user_name = rs.getString(2) + " " + rs.getString(3);
			user_phone_no = rs.getString(4);
			user_email = rs.getString(5);
			user_aadhar_no = rs.getString(6);
			user_ques = rs.getString(7);
			user_ans = rs.getString(8);
			
			JSONObject json=new JSONObject();
			json.put("user_id",user_id);
			json.put("user_name",user_name);
			json.put("user_phone",user_phone_no);
			json.put("user_email",user_email);
			json.put("user_aadhar",user_aadhar_no);
			json.put("user_ques",user_ques);
			json.put("user_ans",user_ans);
			response.setContentType("application/json");
			response.getWriter().write(json.toString());
		
		}
		else
		{
			response.getWriter().write("invalid user");
		
		}
		response.getWriter().close();
		ps.close();
		rs.close();
		}
		else{
		String designation = request.getParameter("designation");
		String joining_date = request.getParameter("joining_date");
		String gender = request.getParameter("gender");
		String dob = request.getParameter("DOB");
		String subject = request.getParameter("subject");
		
		LocalDate join_date= LocalDate.parse(joining_date);
		
		try{
		
			PreparedStatement ps1 = new Conn().con
					.prepareStatement("select designation_id from designation where designation_name=?");
			ps1.setString(1, designation);
			ResultSet rs2 = ps1.executeQuery();
			int designation_id = 0;
			if (rs2.next()) {
				designation_id = rs2.getInt(1);
				
			}

			PreparedStatement ps2 = new Conn().con
					.prepareStatement("update teacher set designation_id=?,joining_date=?,gender=?,dob=?,subject=? where teacher_identity_card=?");
			ps2.setInt(1, designation_id);
			ps2.setString(2, join_date.toString());
			ps2.setString(3, gender);
			ps2.setString(4, join_date.toString());
			ps2.setString(5, subject);
			ps2.setString(6,id);
			
			int n = ps2.executeUpdate();
			
			if (n > 0) {
				response.getWriter().write("../../pages/forms/login.html");
			}
			ps1.close();
			ps2.close();
			rs2.close();
			response.getWriter().close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	} 
	}
	/* else {
		response.getWriter().write("invalid user");
		response.getWriter().close();
	} */
%>
