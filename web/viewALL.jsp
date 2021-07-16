<%-- 
    Document   : viewALL
    Created on : Mar 3, 2021, 9:14:23 PM
    Author     : Camille
--%>


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
        <title>View ALL</title>
        <style>
            body {
                background-image: url('images/bg.png');
                background-size: cover;
                background-repeat: no-repeat;
                padding-bottom: 15%; /*responsive*/
            }

            .main {
                background-color: #FFFFFF;
                position: absolute;
                top: 0; left: 20px; bottom: 0; right: 20px;
                width: 580px;
                height: 400px;
                margin-top: 170px;
                margin-left: 470px;
                border-radius: 4.5em;
                box-shadow: 0px 11px 22px 2px rgba(0, 0, 0, 0.44);
            }

            .up{
                width: 100%;
            }

            .two {
                width: 280px;
                float: left;
                margin-left: 15px;
                margin-top: 10px;
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

            .out{
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

            #l2, #r2{
                float: right;
                margin-top: 30px;
                margin-right: 25px;
                text-decoration: none;
            }

            .c{
                clear:both;
            }

            .sign {
                color: #910707;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 24px;
                margin-top: 30px;
                margin-left: 50px;
                float: left;
            }

            .second {
                color: #8C8C8C;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 24px;
                margin-top: 30px;
                margin-left: 10px;
                float: left;
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

            .searchtext {
                color: #FFFFFF;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 15px;
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

            #table {
                padding: 8px;
                font-family: 'Montserrat', sans-serif;
                border-collapse: collapse;
                /*                border-radius: 0.8em;*/
                width: 95%;
                text-align: center;
            }

            #table th {
                padding-top: 12px;
                padding-bottom: 12px;
                background-color: #910707;
                color: #FFFFFF;
                font-family: 'Montserrat', sans-serif;
                font-weight: bold;
                font-size: 15px;
                border-collapse: collapse;
                vertical-align: middle;
                text-align: center;
                border: 1px solid #910707;
            }

            #table td {
                border: 1px solid black;
                height: 30px;
                font-family:'Courier New';
                font-size: 17px;
                word-wrap: break-word;
                padding: 5px;
            }
            
            .name {
                width: 6%;
            }
            
            .address {
                width: 15%;
            }
            
            .email {
                width: 8%;
                word-break: break-all;
            }

            .t{
                overflow-x: auto;
                height: 430px;
                margin-left: 5px;
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

            .pageHeader {
                text-align: center; /*responsive*/
                color: #910707;
                font-size: 25px;
                font-family: 'Montserrat';
                font-weight: bold;
                width: 100%; /*responsive*/
            }

            .search{
                float: right;
                margin-right: 45px;
                font-family: 'Montserrat', sans-serif;
                margin-bottom: 1%;
            }

            #cases, #fam, #case_type, #family2, #ultra2, #date2{
                font-size: 15px;
                font-family: 'Courier New';
                cursor: pointer;
                padding: 8px;
                border-radius: 0.8em; 
            }

            .top{
                width: 100%;
                display: inline-block;
            }

            #date{
                font-size: 15px;
                font-family: 'Courier New';
                cursor: pointer;
                padding: 5px;
                border-radius: 0.8em; 
                margin-top: -2px;
            }

            .hidden{
                float: right;
                margin-right: 6px;
            }

            #bottomButtons {
                margin-top: 3%;
                align-items: center;
                display: flex;
                width: 20%;
                padding-left: 42%;
            }

            .out2{
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

                background-image: url('images/delete2.png');
                background-color: transparent;
                background-size: contain;
                background-repeat:no-repeat;
                border: none;
                width: 26px;
                height: 26px;
                cursor: pointer;
                color: transparent;
                padding-top: 3px;
                margin-left: 11px;
            }
        </style>
    </head>
    <body>
        <script>

            function change(nameSelect) {
                if (nameSelect) {
                    famValue = document.getElementById("family2").value;
                    ultraValue = document.getElementById("ultra2").value;
                    dateValue = document.getElementById("date2").value;
                    if (famValue === nameSelect.value) {
                        document.getElementById("family").style.display = "block";
                    } else {
                        document.getElementById("family").style.display = "none";
                    }
                    if (ultraValue === nameSelect.value) {
                        document.getElementById("ultra").style.display = "block";
                    } else {
                        document.getElementById("ultra").style.display = "none";
                    }
                    if (dateValue === nameSelect.value) {
                        document.getElementById("date").style.display = "block";
                    } else {
                        document.getElementById("date").style.display = "none";
                    }
                } else {
                    document.getElementById("family").style.display = "none";
                    document.getElementById("ultra").style.display = "none";
                    document.getElementById("date").style.display = "none";
                }
            }
        </script>
        <%
            //can only access page when logged in
            response.setHeader("Cache-Control",
                    "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
        <div class="up">
            <img class="two" src="images/accucare.png" />
            <form method="post" action="ContactServlet">
                <input id="l2" type="submit" class="buttonCon" align="center" value="Contact">
            </form>

            <a id="r2" class="buttonCon" align="center" href="adminHome.jsp">Home</a>
        </div>
        <div class="c"></div>
        <div class="pageHeader">
            <p>View ALL Records</p>
        </div>
        <div class="top">
            <form method="post" action="RecordsServlet">
                <div class="search">

                    <select name="cases" id="cases" onchange="change(this);">
                        <option selected="true" disabled="disabled" hidden="">Search by</option>
                        <option value="family" id = "family2">Family Name</option>
                        <option value="ultra" id = "ultra2">Type of Ultrasound</option>
                        <option  value="date" id = "date2">Date</option>
                    </select>
                    <input id="s1" type="hidden" name ="searchCheck" value="all">
                    <input id="s2" type="submit" align="center" value="Search" name="view" class="searchtext">
                </div>
                <div class="hidden">
                    <div class="check" id="family" style="display:none;">
                        <input type="text" id="fam" name="fam" placeholder="Enter Family Name">
                    </div>

                    <div class="check" id="ultra" style="display:none;">
                        <select name="case" id="case_type">
                            <option value="abdominalAorta">Abdominal Aorta</option>
                            <option value="breast">Breast</option>
                            <option value="chest">Chest</option>
                            <option value="inguinalScrotal">Inguinal Scrotal</option>
                            <option value="kub">KUB</option>
                            <option value="kub-p">KUB-P</option>
                            <option value="neck">Neck</option>
                            <option value="renal">Renal</option>
                            <option value="thyroid">Thyroid</option>
                            <option value="totalAbdomen">Total Abdomen</option>
                            <option value="upperAbdomen/HBT">Upper Abdomen / HBT</option>
                            <option value="thyroid_TI-RADS">Thyroid TI-RADS</option>
                        </select>
                    </div>

                    <div class="check" id="date" style="display:none;">
                        <input type="date" id="date" name="filterSearch">
                    </div>
                </div>
            </form>
        </div>
        <div class="c"></div>

        <div class="t">
            <table align="center" id="table">
                <thead>
                    <tr>        
                        <th>
                            PatientID
                        </th>
                        <th class="name">
                            Family Name
                        </th>
                        <th class="name">
                            First Name
                        </th>
                        <th class="name">
                            Middle Name
                        </th>
                        <th>
                            Sex
                        </th>
                        <th>
                            Birthday
                        </th>
                        <th>
                            Contact No.
                        </th>
                        <th class="address">
                            Address
                        </th>
                        <th class="email">
                            Email
                        </th>
                        <th>
                            Type of Ultrasound
                        </th>
                        <th>
                            Price
                        </th>
                        <th>
                            Date
                        </th>
                        <th>
                            Delete
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ResultSet rs = (ResultSet) request.getAttribute(
                                "results");
                        String del = "";
                        int i = 0;
                        if (rs.first()) {

                            do {%>

                    <tr>
                        <td>
                            <%=rs.getString("patientid")%> 
                        </td>
                        <td>
                            <%=Security.
                                    decrypt(rs.getString("familyname"))%> 
                        </td>
                        <td>
                            <%=Security.decrypt(rs.getString("firstname"))%> 
                        </td>
                        <td>
                            <%=Security.
                                    decrypt(rs.getString("middlename"))%> 
                        </td>
                        <td>
                            <%=Security.decrypt(rs.getString("sex"))%> 
                        </td>
                        <td>
                            <%=Security.decrypt(rs.getString("birthday"))%> 
                        </td>
                        <td>
                            <%=Security.
                                    decrypt(rs.getString("contactnum"))%> 
                        </td>
                        <td>
                            <%=Security.decrypt(rs.getString("address"))%> 
                        </td>
                        <td class="email">
                            <%=Security.decrypt(rs.getString("email"))%> 
                        </td>
                        <td>
                            <%=Security.decrypt(rs.getString(
                                    "typeoftransaction"))%> 
                        </td>
                        <td>
                            PhP <%=Security.decrypt(rs.getString("price"))%> 
                        </td>
                        <td>
                            <%=Security.
                                    decrypt(rs.getString("datetoday"))%> 
                        </td>
                        <%del = rs.getString("recordid");%>
                        <td>
                            <button class="out2" id='<%="id" + i%>' onclick="openModal1(this.id);" value="<%=del%>"></button>
                        </td>
                    </tr>
                    <%i++;
                        } while (rs.next());
                    } else {
                    %>

                    <tr><td colspan='13' align='center'>no record yet</td></tr>

                    <%
                        }
                        rs.close();%>
                </tbody>
            </table>
            <div id="my-modal-dlt" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Delete Record</h2>
                    </div>
                    <div class="fas fa-trash-alt">
                    </div>
                    <br>
                    <br>
                    <div class="modal-body">
                        <p class="p">Are you sure you want <br> to delete this record?</p>
                    </div>
                    <form method = "POST" action="RecordsServlet">

                        <input type="hidden" name="deleteCheck" value="all">
                        <input type="hidden" id="dell" name="delete" value="">
                        <input type="submit" name="view" value="Delete" class="closeDlt" >
                    </form>
                    <input type="button" value="Cancel" class="closeDlt1" >
                </div>
            </div> 
            <script>
                const modalDlt = document.querySelector('#my-modal-dlt');
                const closeBtnDlt = document.querySelector('.closeDlt');
                const closeBtnDlt1 = document.querySelector('.closeDlt1');

                closeBtnDlt.addEventListener('click', closeModal);
                closeBtnDlt1.addEventListener('click', closeModal);
                window.addEventListener('click', outsideClick);

                function openModal1(id) {
                    modalDlt.style.display = 'block';
                    const dell = document.getElementById(id).value;
                    document.getElementById("dell").value = dell;
                }

                function closeModal() {
                    modalDlt.style.display = 'none';
                }

                function outsideClick(e) {
                    if (e.target == modalDlt) {
                        modalDlt.style.display = 'none';
                    }
                }
            </script>
        </div>



        <div id='bottomButtons' class="button">
            <p>
            <form action="LogoutServlet">
                <input class="out" type="submit" value="Logout">
            </form>
            <div class ="button">
                <form method="post" action="RecordsServlet">
                    <input type="hidden" name="viewCheck" value="all">
                    <input type="submit" class="out" value="Download" name="view"/>
                </form>
                <div id="my-modal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Download All Records</h2>
                        </div>
                        <div class="far fa-file-alt">
                        </div>
                        <br>
                        <br><br><br><br>
                        <div class="modal-body">
                            <p class="p">Kindly check your desktop <br>for the PDF File</p>
                        </div>
                        <input type="button" class="close" value="Okay"/>
                    </div>
                </div>
            </div>
            <%
                String alert = (String) request.getAttribute("getAlert");
            %>
            <script>
                var msg = '<%=alert%>';

                if (msg == 'Yes') {
                    window.addEventListener('load', openModal);
                } else {
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

        </p>
    </div> 


    <footer>
        <div>
            <p class="date">
                <%
                    model.DateObject d = (model.DateObject) request.
                            getServletContext().getAttribute("date");
                    out.println(d.getDate());
                %>
            </p>
        </div>
        <p>
            <%
                out.println(request.getServletContext().getInitParameter(
                        "Footer"));
            %>
        </p>
    </footer>


</body>
</html>


