<%@page import="java.util.ArrayList"%>
<%@page import="model.Security"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script> 
        <meta name="viewport" content="width-device-width,initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>Update a Record</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>


        <style>
            body {
                background-image: url('images/bg.png');
                background-size: cover;
                background-repeat: no-repeat;
                /*padding-bottom: 15%; /*responsive*/
            }

            .up{
                width: 100%;
            }

            .two {
                width: 280px;
                float: left;
                margin-left: 23px;
                margin-top: 18px;
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

            .form{
                font-family: 'Courier New';
                border:grey; 
                border-width:1.5px; 
                border-style:solid;
                border-radius: 50px;
                padding: 20px;
                background-color: hsla(0, 0%, 100%, 0.6);
                align-self: center;
                letter-spacing: 1px;
                margin-left: 5%;
                margin-right: 5%;
                height: 100%;
                -moz-box-shadow:    3px 3px 5px 6px #ccc;
                -webkit-box-shadow: 3px 3px 5px 6px #ccc;
                box-shadow:         3px 3px 5px 6px #ccc;
            }

            .newP{
                text-align: center;
                color: #800000;
                font-size: 25px;
                font-family: 'Montserrat', sans-serif;
                font-style: solid;
            }

            #pads{
                margin-left: 20px;
            }

            #pads,#marg{
                margin-top: 10px;
            }    

            .ultra{
                float: left;
                width: 75%;
            }

            .c{
                clear:both;
            }

            .left{
                float: left;
                width: 45%;
            }

            .ultra-l, .ultra-r{
                float: left;
                width: 40%;
                margin-left: 5%;
            }

            .l-price, .r-price{
                text-align: right;
            }

            .payment{
                margin-left: 85%;
            }        

            .button{
                width: 100%;
                align-content: center;
                margin-left: 15%;
            }

            #l2, #r2{
                float: right;
                margin-top: 36px;
                margin-right: 29px;
                text-decoration: none;
            }

            .button{
                margin: auto;
                width: 28%;
                margin-top: 30px;
                margin-bottom: 30px;
            }

            #b1, #b2, #b3{
                float: left;
                margin-right: 20px;
            }

            #b1, #b2, #b3, #l2, #r2{
                display: inline-block;
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

        </style>
    </head>
    <body>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js">
        </script>
        <%
            //can only access page when logged in
            response.setHeader("Cache-Control",
                    "no-cache, no-store, must-revalidate");

            if (session.getAttribute("password") == null || session.
                    getAttribute(
                            "username") == null) {
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
        <div class="newP">
            <b> Update Record </b>
        </div>

        <div class="form">
            <br>
            <%
                ResultSet rs = (ResultSet) request.getAttribute("results");
                String[] arr = request.getAttribute("trans").toString().
                        split("\\s+");
                ArrayList<String> arrL = new ArrayList<String>();
                for (int i = 0; i < arr.length; i++) {
                    arrL.add(arr[i]);
                }
                String phy = (String) request.getAttribute("phy");
                String mode = (String) request.getAttribute("mode");
                System.out.println(mode);
                String name = (String) request.getAttribute("name");
                String value2 = (String) request.getAttribute("value");
                if (rs.first()) {
                    rs.last();
            %>
            <b> Patient ID:<b>  <%=rs.getString("patientid")%> 
                    <br>
                    <form method = "POST" action="GetIDServlet">
                        <input type="hidden" name="id" value="<%=rs.getString("patientid")%>">

                        <div>
                            <label><b id="marg">Family Name:</b></label>
                                   <input id="marg" type="text" name="familyName" size="30" value="<%=Security.
                                           decrypt(rs.getString("familyname"))%>" required>
                            <label><b id="pads" >First Name:</b></label>
                            <input id="marg" type="text" name="firstName" size="30" value="<%=Security.decrypt(rs.getString("firstname"))%>" required>
                            <label><b id="pads" >Middle Name:</b></label>
                                   <input id="marg" type="text" name="middleName" value="<%=Security.
                                           decrypt(rs.getString("middlename"))%>" size="30">
                            <br>
                            <label><b id="marg">Sex:</b></label>
                            <%
                                if (Security.decrypt(rs.getString("sex")).
                                        equalsIgnoreCase("f")) {
                            %>
                            <input id="marg" type="radio" name="sex" value="m" required>
                            <label id="marg">Male</label>
                            <input id="marg" type="radio" name="sex" value="f" checked="">
                            <label id="marg">Female</label>
                            <%
                            } else {
                            %>
                            <input id="marg" type="radio" name="sex" value="m" checked="" required>
                            <label id="marg">Male</label>
                            <input id="marg" type="radio" name="sex" value="f" >
                            <label id="marg">Female</label>            
                            <%
                                }
                            %>
                            <label><b id="pads" >Birthday:</b></label>
                            <input id="marg" type="date" name="birthday" value="<%=Security.decrypt(rs.getString("birthday"))%>" size="30" required>
                            <label><b id="pads" >Contact Number:</b></label>
                                   <input id="marg" type="text" name="contactNum" size="30" value="<%=Security.
                                           decrypt(rs.getString("contactnum"))%>" required>
                            <br>
                            <label><b id="marg">Address:</b></label>
                            <input id="marg" type="text" name="address" size="80" value="<%=Security.decrypt(rs.getString("address"))%>" required>
                            <label><b id="pads" >Email:</b></label>
                            <input id="marg" type="text" name="email" size="40" value="<%=Security.decrypt(rs.getString("email"))%>" required><br>
                            <label><b id="marg">Requesting Physician:</b></label>
                            <input id="marg" type="text" name="physician" size="50" value = "<%=phy%>" required>
                            <br><br>
                        </div>

                        <div class="ultra">
                            <label><b>Type of Ultrasound:</b> (price indicated)</label><br>
                            <div class="left">
                                <div class="ultra-l">
                                    <input type="checkbox" name="transaction" value="abdominalAorta 1000" 

                                           <%
                                               if (arrL.contains(
                                                       "abdominalAorta")) {
                                           %>
                                           checked=""
                                           <%
                                               }
                                           %>       

                                           <label>Abdominal Aorta</label><br>
                                    <input type="checkbox" name="transaction" value="breast 1100"

                                           <%                 if (arrL.contains("breast")) {
                                           %>
                                           checked=""
                                           <%              }
                                           %>       
                                           >
                                    <label>Breast</label><br>
                                    <input type="checkbox" name="transaction" value="chest 1100"

                                           <%                                          if (arrL.contains("chest")) {
                                           %>
                                           checked=""
                                           <%                                       }
                                           %>  
                                           >
                                    <label>Chest</label><br>
                                    <input type="checkbox" name="transaction" value="inguinalScrotal 1100"

                                           <%              if (arrL.contains(
                                                       "inguinalScrotal")) {
                                           %>
                                           checked=""
                                           <%                                            }
                                           %>                     
                                           >
                                    <label>Inguinal Scrotal</label><br>
                                    <input type="checkbox" name="transaction" value="kub 900"

                                           <%                                          if (arrL.contains("kub")) {
                                           %>
                                           checked=""
                                           <%                                            }
                                           %>                     
                                           >
                                    <label>KUB</label><br>
                                    <input type="checkbox" name="transaction" value="kub-p 1000"

                                           <%                                        if (arrL.contains("kub-p")) {
                                           %>
                                           checked=""
                                           <%                                       }
                                           %>                     
                                           >
                                    <label>KUB-P</label><br>
                                </div>

                                <div class="l-price">
                                    <label>1000 PhP</label><br>
                                    <label>1100 PhP</label><br>
                                    <label>1100 PhP</label><br>
                                    <label>1100 PhP</label><br>
                                    <label>900 PhP</label><br>
                                    <label>1000 PhP</label><br>
                                </div>
                            </div>

                            <div class="right">
                                <div class="ultra-r">
                                    <input type="checkbox" name="transaction" value="neck 1100"
                                           <%    if (arrL.contains("neck")) {
                                           %>
                                           checked=""
                                           <%                            }
                                           %>  
                                           >
                                    <label>Neck</label><br>
                                    <input type="checkbox" name="transaction" value="renal 700"

                                           <%                                              if (arrL.contains("renal")) {
                                           %>
                                           checked=""
                                           <%                                      }
                                           %>                     
                                           >
                                    <label>Renal</label><br>
                                    <input type="checkbox" name="transaction" value="thyroid 1100"

                                           <%                                       if (arrL.contains("thyroid")) {
                                           %>
                                           checked=""
                                           <%                                   }
                                           %>                     
                                           >
                                    <label>Thyroid</label><br>
                                    <input type="checkbox" name="transaction" value="totalAbdomen 1400"

                                           <%                                       if (arrL.contains("totalAbdomen")) {
                                           %>
                                           checked=""
                                           <%                                       }
                                           %>                     
                                           >
                                    <label>Total Abdomen</label><br>
                                    <input type="checkbox" name="transaction" value="upperAbdomen/HBT 800"

                                           <%                                  if (arrL.contains("upperAbdomen/HBT")) {
                                           %>
                                           checked=""
                                           <%                               }
                                           %>                     
                                           >
                                    <label>Upper Abdomen / HBT</label><br>
                                    <input type="checkbox" name="transaction" value="thyroid_TI-RADS 1300"

                                           <%                                         if (arrL.contains("thyroid_TI-RADS")) {
                                           %>
                                           checked=""
                                           <%                                        }
                                           %>                     
                                           >
                                    <label>Thyroid TI-RADS</label><br>

                                </div>

                                <div class="r-price">
                                    <label>1100 PhP</label><br>
                                    <label>700 PhP</label><br>
                                    <label>1100 PhP</label><br>
                                    <label>1400 PhP</label><br>
                                    <label>800 PhP</label><br>
                                    <label>1300 PhP</label><br>
                                </div>
                            </div>
                        </div>

                        <div class="payment">
                            <%
                                if (mode.equalsIgnoreCase("cash")) {
                            %>

                            <input type="radio" name="modeOfPayment" value="cash" required checked="">
                            <label>Cash</label><br>
                            <input type="radio" name="modeOfPayment" value="card">
                            <label>Card</label><br>
                            <input type="radio" name="modeOfPayment" value="others">
                            <%   } else if (mode.equalsIgnoreCase("card")) {
                            %>

                            <input type="radio" name="modeOfPayment" value="cash" required>
                            <label>Cash</label><br>
                            <input type="radio" name="modeOfPayment" value="card" checked="">
                            <label>Card</label><br>
                            <input type="radio" name="modeOfPayment" value="others">

                            <%} else if (mode.equalsIgnoreCase("others")) {
                            %>

                            <input type="radio" name="modeOfPayment" value="cash" required>
                            <label>Cash</label><br>
                            <input type="radio" name="modeOfPayment" value="card" >
                            <label>Card</label><br>
                            <input type="radio" name="modeOfPayment" value="others" checked="">

                            <%
                            } else {
                            %>
                            <input type="radio" name="modeOfPayment" value="cash" required>
                            <label>Cash</label><br>
                            <input type="radio" name="modeOfPayment" value="card">
                            <label>Card</label><br>
                            <input type="radio" name="modeOfPayment" value="others">
                            <%  }
                            %>
                            <label>Others</label><br>

                            <%
                                }
                                rs.close();
                            %>
                            <br>

                        </div>
                        <div class="c"></div>
                        </div>

                        <div class ="button">                                                       
                            <input id="b2" class="out" type="submit" name="<%=name%>" value="<%=value2%>">
                            </form>
                            
                        <!--update record alert-->
                            <div id="my-modal" class="modal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h2>Patient Record</h2>
                                    </div>
                                    <div class="far fa-file-alt">
                                    </div>
                                    <br>
                                    <br><br> <br> 
                                    <div class="modal-body">
                                        <p class="p"> The record has been updated successfully</p>
                                    </div>
                                    <input type="button" class="closeModal" value="Okay"/>
                                </div>
                            </div>
                        <!-- no ultrasound type alert -->
                            <div id="my-modalE" class="modal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h2>Patient Record</h2>
                                    </div>
                                    <div class="far fa-file-alt">
                                    </div>
                                    <br>
                                    <br> <br> 
                                    <br>
                                    <div class="modal-body">
                                        <p class="p">There is no type of<br> ultrasound chosen</p>
                                    </div>
                                    <input class="closeModalE" type="button" value="Okay">
                                </div>
                            </div>
                        <!-- pdf alert -->
                            <div id="my-modalR" class="modal">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h2>Patient Record</h2>
                                    </div>
                                    <div class="far fa-file-alt">
                                    </div>
                                    <br>
                                    <br>
                                    <div class="modal-body">
                                        <br>
                                        <br>
                                        <p class="p">Kindly check your desktop <br>for the PDF File</p>
                                    </div>
                                    <input class="closeModalR" type="button" value="Okay">
                                </div>
                            </div>
                        <%
                            String alert = (String) request.getAttribute("getAlert");
                        %>
                        <script>
                            var  msg = '<%=alert%>';
    
                            if(msg == null){
                                window.addEventListener('load', closeModal);
                            } else if(msg == "Yes"){
                                window.addEventListener('load', openModal);
                            } else if(msg == "Yes2"){
                                window.addEventListener('load', openModalR);
                            }else if(msg == 'No'){
                                window.addEventListener('load', openModalE);
                            }
                            
                            const modal = document.querySelector('#my-modal');
                            const modalR = document.querySelector('#my-modalR');
                            const modalE = document.querySelector('#my-modalE');
                            const closeBtn = document.querySelector('.closeModal');
                            const closeBtnR = document.querySelector('.closeModalR');
                            const closeBtnE = document.querySelector('.closeModalE');
                            
                            closeBtn.addEventListener('click', closeModal);
                            closeBtnR.addEventListener('click', closeModal);
                            closeBtnE.addEventListener('click', closeModal);
                            window.addEventListener('click', outsideClick);

                            function openModal() {
                                modal.style.display = 'block';
                            }
                            
                            function openModalR() {
                                modalR.style.display = 'block';
                            }
                            
                            function openModalE() {
                                modalE.style.display = 'block';
                            }

                            function closeModal() {
                                modal.style.display = 'none';
                                modalR.style.display = 'none';
                                modalE.style.display = 'none';
                            }

                            function outsideClick(e) {
                                if (e.target == modal) {
                                    modal.style.display = 'none';
                                    modalR.style.display = 'none';
                                    modalE.style.display = 'none';
                                }
                                if (e.target == modalR) {
                                    modal.style.display = 'none';
                                    modalR.style.display = 'none';
                                    modalE.style.display = 'none';
                                }
                                if (e.target == modalE) {
                                    modal.style.display = 'none';
                                    modalR.style.display = 'none';
                                    modalE.style.display = 'none';
                                }
                            }
                        </script>

                            <form action="LogoutServlet">
                                <input id="b3" class="out" type="submit" value="Logout">
                            </form>

                            <form method="post" action="GetIDServlet">
                                <input id="id" type="submit" class="out" name="enterIDHome" value="Back">
                            </form>

                        </div>
                        <footer>
                            <div>
                                <p class="date">
                                    <%
                                        model.DateObject d =
                                                (model.DateObject) request.
                                                        getServletContext().
                                                        getAttribute("date");
                                        out.println(d.getDate());
                                    %>
                                </p>
                            </div>
                            <p>
                                <%
                                    out.println(request.getServletContext().
                                            getInitParameter(
                                                    "Footer"));
                                %>
                            </p>
                        </footer>
                        </body>
                        </html>
