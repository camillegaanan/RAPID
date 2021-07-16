<%@page import="model.Security"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script> 
        <meta name="viewport" content="width-device-width,initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>New Patient</title>
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

            #myInput, .exist{
                font-size: 15px;
                font-family: 'Courier New';
                cursor: pointer;
                padding: 6px;
                border-radius: 50px; 
                float: right;
                margin-top: -5px;
            }

            .exist{
                width: 14%;
                height: 40%;
            }

            .exist-t{
                height: 150px;
                width: 310px;
                overflow-y: auto;
                border-collapse: collapse; /* Collapse borders */
                font-size: 15px;
                margin-left: -110px;
                align-self: stretch;
            }

            .exist-t tr {
                /* Add a bottom border to all table rows */
                border-bottom: 1px solid #ddd;
                background-color: white;
            }

            ::-webkit-scrollbar {
                width: 5px;
            }

            /* Track */
            ::-webkit-scrollbar-track {
                background: #f1f1f1; 
            }

            /* Handle */
            ::-webkit-scrollbar-thumb {
                background: #910707; 
            }

            /* Handle on hover */
            ::-webkit-scrollbar-thumb:hover {
                background: #555; 
            }

            .out {
                border-radius:20px 20px 0 0;
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

            .button{
                width: 100%;
                align-content: center;
                margin: auto;
                width: 28%;
                margin-top: 30px;
                margin-bottom: 30px;

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
                font-weight: bold;
                margin-bottom: 1%;
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


            #l2, #r2{
                float: right;
                margin-top: 36px;
                margin-right: 29px;
                text-decoration: none;
            }


            #b1, #b2, #b3{
                float: left;
            }

            #b1, #b2, #b3, #l2, #r2{
                display: inline-block;
            }

            footer {
                background-color: #800000;  
                text-align: center;
                position: fixed;
                padding-bottom: 8px;
                padding-top: 19px;
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
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script class="header">
            function searchTable() {

                var input, filter, found, table, tr, td, i, j;
                input = document.getElementById("myInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("myTable");
                tr = table.getElementsByTagName("tr");
                if (filter != "") {
                    for (i = 0; i < tr.length; i++) {
                        td = tr[i].getElementsByTagName("td");
                        for (j = 0; j < td.length; j++) {
                            if (td[j].innerHTML.toUpperCase().indexOf(filter) > -1) {
                                found = true;
                            }
                        }
                        if (found) {
                            tr[i].style.display = "";
                            found = false;
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                } else {
                    for (i = 0; i < tr.length; i++) {
                        tr[i].style.display = "none";
                    }
                }
            }
        </script>

        <%
            //can only access page when logged in
            response.setHeader("Cache-Control",
                    "no-cache, no-store, must-revalidate");

            if (session.getAttribute("password") == null || session.
                    getAttribute("username") == null) {
                response.sendRedirect("index.jsp");
            }
            String value = (String) request.getAttribute("session");
            int patientID = Integer.parseInt(request.getAttribute("incomingID").
                    toString());
            String[] arr = request.getAttribute("trans").toString().
                    split("\\s+");
            ArrayList<String> arrL = new ArrayList<String>();
            for (int i = 0; i < arr.length; i++) {
                arrL.add(arr[i]);
            }
            String fam = (String) request.getAttribute("fam");
            String mid = (String) request.getAttribute("mid");
            System.out.println(mid);
            String first = (String) request.getAttribute("first");
            String sex = (String) request.getAttribute("sex");
            String bday = (String) request.getAttribute("bday");
            String add = (String) request.getAttribute("add");
            String cnum = (String) request.getAttribute("cnum");
            String email = (String) request.getAttribute("email");
            String phy = (String) request.getAttribute("phy");
            String mode = (String) request.getAttribute("mode");
            ResultSet res = (ResultSet) request.getAttribute("res");
            String alert = (String) request.getAttribute("getAlert");
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
        <div class="newP"
             <b> New Patient </b>
        </div>

        <div class="c"></div>

        <div class="form">
            <div class="exist">
                <input type="text" id="myInput" placeholder="Type to search" onkeyup="searchTable()">
                <div class="exist-t">    
                    <table id="myTable">
                        <%
                            if (res.first()) {
                                do {
                        %>

                        <tr style="display:none">
                            <td> <%=res.getString("patientid")%>&nbsp;</td>
                                <td><%=Security.decrypt(res.
                                    getString("familyname"))%>&nbsp;</td>
                                <td><%=Security.
                                    decrypt(res.getString("firstname"))%>&nbsp;</td>
                                <td><%=Security.
                                    decrypt(res.getString("birthday"))%></td>
                        </tr>

                        <%
                                } while (res.next());
                            }
                        %>
                    </table>
                </div>
            </div>
            <br>
            <b> Patient ID:</b>  <%=patientID%>
            <br>

            <form method = "POST" action="NewPatientServlet">

                <div>
                    <label><b id="marg">Family Name:</b></label>
                    <input id="marg" type="text" name="familyName" size="26" value ="<%=fam%>" required>
                    <label><b id="pads" >First Name:</b></label>
                    <input id="marg" type="text" name="firstName" size="26" value ="<%=first%>" required>
                    <label><b id="pads" >Middle Name:</b></label>
                    <input id="marg" type="text" name="middleName" value ="<%=mid%>" size="26">
                    <br>
                    <label><b id="marg">Sex:</b></label>
                    <%
                        if (sex.equalsIgnoreCase("m")) {

                    %>
                    <input id="marg" type="radio" name="sex" value="m" checked ="" required>
                    <label id="marg">Male</label>
                    <input id="marg" type="radio" name="sex" value="f">
                    <label id="marg">Female</label>
                    <%                    } else if (sex.equalsIgnoreCase("f")) {
                    %>
                    <input id="marg" type="radio" name="sex" value="m"  required>
                    <label id="marg">Male</label>
                    <input id="marg" type="radio" name="sex" value="f" checked ="">
                    <label id="marg">Female</label>
                    <%
                    } else {
                    %>
                    <input id="marg" type="radio" name="sex" value="m"  required>
                    <label id="marg">Male</label>
                    <input id="marg" type="radio" name="sex" value="f">
                    <label id="marg">Female</label>
                    <%
                        }
                    %>
                    <label><b id="pads" >Birthday:</b></label>
                    <input id="marg" type="date" name="birthday" value="<%=bday%>" size="30" required>
                    <label><b id="pads" >Contact Number:</b></label>
                    <input id="marg" type="text" name="contactNum" size="30" value ="<%=cnum%>" required>
                    <br>
                    <label><b id="marg">Address:</b></label>
                    <input id="marg" type="text" name="address" size="50" value ="<%=add%>" required>
                    <label><b id="pads" >Email:</b></label>
                    <input id="marg" type="text" name="email" size="40" value ="<%=email%>" required><br>
                    <label><b id="marg">Requesting Physician:</b></label>
                    <input id="marg" type="text" name="physician" size="30" value ="<%=phy%>" required>
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
                                   %>     >  

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
                    <label><b>Mode of Payment:</b></label><br>
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
                    <br>
                </div>
                <div class="c"></div>
        </div>

        <div class ="button">
            <input id="b1"  class="out" type="submit" name="createRecord" value="Create Record">
            <div id="my-modalR" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>New Patient</h2>
                    </div>
                    <div class="fas fa-check">
                    </div>
                    <br>
                    <br>
                    <br>  <br>  <br>
                    <div class="modal-body">
                        <p class="p">Record has been created successfully</p>
                    </div>
                    <input class="closeModalR" type="button" value="Okay">
                </div>
            </div>
            <div id="my-modalE" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Patient Record</h2>
                    </div>
                    <div class="far fa-file-alt">
                    </div>
                    <br>
                    <br>
                    <br>  <br>  <br>
                    <div class="modal-body">
                        <p class="p">There is no type of ultrasound chosen</p>
                    </div>
                    <input class="closeModalE" type="button" value="Okay">
                </div>
            </div>
            <button id="b2" name="createPDF" class="out">Create PDF</button>
            <div id="my-modal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Charge Slip</h2>
                    </div>
                    <div class="far fa-file-alt">
                    </div>
                    <br>
                    <br>
                    <br>  <br>  <br>
                    <div class="modal-body">
                        <p class="p">Kindly check your desktop <br>for the PDF File</p>
                    </div>
                    <input class="closeModal" type="button" value="Okay">
                </div>
            </div>
        </div>
        <script>
            var msg = '<%=alert%>';

            if (msg == null) {
                window.addEventListener('load', closeModal);
            } else if (msg == "Yes2") {
                window.addEventListener('load', openModal);
            } else if (msg == "Yes") {
                window.addEventListener('load', openModalR);
            } else if (msg == 'No') {
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
    </div>
    <footer>
        <div>
            <p class="date">
                <%
                    model.DateObject d
                            = (model.DateObject) request.
                                    getServletContext().
                                    getAttribute("date");
                    out.println(d.getDate());
                %>
            </p>
        </div>
        <p>
            <%
                out.println(request.getServletContext().
                        getInitParameter("Footer"));
            %>
        </p>
    </footer>
</body>
</html>
