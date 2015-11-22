<%@ include file="init.jsp"%>
<h2>User Registration</h2>
<portlet:actionURL var="registrationActionURL" windowState="normal">
<portlet:param name="action" value="userRegistration"/>
</portlet:actionURL>
<form action="<%=registrationActionURL%>" name="<portlet:namespace/>userForm" id="<portlet:namespace/>userForm" method="POST">
<b>Screen Name</b><br />
<input type="text" name="<portlet:namespace/>screeName" id="<portlet:namespace/>screeName" /><br />
<b>Email Address</b><br />
<input type="text" name="<portlet:namespace/>emailAddress" id="<portlet:namespace/>emailAddress" /><br />
<b>First Name</b><br />
<input type="text" name="<portlet:namespace/>firstName" id="<portlet:namespace/>firstName" /><br />
<b>Last Name</b><br /> <input type="text"
name="<portlet:namespace/>lastName" id="<portlet:namespace/>lastName" />
<br />
<input type="radio" name="<portlet:namespace/>sex" value="1">Male<br>
<input type="radio" name="<portlet:namespace/>sex" value="0">Female<br />
<b>Address</b><br />
<textarea rows="4" cols="50" name="<portlet:namespace/>address">
</textarea>
<br /> <input type="button" name="<portlet:namespace/>addUser" id="<portlet:namespace/>addUser"
value="Create Account" />
</form>
<aui:script use="aui-base,aui-node">
A.one('#<portlet:namespace/>addUser').on('click', function(event){
document.<portlet:namespace/>userForm.submit();
});
</aui:script>