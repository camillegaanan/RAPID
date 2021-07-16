<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script> 
        <meta name="viewport" content="width-device-width,initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>Enter Patient ID</title>
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
            
            .form{
                background-color: #FFFFFF;
                align-content: center;
                width: 35%;
                height: 65%;
                margin-top: 5%;
                margin-left: 33%;
                border-radius: 4.5em;
                box-shadow: 0px 22px 55px 2px rgba(0, 0, 0, 0.44);
                margin: auto;
                text-align: center;
            }
            
            .two {
                width: 280px;
                float: left;
                margin-left: 15px;
                margin-top: 10px;
            }
            .qr{
                width: 50%;
                height: 25%;
            }
            
            .newP{
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 22px;
                position: absolute;
                
            }
            
            .desc{
                color: #000000;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                opacity: 0.5;
                font-size: 16px;
                text-align: center;
                top: 20%;
                width: 10%;
                padding-left: 3%;
            }
            
            .out , .cont {
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
                display: inline-block;
            }
            
            .bottomButtons {
                margin-top: 3%;
                display: flex;
                width: 20%;
                padding-left: 42%;
            }
            
            #l2, #r2{
                float: right;
                margin-top: 30px;
                margin-right: 25px;
            }
           
            #marg{
                margin-bottom: 5%;
            }
            .up{
                width: 100%;
            }
            
            .c{
                clear:both;
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
            
            .pageHeader {
                text-align: center;
                color: #910707;
                font-size: 25px;
                font-family: 'Montserrat';
                font-weight: bold;
                width: 100%; 
            }
            
        </style>
    </head>
    <body>
        
    <%  
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
                
            if(session.getAttribute("password")== null || session.getAttribute("username")== null){
                response.sendRedirect("index.jsp");
            }
            String value = (String) request.getAttribute("session");
    %>
        
        <div class="up">
            <img class="two" src="images/accucare.png" />
            <form method="post" action="ContactServlet">
                <input id="l2" type="submit" class="buttonCon" align="center" value="Contact">
            </form>
        
            <a id="r2" class="buttonCon" align="center" href="<%=value%>.jsp">Home</a>
        </div>
        <br>

        <div class="c"></div>
        
        <div class="pageHeader">
            <p>Enter Patient ID</p>
        </div>
        
        <form method = "POST" action="GetIDServlet">
        <div class ="form">
            <img class="qr" src="images/qrcode.png"/>
            <br>
            <a class="desc">Scan the QR of the patient using a mobile device <br> and insert the Patient ID below</a>
            <br>
            <br>
           <input id="marg" type="text" name="id" required>
        </div>
        

        <div class="bottomButtons">
               <input class="cont" type="submit" name ="enterID" value="Continue">
            </form>
                <div id="my-modal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Patient ID</h2>
                        </div>
                        <div class="far fa-file-alt">
                        </div>
                        <br>
                        <br><br> <br> 
                        <div class="modal-body">
                            <p class="p"> There is no existing record <br> for the Patient ID</p>
                        </div>
                        <input type="button" class="close" value="Okay"/>
                    </div>
                </div>
                <%
                    String alert = (String) request.getAttribute("getAlert");
                %>
                <script>
                    var msg = '<%=alert%>';

                    if (msg == 'No'){
                        window.addEventListener('load', openModal);
                    }else{
                        window.addEventListener('load', closeModal);
                    }

                    const modal = document.querySelector('#my-modal');
                    const closeBtn = document.querySelector('.close');

                    closeBtn.addEventListener('click', closeModal);
                    window.addEventListener('click', outsideClick);

                    function openModal() {
                        modal.style.display = 'block';
                    }

                    function closeModal() {
                        modal.style.display = 'none';
                    }

                    function outsideClick(e) {
                        if (e.target == modal) {
                            modal.style.display = 'none';
                        }
                    }
                </script>
            
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
