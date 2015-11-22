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
<h3>Display users using liferay search container with custom table view</h3>
<%

List<User> userList=new ArrayList<User>();
if(renderRequest.getAttribute("userList")!=null){
userList=(List<User>)renderRequest.getAttribute("userList");
}
%>
<c:choose>
<c:when test="<%=!userList.isEmpty()%>">
<%
PortletURL portletURL = renderResponse.createRenderURL();
portletURL.setWindowState(WindowState.NORMAL);
portletURL.setParameter("action", "listusers");
SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM,10, portletURL, null, null);
searchContainer.setDeltaConfigurable(true);
searchContainer.setTotal(userList.size());
List<User> results = new ArrayList<User>();
results = ListUtil.subList(userList,searchContainer.getStart(), searchContainer.getEnd());
int index=1;
%>
<table id="users-table">
			<tr>
			    <th>UserId</th>
			    <th>User Name</th>
                <th>Email</th>			    
			</tr>
<%for(User curUser:results){ if(index%2==0){%>

<tr class="alt">
				<td><%=curUser.getUserId()%></td>
				<td><%=curUser.getFullName()%></td>
				<td><%=curUser.getEmailAddress()%></td>
</tr>
<%
}else{%>
<tr class="">
				<td><%=curUser.getUserId()%></td>
				<td><%=curUser.getFullName()%></td>
				<td><%=curUser.getEmailAddress()%></td>
</tr>
<%}
index=index+1;
}%>
</table>
<liferay-ui:search-paginator searchContainer="<%= searchContainer %>"/>
</c:when>
<c:otherwise>
<liferay-ui:message key="users-list-empty"></liferay-ui:message>
</c:otherwise>
</c:choose>

