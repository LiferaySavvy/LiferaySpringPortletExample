<%@page import="java.util.LinkedList"%>
<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.model.User"%>
<%@include file="init.jsp" %>
<style>
#users-table
{
font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
width:100%;
border-collapse:collapse;
}
#users-table td, #customers th 
{
font-size:1.2em;
border:1px solid #98bf21;
padding:3px 7px 2px 7px;
}
#users-table th 
{
font-size:1.4em;
text-align:left;
padding-top:5px;
padding-bottom:4px;
background-color:#A7C942;
color:#fff;
}
#users-table tr.alt td 
{
color:#000;
background-color:#EAF2D3;
}
</style>
<%

List<String> userList=new LinkedList<String>();
if(renderRequest.getAttribute("userData")!=null){
	userList=(List<String>)renderRequest.getAttribute("userData");
}
%>
<c:choose>
<c:when test="<%=!userList.isEmpty()%>">
<br/>
<br/>
<table id="users-table">
			<tr>
				<th>firstName</th>
				<th>lastName</th>
				<th>screeName</th>
				<th>emailAddress</th>
				<th>studentGender</th>
				<th>address</th>
			</tr>
			<tr class="alt">
<%
	for (String curUserString : userList) {
%>
<td><%=curUserString %></td>
<%}%>
</tr>
</table>
</c:when>
<c:otherwise>
<div class="message-container" style="display:block;">
<liferay-ui:message key="no-user-data"></liferay-ui:message>
</div>
</c:otherwise>
</c:choose>
<br/>
<br/>
<style>
.message-container{
 padding:10px;
 margin:2px;
 background: rgba(128, 128, 128, 0.33);
 border: 1px solid #0A0A0C;
 }
</style>
