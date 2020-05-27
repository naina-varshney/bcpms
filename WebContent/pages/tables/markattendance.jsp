<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	String run_type=request.getParameter("run");
	if(id!=null)
	{
		//To load the attendance table 
		boolean ok = true;
		String date=request.getParameter("attendance_date");
		String month_year[]=date.split("-");
		String course_nature=(String)session.getAttribute("radio");
		if(run_type.equals("load"))
		{
			
			String course_name=request.getParameter("course");
			String course_type=request.getParameter("radio_type");
			String attendance_date=request.getParameter("attendance_date");
			//System.out.println("select student_enrolment_details.Student_course_roll,course_details.Name,student.first_name,student.last_name,JSON_EXTRACT(attendance_details.attendance,'$.'"+month_year[2]+"') as attendance from student_enrolment_details inner join course_details on student_enrolment_details.course_id=course_details.course_id and course_details.Name="+course_name+" and student_enrolment_details.isEnabled=1 inner join student on student_enrolment_details.Student_identity_card=student.Student_Identity_card inner join attendance_details on student_enrolment_details.Student_Identity_card=attendance_details.Student_id and attendance_details.attendance_month="+month_year[1]+" and attendance_year="+month_year[0]+";");
			PreparedStatement ps=new Conn().con.prepareStatement("select student_enrolment_details.Student_course_roll,course_details.Name,student.first_name,student.last_name, TRIM(BOTH '\"' FROM JSON_EXTRACT(attendance_details.attendance,'$.\""+month_year[2]+"\"')) as attendance from student_enrolment_details inner join course_details on student_enrolment_details.course_id=course_details.course_id and course_details.Name=? and student_enrolment_details.isEnabled=1 inner join student on student_enrolment_details.Student_identity_card=student.Student_Identity_card left join attendance_details on student_enrolment_details.Student_Identity_card=attendance_details.Student_id and attendance_details.attendance_month=? and attendance_details.attendance_year=? and attendance_details.course_nature=?;");
			//ps.setString(1,month_year[2]);
			ps.setString(1,course_name);
			ps.setString(2,month_year[1]);
			ps.setString(3,month_year[0]);
			ps.setString(4,Character.toString(course_nature.charAt(0)));
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("Roll_no",rs.getString(1));
				responseObject.put("Student_name",rs.getString(3)+" "+rs.getString(4));
				responseObject.put("Attendance",rs.getString(5));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		//To mark and submit the attendance
		else if(run_type.equals("btn_clicked"))
		{
			String data=request.getParameter("data_object");
			JSONArray dataObject=new JSONArray(data);
			
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
			PreparedStatement ps2;
			ResultSet rs2;
			Connection connection = new Conn().con;
			
			for(int i=0;i<dataObject.length();i++)
			{
				JSONObject jsonobj = (JSONObject) dataObject.get(i);	
			 	//Check whether a particular student's attendance is marked on a particular date or not
			   	ps2 = connection.prepareStatement("select student_id from attendance_details where student_id = (select student_identity_card from student_enrolment_details where student_course_roll=?) and course_id=? and attendance_month=? and attendance_year=? and course_nature=?");
			   	ps2.setString(1,jsonobj.getString("rollno"));
			   	ps2.setString(2,c_id);
			   	ps2.setString(3,month_year[1]);
			   	ps2.setString(4,month_year[0]);
			   	ps2.setString(5,Character.toString(course_nature.charAt(0)));
			   	rs2=ps2.executeQuery();

				if(rs2.next())
				{
		 			//if attendance is marked then update
			   		ps2 = connection.prepareStatement("update attendance_details set attendance=JSON_MERGE_PATCH(attendance,JSON_OBJECT(?,?)) where student_id = ? and attendance_month=? and attendance_year=? and course_id=? and course_nature=?");
			   		ps2.setString(1,month_year[2]);
			   		ps2.setString(2,jsonobj.getString("attendance"));
			   		ps2.setString(3,rs2.getString(1));
			   		ps2.setString(4,month_year[1]);
				   	ps2.setString(5,month_year[0]);
					ps2.setString(6,c_id);
			   		ps2.setString(7,Character.toString(course_nature.charAt(0)));
				   	if(ps2.executeUpdate()<=0)
				   	{
				   		ok=false;
				   	}
				}
				
				else
			   	{
				   	//If not then insert the attendance of that date
				 try{
				   		ps2=connection.prepareStatement("insert into attendance_details(Course_Id,Student_id,course_nature,attendance_month,attendance_year,attendance) values(?,(select student_identity_card from student_enrolment_details where student_course_roll=?),?,?,?,JSON_Object(?,?))");
				   		ps2.setString(1,c_id);
				   		ps2.setString(2,jsonobj.getString("rollno"));
				   		ps2.setString(3,Character.toString(course_nature.charAt(0)));
				   		ps2.setString(4,month_year[1]);
				   		ps2.setString(5,month_year[0]);
				   		ps2.setString(6,month_year[2]);
				   		ps2.setString(7,jsonobj.getString("attendance"));
				   		if(ps2.executeUpdate()<=0)
				   		{
				   			ok=false;
				   		}
				   	}
				   	catch(Exception e)
				   	{
				   			e.printStackTrace();
				   	}
				} 
			}	
		}
		if(ok==true)
		{
			response.getWriter().write("../../pages/forms/mark.html");
			response.getWriter().close();
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