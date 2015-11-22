<%@page import="javax.portlet.WindowState"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.model.User"%>
<%@include file="init.jsp" %>
<h3>Display users using liferay search container.</h3>
<%

List<User> userList=new ArrayList<User>();
if(renderRequest.getAttribute("userList")!=null){
userList=(List<User>)renderRequest.getAttribute("userList");
}
%>
<c:choose>
<c:when test="<%=!userList.isEmpty()%>">
<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setWindowState(WindowState.NORMAL);
iteratorURL.setParameter("action", "listuserssearchcontainer");
%>
<liferay-ui:search-container emptyResultsMessage="users-list-empty"
headerNames="UserId,User Name,Email"
iteratorURL="<%=iteratorURL %>"
delta="5"
deltaConfigurable="true"
> 
<liferay-ui:search-container-results>
<%
searchContainer.setDeltaConfigurable(true);
searchContainer.setTotal(userList.size());
searchContainer.setDelta(10);
results = ListUtil.subList(userList,searchContainer.getStart(), searchContainer.getEnd());
searchContainer.setResults(results);
%>
</liferay-ui:search-container-results>
<liferay-ui:search-container-row className="User" keyProperty="userId" modelVar="curUser">
<liferay-ui:search-container-column-text name="userId" value="<%=String.valueOf(curUser.getUserId())%>" />
<liferay-ui:search-container-column-text name="user Name" value="<%=curUser.getFullName()%>" />
<liferay-ui:search-container-column-text name="user Name" value="<%=curUser.getEmailAddress()%>" />
</liferay-ui:search-container-row>
<liferay-ui:search-iterator searchContainer="<%=searchContainer %>" />
</liferay-ui:search-container>
</c:when>
<c:otherwise>
<liferay-ui:message key="users-list-empty"></liferay-ui:message>
</c:otherwise>
</c:choose>
