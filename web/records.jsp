

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient records</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
    <%  
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
                
            if(session.getAttribute("username")== null){
                response.sendRedirect("index.jsp");
            }
    %>
            
        
        <a class="out" align="center" href="adminHome.jsp">Home</a>
        <form action="LogoutServlet">
            <input class="out" align="center" type="submit" value="Logout">
        </form>
        
    </body>
</html>
