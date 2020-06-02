<%@page import="java.sql.ResultSet"%>
	<%@page import="bcpms.Conn"%>
		<%@page import="java.sql.PreparedStatement"%>
			<%@page contentType="text/html" pageEncoding="UTF-8"%>
				<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
					<%
	String user_name = request.getParameter("user_name");
	String user_id = request.getParameter("user_id");
	String user_phone_no = request.getParameter("phone_no");
	String user_aadhar_no = request.getParameter("aadhar_no");
	String user_email = request.getParameter("email_id");
	String pass = request.getParameter("password");
	String conf_pass = request.getParameter("confirm_pass");
	String security_ques = request.getParameter("security_ques");
	String security_ans = request.getParameter("security_ans");
	String[] arr = user_name.split(" ");
	session.setAttribute("registration_form_session_key", user_id);
	if (pass.equals(conf_pass))
	{
		if ((user_id.charAt(0) == 'A')&& (user_id.charAt(1) == 'B')) 
		{
			try{
			PreparedStatement ps = new Conn().con.prepareStatement("insert into student(first_name,last_name,student_identity_card,contact_number,adhaar_number,email_id,password,security_question,security_answer)values (?,?,?,?,?,?,?,?,?)");
			ps.setString(1, arr[0]);
			if(arr.length==1){
				ps.setString(2, "");
			}
			else
			{
				ps.setString(2, arr[1]);
			}
			ps.setString(3, user_id);
			ps.setString(4, user_phone_no);
			ps.setString(5, user_aadhar_no);
			ps.setString(6, user_email);
			ps.setString(7, pass);
			ps.setString(8, security_ques);
			ps.setString(9, security_ans);
			if (ps.executeUpdate() > 0)
			{
				response.getWriter().write("../../pages/forms/login.html");
			}
			else 
			{
				response.getWriter().write("incorrect");
			}
			response.getWriter().close();
			ps.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if (user_id.charAt(0) == 'T')
		{
			PreparedStatement ps = new Conn().con.prepareStatement("insert into teacher (first_name,last_name,teacher_identity_card,contact_number,adhaar_number,email_id,password,security_question,security_answer)values (?,?,?,?,?,?,?,?,?)");
			ps.setString(1, arr[0]);
			if(arr.length==1){
				ps.setString(2, "");
			}
			else
			{
				ps.setString(2, arr[1]);
			}
			ps.setString(3, user_id);
			ps.setString(4, user_phone_no);
			ps.setString(5, user_aadhar_no);
			ps.setString(6, user_email);
			ps.setString(7, pass);
			ps.setString(8, security_ques);
			ps.setString(9, security_ans);
			int num = ps.executeUpdate();
			if (num > 0)
			{
				response.getWriter().write("../../pages/forms/teacherreg.html");
			}
			response.getWriter().close();
			ps.close();
		}
		else
		{
			response.getWriter().write("incorrect");
			response.getWriter().close();
		}
	}
	
%>