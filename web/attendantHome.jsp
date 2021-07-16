<%-- 
    Document   : attendantHome
    Created on : Feb 8, 2021, 7:06:54 PM
    Author     : Camille
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attendant Access</title>
        <style>
             body {
                background-image: url('images/bg.png');
                background-size: cover;
                background-repeat: no-repeat;
            }
            
            .up{
                width: 100%;
            }
            
            .two {
                width: 280px;
                margin-top: 10px;
                margin-left: 15px;
                display: inline-block;
                float: left;
            }
            
            .out {
                color: #FFFFFF;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 18px;
                margin-left: 712px;
                cursor: pointer;
                background-color: #910707;
                border-radius: 0.8em;
                border: 0;
                padding-top: 10px;
                padding-left: 20px;
                padding-bottom: 10px;
                padding-right: 20px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .buttHome {
                color: #FFFFFF;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 18px;
                background-color: #910707;
                border-radius: 0.8em;
                border: 0;
                padding-top: 10px;
                padding-left: 20px;
                padding-bottom: 10px;
                padding-right: 20px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .buttonOne {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 20px;
                margin-left: 564px;
                cursor: pointer;
                background-color: #FFFFFF;
                border-radius: 1.5em;
                border: 5px solid #910707;
                padding-top: 35px;
                padding-left: 135px;
                padding-bottom: 35px;
                padding-right: 135px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .buttonTwo {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 20px;
                margin-left: 564px;
                cursor: pointer;
                background-color: #FFFFFF;
                border-radius: 1.5em;
                border: 5px solid #910707;
                padding-top: 35px;
                padding-left: 116px;
                padding-bottom: 35px;
                padding-right: 116px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .button-con{
                display: inline-block;
                width: 100%;
                margin-top: 7%;
                align-content: center;
            }
            
            .buttonCon{
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 18px;
                cursor: pointer;
                border: none;
                background-color: transparent;
                padding-top: 10px;
                padding-bottom: 10px;
                text-decoration: none;
            }
            
            #id{
                margin-top: 3%;
            }
            
            #l2, #r2{
                float: right;
                margin-top: 30px;
                margin-right: 25px;
            }
            
            footer {
                background-color: #800000;  
                text-align: center;
                position: fixed;
                padding-bottom: 8px;
                bottom: 0;
                left: 0;
                width: 100%;
            }
            
            .c{
                clear:both;
            }
            
            footer p {
                color: #A64D4D;
                font-family: 'Montserrat';
                font-size: 15px;
            }
            
        </style>
    </head>
    <body>
        <div class="up">
            <img class="two" src="images/accucare.png" />
            <form method="post" action="ContactServlet">
                <input id="r2" type="submit" class="buttonCon" align="center" value="Contact">
            </form>
            <a id="l2" class="buttHome" align="center">Home</a>
        </div>
        
        <div class="c"></div>
        <%
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
                
            if(session.getAttribute("password")== null){
                response.sendRedirect("index.jsp");

            }%>
        
        <div class="button-con">    
        <form method="post" action="NewPatientServlet">
            <input type="submit" class="buttonOne" align="center" name="fromHome" value="New Patient">
        </form>
        
        <form method="post" action="GetIDServlet">
            <input id="id" type="submit" class="buttonTwo" align="center" name="enterIDHome" value="Enter Patient ID">
        </form>
        
        <form action="LogoutServlet">
            <input id="id" class="out" align="center" type="submit" value="Logout">
        </form>
        </div>
        <div class="c"></div>
            
        <footer>
            <div>
                <p class="date">
                    <%
                        model.DateObject d = (model.DateObject) request.getServletContext().getAttribute("date");
                        out.println(d.getDate());
                    %>
                </p>
            </div>
            <p>
                <%
                    out.println(request.getServletContext().getInitParameter("Footer"));
                %>
            </p>
	</footer>
    </body>
</html>
