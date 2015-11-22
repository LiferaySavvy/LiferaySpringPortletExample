<%@include file="init.jsp" %>
<style>
 .message-container{
 padding:10px;
 margin:2px;
 display:none;
 background: rgba(128, 128, 128, 0.33);
 border: 1px solid #0A0A0C;
 }
 .message-container span{
 font-weight: bold;
 }
.users-table
{
font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
width:100%;
border-collapse:collapse;
}
.users-table td, .customers th 
{
font-size:1.2em;
border:1px solid #98bf21;
padding:3px 7px 2px 7px;
}
.users-table th 
{
font-size:1.4em;
text-align:left;
padding-top:5px;
padding-bottom:4px;
background-color:#A7C942;
color:#fff;
}
 </style>
<portlet:resourceURL id="validateUserbyEmail" var="validateUserByEmailURL">
</portlet:resourceURL>
<div id="<portlet:namespace/>user_validate_container">
<form  method="post" action="<%=validateUserByEmailURL%>" name="<portlet:namespace/>validateUserForm" id="<portlet:namespace/>validateUserForm" >
<b>Email Address</b><br />
<input type="text" name="<portlet:namespace/>emailAddress" id="<portlet:namespace/>emailAddress" /><br />
<input type="button" name="<portlet:namespace/>validateButton" id="<portlet:namespace/>validateButton" value="validate"/>
</form>
<div id="<portlet:namespace/>message-contaner" class="message-container">

</div>
<table id="<portlet:namespace/>UserDisplayContainer" class="users-table">

</table>
</div>

 <aui:script use="aui-base,aui-io-deprecated,aui-io-plugin-deprecated">
 var validdateUserContainer = A.one('#<portlet:namespace/>user_validate_container');
 validdateUserContainer.delegate(
			'click',
			function(event) {
				 var form = A.one('#<portlet:namespace/>validateUserForm');
	             var userUpdateContainer = A.one('#<portlet:namespace/>UserDisplayContainer');
	             validateUserByEmail(form,userUpdateContainer);  
			},
			'#<portlet:namespace/>validateButton'
		);
 
 validateUserByEmail=function(form,updateContainer) {
		A.io.request(form.getAttribute('action'),
			{   
			    dataType: 'json',
				form: {
					id: form.getDOM()
				},
				on: {
					success: function() {
						var userJsonObect=this.get('responseData');
						A.one("#<portlet:namespace/>message-contaner").setStyle("display","block");
						A.one("#<portlet:namespace/>message-contaner").empty();
						updateContainer.empty();
						if(userJsonObect.success){
				            var tableRow='<tr><td>'+userJsonObect.screeName+'</td><td>'+userJsonObect.firstName+
							'</td><td>'+userJsonObect.lastName+'</td><td>'+userJsonObect.email+'</td></tr>';
				            updateContainer.set('innerHTML',tableRow);
				            A.one("#<portlet:namespace/>message-contaner").set('innerHTML',"<span style='color:red;'>User already existed with give email please choose other email.");
						}else{
							A.one("#<portlet:namespace/>message-contaner").set('innerHTML',"<span style='color:green;'>Given email is available.</span>");
							updateContainer.empty();
						}
						
					}
				}
			}
		);
}
 </aui:script>
 