

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("reset_id");
	String ques = request.getParameter("securityques");
	String ans = request.getParameter("security_ans");
	
	
		session.setAttribute("forgot_password_session_id", id);

		if ((id.charAt(0) == 'A') && (id.charAt(1) == 'B')) {

			PreparedStatement ps = new Conn().con.prepareStatement("select student_identity_card,security_question,security_answer from student where student_identity_card=? and security_question=? and security_answer=?");
			ps.setString(1, id);
			ps.setString(2, ques);
			ps.setString(3, ans);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				response.getWriter().write("../../pages/forms/forgot.html");
			}
			else {
				response.getWriter().write("unauthorized");
				
			}
			response.getWriter().close();
			ps.close();
			rs.close();
		} 
		else if ((id.charAt(0) == 'T')) {
			PreparedStatement ps = new Conn().con.prepareStatement("select teacher_identity_card,security_question,security_answer from teacher where teacher_identity_card=? and security_question=? and security_answer=?");
			ps.setString(1, id);
			ps.setString(2, ques);
			ps.setString(3, ans);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				response.getWriter().write("../../pages/forms/forgot.html");
				
			}
			else {
				response.getWriter().write("unauthorized");
				
			}
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		else if ((id.charAt(0) == 'A') && (id.charAt(1) == 'D')) {

			PreparedStatement ps = new Conn().con.prepareStatement("select username,security_question,security_answer from administrator where username=? and security_question=? and security_answer=?");
			ps.setString(1, id);
			ps.setString(2, ques);
			ps.setString(3, ans);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				response.getWriter().write("../../pages/forms/forgot.html");
			}
			else {
				response.getWriter().write("unauthorized");
				
			}
			response.getWriter().close();
			ps.close();
			rs.close();
		} 

	  else {
			response.getWriter().write("unauthorized");
			response.getWriter().close();
			
		}

	
%>
