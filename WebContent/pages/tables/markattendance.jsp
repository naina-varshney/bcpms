<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%
String id=(String)session.getAttribute("user_session_key");
String run_type=request.getParameter("run");
if(id!=null)
{
	if(run_type.equals("load")){
	String course_name=request.getParameter("course");
	String course_type=request.getParameter("radio_type");
	String attendance_date=request.getParameter("attendance_date");
	PreparedStatement ps=new Conn().con.prepareStatement("select student_enrolment_details.Student_course_roll,course_details.Name,student.first_name,student.last_name from student_enrolment_details inner join course_details on student_enrolment_details.course_id=course_details.course_id and course_details.Name=? and student_enrolment_details.isEnabled=1 inner join student on student_enrolment_details.Student_identity_card=student.Student_Identity_card;");
	ps.setString(1,course_name);
	ResultSet rs=ps.executeQuery();
	JSONArray responseArray=new JSONArray();
	while(rs.next())
	{
		JSONObject responseObject=new JSONObject();
		responseObject.put("Roll_no",rs.getString(1));
		responseObject.put("Student_name",rs.getString(3)+" "+rs.getString(4));
		responseArray.put(responseObject);
	}
	response.getWriter().write(responseArray.toString());
	response.getWriter().close();
	ps.close();
	rs.close();
	}
	else if(run_type.equals("btn_clicked"))
	{
		String data=request.getParameter("data_object");
		JSONArray dataObject=new JSONArray(data);
		String date=request.getParameter("attendance_date");
		String course_name=request.getParameter("c_name");
		String course_type=request.getParameter("course_type");

		PreparedStatement ps=new Conn().con.prepareStatement("select course_id from course_details where name=?");
		ps.setString(1,course_name);
		ResultSet rs=ps.executeQuery();
		String c_id="";
		if(rs.next())
		{
			c_id=rs.getString(1);
		}
	
		boolean ok=true;
		for(int i=0;i<dataObject.length();i++){
		
			JSONObject jsonobj = (JSONObject) dataObject.get(i);
			
			PreparedStatement ps1=new Conn().con.prepareStatement("select student_identity_card from student_enrolment_details where student_course_roll=?");
			ps1.setString(1,jsonobj.getString("rollno"));
			ResultSet rs1=ps1.executeQuery();
			String student_id="";
			if(rs1.next())
			{
			   	student_id=rs1.getString(1);
			   	
			   	PreparedStatement ps2=new Conn().con.prepareStatement("select student_id from attendance_details where student_id=? and course_id=? and date=?");
			   	ps2.setString(1,student_id);
			   	ps2.setString(2,c_id);
			   	ps2.setString(3,date);
			   	ResultSet rs2=ps2.executeQuery();
			   	if(rs2.next())
			   	{
			   		
			   		PreparedStatement ps3=new Conn().con.prepareStatement("update attendance_details set isPresent=? where student_id=? and date=? and course_id=?");
			   		ps3.setString(1,jsonobj.getString("absent"));
			   		ps3.setString(2,rs.getString(2));
			   		ps3.setString(3,date);
			   		ps3.setString(4,c_id);
			   		
			   		if(ps3.executeUpdate()<=0)
			   		{
			   			ok=false;
			   			System.out.println("Update query exceute");
			   		}
			   	}
			   	else
			   	{
			   		
			   		PreparedStatement ps4=new Conn().con.prepareStatement("insert into attendance_details(date,course_id,isPresent,student_id,course_type) values(?,?,?,?,?)");
			   		ps4.setString(1,date);
			   		ps4.setString(2,c_id);
			   		ps4.setString(3,jsonobj.getString("absent"));
			   		ps4.setString(4,rs1.getString(1));
			   		ps4.setString(5,course_type);
			   	
			   		if(ps4.executeUpdate()<=0)
			   		{
			   			ok=false;
			   			
			   		}
			   		
			   	}
			}
			else{
				
				break;
			}
		
		}
		if(ok==true)
		{
			response.getWriter().write("../../pages/forms/mark.html");
			response.getWriter().close();
		}
		else{
			response.getWriter().write("invalid");
			response.getWriter().close();
		}
		

		
	}
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
}
else
{
	response.getWriter().write("invalid");
	response.getWriter().close();
}

%>