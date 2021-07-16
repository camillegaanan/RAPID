<%-- 
    Document   : adminHome
    Created on : Feb 8, 2021, 7:06:45 PM
    Author     : Camille
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Access</title>
        <style>
            body {
                background-image: url('images/bg.png');
                background-size: cover;
                background-repeat: no-repeat;
                /*padding-bottom: 15%; /*responsive*/
            }
            
            .up, .button-con{
                width: 100%;
                overflow: hidden;
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
            
            #con{
                float: right;
                display: inline-block;
                margin-top: 30px;
                margin-right: 25px;
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
            
            .buttonOne, .buttonTwo{
                margin-top: 25%;
            }
            
            .buttonThree, .buttonFour{
                margin-top: 15%;
            }
            
            .buttonOne {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 20px;
                cursor: pointer;
                background-color: #FFFFFF;
                border-radius: 1.5em;
                border: 5px solid #910707;
                padding-top: 35px;
                padding-left: 115px;
                padding-bottom: 35px;
                padding-right: 115px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .buttonTwo {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 20px;
                cursor: pointer;
                background-color: #FFFFFF;
                border-radius: 1.5em;
                border: 5px solid #910707;
                padding-top: 35px;
                padding-left: 92px;
                padding-bottom: 35px;
                padding-right: 92px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .buttonThree {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 20px;
                cursor: pointer;
                background-color: #FFFFFF;
                border-radius: 1.5em;
                border: 5PX solid #910707;
                padding-top: 35px;
                padding-left: 145px;
                padding-bottom: 35px;
                padding-right: 145px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .buttonFour {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 20px;
                cursor: pointer;
                background-color: #FFFFFF;
                border-radius: 1.5em;
                border: 5px solid #910707;
                padding-top: 35px;
                padding-left: 122px;
                padding-bottom: 35px;
                padding-right: 122px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .button-containerl{
                float: left;
                display: inline-block;
                margin-left: 20%;
                align-content: center;
            }
            
            .button-containerr{
                display: inline-block;
                float: right;
                margin-right: 20%;     
                align-content: center;
            }
            
            .c{
                clear:both;
            }
            
            .log{
                width: 7%;
                align-content: center;
                margin: auto;
            }
            
            #l2, #r2{
                float: right;
                margin-top: 30px;
                margin-right: 25px;
            }
            
            footer {
                background-color: #800000;  
                text-align: center;
                position: fixed; /*responsive*/
                padding-bottom: 8px;
                bottom: 0;
                left: 0;
                width: 100%;
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
                
            if(session.getAttribute("username")== null){
                response.sendRedirect("index.jsp");

            }%>

        <div class="button-con">
            <div class="button-containerl">
                <form method="post" action="RecordsServlet">
                    <input type="submit" class="buttonOne" align="center" value="View ALL Records" name="view">
                </form>
                <form method="post" action="NewPatientServlet">
                    <input type="submit" class="buttonThree" align="center" name="fromHome" value="New Patient">
                </form>
            </div>
            
            <div class="button-containerr">
                <form method="post" action="RecordsServlet">
                    <input type="submit" class="buttonTwo" align="center" value="View Today's Records" name="view">
                </form>
                <form method="post" action="GetIDServlet">
                    <input type="submit" class="buttonFour" align="center" name="enterIDHome" value="Enter Patient ID">
                </form>
            </div>
        </div>
        <div class="c"></div>
        <br/>
        <br/>
        <br/>
        <br/>
        <div class="log">
            <form action="LogoutServlet">
                <input class="out" align="center" type="submit" value="Logout">
            </form>
        </div>
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
