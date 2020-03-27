<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%
String id=(String)session.getAttribute("user_session_key");
String execute=request.getParameter("run");

if(id!=null){
	if(execute.equals("load")){
		PreparedStatement ps=new Conn().con.prepareStatement("select teacher.first_name,teacher.last_name from teacher ");
	//	ps.setString(1,designation);
		ResultSet rs=ps.executeQuery();
		JSONArray responseArray=new JSONArray();
		while(rs.next())
		{
			JSONObject responseObject=new JSONObject();
			responseObject.put("teacher_name",rs.getString(1)+" "+rs.getString(2));
			responseArray.put(responseObject);
		}
		response.getWriter().write(responseArray.toString());
		response.getWriter().close();
		ps.close();
		rs.close();
		
	}
	else if(execute.equals("calculate")){
		float theory_salary=0.0F,practical_salary=0.0F;
		
		String fromDate=request.getParameter("from_date");
		String toDate=request.getParameter("to_date");
		String designation=request.getParameter("designation");
		
		int No_of_theoryClass=Integer.parseInt(request.getParameter("theory"));
		int No_of_practicalClass=Integer.parseInt(request.getParameter("practical"));
		
		PreparedStatement ps=new Conn().con.prepareStatement("select amount from remuneration_calculation where course_nature='Theory' and designation_name=?");
		ps.setString(1,designation);
		ResultSet rs=ps.executeQuery();
		if(rs.next())
		{
			theory_salary=rs.getFloat(1);
		}
		PreparedStatement ps1=new Conn().con.prepareStatement("select amount from remuneration_calculation where course_nature='Practical' and designation_name=?");
		ps1.setString(1,designation);
		ResultSet rs1=ps1.executeQuery();
		if(rs1.next())
		{
			practical_salary=rs1.getFloat(1);
		}
		float remuneration=(No_of_theoryClass*theory_salary)+(No_of_practicalClass*practical_salary);
		response.getWriter().write(Float.toString(remuneration));
		response.getWriter().close();
		ps.close();
		ps1.close();
		rs.close();
		rs1.close();
	}
	else if(execute.equals("store"))
	{
		String start_date=request.getParameter("start_date");
		String end_date=request.getParameter("end_date");
		String teacher_name=request.getParameter("teacher_name");
		String[] name=teacher_name.split(" ");
		//System.out.println("name[0]"+name[0]+"name[1]"+name[1]);
		String first_name=name[0];
		String last_name=name[1];
		float amount=Float.parseFloat(request.getParameter("amount"));
		PreparedStatement ps1=new Conn().con.prepareStatement("select teacher_identity_card from teacher where first_name=? and last_name=?");
		ps1.setString(1,first_name);
		ps1.setString(2,last_name);
		ResultSet rs=ps1.executeQuery();
		String teacher_identity_card="";
		if(rs.next()){
			teacher_identity_card=rs.getString(1);
		}
		PreparedStatement ps=new Conn().con.prepareStatement("insert into remuneration (teacher_id,start_date,end_date,amount) values(?,?,?,?)");
		ps.setString(1,teacher_identity_card);
		ps.setString(2,start_date.toString());
		ps.setString(3,end_date.toString());
		ps.setFloat(4,amount);
		if(ps.executeUpdate()>0)
		{
			response.getWriter().write("inserted");
		}
		response.getWriter().close();
		ps.close();
		ps1.close();
		rs.close();
	}
	else if(execute.equals("addDesignation"))
	{
		String teacher=request.getParameter("teacher_name");
		//System.out.println("teacher name"+" "+teacher);
		String[] name=teacher.split(" ");
		//System.out.println("name[0]"+" "+name[0]);
		//System.out.println("name[1]"+" "+name[1]);
		PreparedStatement ps=new Conn().con.prepareStatement("select designation.designation_name,designation.designation_id from designation inner join teacher where designation.designation_id=teacher.Designation_id and teacher.first_name=? and teacher.Last_name=?");
		ps.setString(1,name[0]);
		ps.setString(2,name[1]);
		ResultSet rs=ps.executeQuery();
		if(rs.next())
		{
			response.getWriter().write(rs.getString(1));
		}
		else
		{
			response.getWriter().write("invalid");
		}
		response.getWriter().close();
		ps.close();
		rs.close();
	}
}
else
{
	response.getWriter().write("invalid");
	response.getWriter().close();
}
	
%>