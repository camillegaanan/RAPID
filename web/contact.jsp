

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact</title>
        <style>
            body {
                background-image: url('images/bg.png');
                background-size: cover;
                background-repeat: no-repeat;
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

            .buttContact {
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

            .main {
                background-color: #FFFFFF;
                width: 620px;
                height: 400px;
                margin-left: 30%;
                border-radius: 4.5em;
                box-shadow: 0px 11px 22px 2px rgba(0, 0, 0, 0.44);
            }

            .logo {
                width: 280px;
                margin-top: 10px;
                margin-left: 15px;
            }

            .search {
                width: 210px;
                margin-top: 196px;
                margin-left: 15px;
                border-radius: 2.5em;
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
                margin-left: 40px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }

            .con {
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

            .home {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 18px;
                cursor: pointer;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
                padding-top: 10px;
                padding-left: 20px;
                padding-bottom: 10px;
                padding-right: 20px;
            }

            .sign {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 23px;
                margin-top: 30px;
                margin-left: 45px;
                float: left;
            }

            .sign2 {
                color: #8C8C8C;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 25px;
                margin-top: 30px;
                margin-left: 40px;
                float: left;
            }

            .cont {
                width: 800px;
                margin: auto;
            }
            #first {
                width: 380px;
                float: left;
                height: 300px;
            }
            #second {
                width: 260px;
                float: left;
                height: 300px;
                color: white;
            }
            #clear {
                clear: both;
            }

            .up{
                width: 100%;
            }

            #l2, #r2{
                float: right;
                margin-top: 30px;
                margin-right: 31px;
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

            footer p {
                color: #A64D4D;
                font-family: 'Montserrat';
                font-size: 15px;
            }
            
            #bottomButtons {
                margin-top: 3%;
                align-items: center;
                display: flex;
                width: 20%;
                padding-left: 44%;
            }

        </style>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("password") == null || session.getAttribute("username") == null) {
                response.sendRedirect("index.jsp");
            }
            String value = (String) request.getAttribute("session");
        %>
        <div id="up">
            <img class="logo" src="images/accucare.png" />
            <a id="l2" class="buttContact" align="center">Contact</a>
            <a id="r2" class="buttonCon" align="center" href="<%=value%>.jsp">Home</a>
        </div>


        <br/>
        <div class="main">
            <br/>
            <br/>
            <div class='cont'>
                <div id="first">
                    <div class="container" style="display: flex; height: 50px;">
                        <div style="width: 50%;">
                            <p class="sign">Main Office</p>
                        </div>
                        <div style="flex-grow: 1;">
                            <p class="sign2">760 6465</p>
                        </div>
                    </div>
                    <div class="container" style="display: flex; height: 50px;">
                        <div style="width: 50%;">
                            <p class="sign">Developers</p>
                        </div>
                        <div style="flex-grow: 1;">
                            <p class="sign2">750-3824</p>
                        </div>
                    </div>
                </div>
                <div id="second">
                    <img class="search" src="images/search.png">
                </div>
            </div>
        </div>
        <div id='bottomButtons' class="button">
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
