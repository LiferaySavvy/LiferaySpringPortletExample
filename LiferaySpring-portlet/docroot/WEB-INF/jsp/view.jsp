<%@include file="init.jsp" %>
<portlet:renderURL var="listUsersURL">
	<portlet:param name="action" value="listusers"/>
</portlet:renderURL>
<portlet:renderURL var="listUsersSearchContainerURL">
	<portlet:param name="action" value="listuserssearchcontainer"/>
</portlet:renderURL>

<portlet:renderURL var="validateUserURL">
	<portlet:param name="action" value="validateUser"/>
</portlet:renderURL>
<portlet:renderURL var="viewUserRigistrationURL">
	<portlet:param name="action" value="viewUserRigistration"/>
</portlet:renderURL>
<portlet:resourceURL id="validateUser" var="validateUserURL1">
</portlet:resourceURL>



<portlet:renderURL var="jspPageOneURL">
	<portlet:param name="action" value="jsppage_one"/>
</portlet:renderURL>

<portlet:renderURL var="jspPageTwoURL">
	<portlet:param name="action" value="jsppage_two"/>
</portlet:renderURL>

<portlet:renderURL var="jspPageThreeURL">
	<portlet:param name="action" value="jsppage_three"/>
</portlet:renderURL>


 
            <a href="<%=listUsersURL%>"> List Users </a><br/>
            <a href="<%=validateUserURL%>">Validate User Email</a><br/>
            <a href="<%=listUsersSearchContainerURL%>">Users Search Container</a><br/>
             <a href="<%=viewUserRigistrationURL%>">User Registration</a><br/>
        	