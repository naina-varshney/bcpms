<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="com.opencsv.CSVWriter" %>
<%@ page import="java.util.*" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{
		String run_type=request.getParameter("run_type");
		if(run_type.equals("load"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select course_details.name from course_details inner join course_assigned_details on course_assigned_details.teacher_id=? and course_assigned_details.Course_Id=course_details.course_id and course_assigned_details.IsEnabled=1;");
			ps.setString(1,id);
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("course_list",rs.getString(1));
				responseArray.put(responseObject);
			}
			
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		else if(run_type.equals("clicked"))
		{
			String course_name=request.getParameter("course_name");
			String attendance_month="0"+request.getParameter("month");
			String attendance_year=request.getParameter("year");
			String course_nature=Character.toString(request.getParameter("course_nature").charAt(0));
			try
			{
				PreparedStatement ps=new Conn().con.prepareStatement("select student_enrolment_details.student_course_roll,student.Student_Identity_card,student.first_name,student.last_name,attendance_details.attendance as attendance from student_enrolment_details inner join student on student.student_identity_card=student_enrolment_details.student_identity_card inner join course_details on course_details.name=? and course_details.Course_Id=student_enrolment_details.Course_Id inner join attendance_details on student_enrolment_details.Student_identity_card=attendance_details.Student_id and attendance_details.attendance_month=? and attendance_details.attendance_year=? and attendance_details.course_nature=?;");
				ps.setString(1,course_name);
				ps.setString(2,attendance_month);
				ps.setString(3,attendance_year);
				ps.setString(4,course_nature);
				ResultSet rs=ps.executeQuery();
				CSVWriter csvWriter=new CSVWriter(new FileWriter("C://Users//Naina Varshney//workspace//BCPMS//WebContent//pages//download//report.csv"));
				List<String> headers = new ArrayList<String>();
				headers.add("Roll no");
				headers.add("Student Identity No.");
				headers.add("Name");
				for(int i=0; i<31;i++){
					headers.add(String.valueOf(i+1));
				}
				csvWriter.writeNext(Arrays.copyOf(headers.toArray(),headers.toArray().length,String[].class));
				while(rs.next())
				{	
					List<String> csvrow = new ArrayList<String>();
					csvrow.add(rs.getString(1));
					csvrow.add(rs.getString(2));
					csvrow.add(rs.getString(3)+" "+rs.getString(4));
					JSONObject obj=new JSONObject(rs.getString(5));
					for(int i=0; i<31;i++){
						try{
							if(i<10){
								csvrow.add(obj.getString("0"+String.valueOf((i+1))));
							}else{
								csvrow.add(obj.getString(String.valueOf((i+1))));
							}
						}catch(NoSuchElementException e){
							csvrow.add("");
						}
					}
					 csvWriter.writeNext(Arrays.copyOf(csvrow.toArray(),csvrow.toArray().length,String[].class));
				}
				csvWriter.close();
				ps.close();
				rs.close();
				response.getWriter().write("http://localhost:9090/BCPMS/pages/download/report.csv");
				response.getWriter().close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
		}
	}
	
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>