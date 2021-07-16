<%-- 
    Document   : error3
    Created on : 02 27, 21, 2:39:20 AM
    Author     : Trixcie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Incorrect Credentials</title>
        <style>
             body {
                background: linear-gradient(
                to right, 
                #800000 0%, 
                #800000 45%, 
                #FAFAFA 45%, 
                #FAFAFA 100%
                );
            } 
            
            .main {
                background-color: #FFFFFF;
                position: absolute;
                top: 0; left: 20px; bottom: 0; right: 20px;
                width: 920px;
                height: 600px;
                margin-top: 105px;
                margin-left: 410px;
                border-radius: 4.5em;
                box-shadow: 0px 22px 55px 2px rgba(0, 0, 0, 0.44);
            }
            
            .sign {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 24px;
                margin-top: 30px;
                margin-left: 25px;

            }
            
            .un {
                width: 76%;
                color: rgba(255, 255, 255, 0.9);
                font-weight: 700;
                font-size: 23px;
                letter-spacing: 1px;
                background: rgba(140, 140, 140, 0.5);
                padding: 10px 45px;
                margin-top: 1px;
                margin-left: 18px;
                margin-bottom: 17px;
                border: none;
                border-radius: 10px;
                box-sizing: border-box;
                text-align: center;
                font-style: italic;
                font-family: 'Calibri', sans-serif;
                text-decoration: none;
            }
    
            .pass {
                width: 76%;
                color: rgba(255, 255, 255, 0.9);
                font-weight: 700;
                font-size: 23px;
                letter-spacing: 1px;
                background: rgba(140, 140, 140, 0.5);
                padding: 10px 45px;
                margin-top: 10px;
                margin-left: 18px;
                margin-bottom: 5px;
                border: none;
                border-radius: 10px;
                box-sizing: border-box;
                text-align: center;
                font-style: italic;
                font-family: 'Calibri', sans-serif;
                text-decoration: none;
            }
    
            .un:focus, .pass:focus {
                border: 2px solid rgba(0, 0, 0, 0.18) !important; 
            }
            
            .login {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 24px;
                margin-bottom: 30px;
                margin-left: 105px;
                cursor: pointer;
                background: white;
                border: 0;
                padding-left: 25px;
                padding-top: 10px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .back {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 24px;
                margin-bottom: 30px;
                margin-left: 75px;
                cursor: pointer;
                background: white;
                border: 0;
                padding-left: 25px;
                padding-top: 10px;
                transition: transform 80ms ease-in;
                transform: scale(0.95);
                text-decoration: none;
            }
            
            .welc {
                padding-top: 40px;
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 55px;
                text-align: right;
            }
            
            .first {
                padding-top: 120px;
                padding-left: 50px;
                color: #FFFFFF;
                font-family: 'Montserrat Alternates', sans-serif;
                font-weight: bold;
                font-style: italic;
                font-size: 60px;
            }
            
            .sec {
                padding-top: 100px;
                padding-left: 52px;
                color: #FFFFFF;
                font-family: 'Montserrat', sans-serif;
                font-size: 21px;
            }
            
            .pic {
                display: flex;
                justify-content: center;
            }
            
            .line {
                display: flex;
                flex-direction: column;
            }
            
            .logo {
                width: 350px;
                height: auto;
            }
            
            .two {
                width: 350px;
            }
            
            .try {
                color: #910707;
                opacity: 0.5;
                font-family: 'Montserrat', sans-serif;
                font-style: italic;
                font-size: 15px;
                margin-top: 5px;
                margin-left: 25px;
                margin-bottom: 30px;
            }
            @media (max-width: 600px) {
            .main {
                border-radius: 0px;
            }
        </style>
    </head>
    <body>
        <p class="first">Accucare
            <br>Diagnostic
            <br>Center</p>
 
        <p class="sec">Cabana N3/1st Floor - Spaces
            <br>A and B, Kilometers 44/45
            <br>MacArthur Highway, Longos,
            <br>Malolos 3000 Bulacan</p>
        
        <div class="main">
            <div class="pic" style="align-items: center">
            <p class="welc" align="left">Welcome to </p> <img class="logo" src="images/accucare.png" />
            </div>
            <br>
            <form class="pic" method="post" action="LoginAttendantServlet" autocomplete="off">
                <div>
                <p class="un" style="width: 290px">Username</p>
                <p class="pass" style="width: 290px">Password</p>
                <p class="try" align="center">incorrect password</p>
                <a class="back" href="admin.jsp">Try Again</a>
                </div>
                <img class="two" src="images/doc.png" />
            </form>
        </div>
    </body>
</html>
