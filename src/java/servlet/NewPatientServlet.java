package servlet;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.ExceptionConverter;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Attendant;
import model.Patient;
import model.Record;

/**
 *
 * @author Camille
 */
public class NewPatientServlet extends HttpServlet {

    Connection con;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName"));
            String username = getServletContext().getInitParameter("dbUserName");
            String password = getServletContext().getInitParameter("dbPassword");
            String url = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(url, username, password);

        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - " +
                    sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - " +
                    nfe.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            boolean isAttendant = (session.getAttribute("password") != null); //true if attendant, false if admin
            String queryALL =
                    "SELECT * FROM PatientDB";
            Statement psALL = con.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);

            int patientID = 1;
            if (request.getParameter("fromHome") != null) {//will display incoming patient id, command will come from Admin/Attendant Home
                String queryID =
                        "SELECT MAX(patientID) as currentID FROM patientDB";
                Statement stmtID = con.createStatement();
                ResultSet rs = stmtID.executeQuery(queryID);
                if (rs.next()) {
                    patientID += rs.getInt("currentID");
                }

                ResultSet res = psALL.executeQuery(queryALL);
                request.setAttribute("res", res);
                request.setAttribute("incomingID", patientID);
                request.setAttribute("trans", "");
                request.setAttribute("fam", "");
                request.setAttribute("mid", "");
                request.setAttribute("first", "");
                request.setAttribute("sex", "");
                request.setAttribute("bday", "");
                request.setAttribute("cnum", "");
                request.setAttribute("add", "");
                request.setAttribute("email", "");
                request.setAttribute("phy", "");
                request.setAttribute("mode", "");
                request.setAttribute("getAlert", null);
            }

            if (request.getParameter("createRecord") != null) { //will only attempt to insert if from newPatient jsp
                Patient p = new Patient();
                Attendant att = new Attendant(con);

                String familyName = request.getParameter("familyName");
                String firstName = request.getParameter("firstName");
                String middleName = request.getParameter("middleName");
                String sex = request.getParameter("sex");
                String birthday = request.getParameter("birthday");
                String contactNum = request.getParameter("contactNum");
                String address = request.getParameter("address");
                String email = request.getParameter("email");

                p.setName(familyName, middleName, firstName);
                p.setGender(sex);
                p.setBirthday(birthday);
                p.setContactNum(contactNum);
                p.setAddress(address);
                p.setEmail(email);
                int up = att.addPatient(p);
                if (up > 0) {
                    Record r = new Record();
                    String getPatientID =
                            "SELECT MAX(patientid) as currentID from patientdb";
                    Statement stmtID = con.createStatement();
                    ResultSet rs = stmtID.executeQuery(getPatientID);
                    if (rs.next()) {
                        int patientID2 = Integer.parseInt(rs.getString(
                                "currentid"));
                        model.DateObject d = (model.DateObject) request.
                                getServletContext().getAttribute("date");
                        SimpleDateFormat date = new SimpleDateFormat(
                                "yyyy-MM-dd");
                        SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");

                        String dateToday = date.format(d.getDate());
                        String timeToday = time.format(d.getDate());
                        String physician = request.getParameter("physician");
                        String mode = request.getParameter("modeOfPayment");
                        String transaction[] = request.getParameterValues(
                                "transaction");
                        r.setPatientID(patientID2);
                        r.setDate(dateToday);
                        r.setTimestamp(timeToday);
                        r.setPhysician(physician);
                        r.setModeOfPayment(mode);
                        r.setTransArray(transaction);

                        String transArr = "";
                        try {
                            for (int i = 0; i < transaction.length; i++) {
                                int count = att.addRecord(r, i, transArr);
                                String[] splited = r.getTransArray()[i].
                                        split("\\s+");
                                String trans = splited[0];
                                transArr += trans + " ";
                                if (count > 0) {
                                    request.setAttribute("fam", familyName);
                                    request.setAttribute("mid", middleName);
                                    request.setAttribute("first", firstName);
                                    request.setAttribute("sex", sex);
                                    request.setAttribute("bday", birthday);
                                    request.setAttribute("cnum", contactNum);
                                    request.setAttribute("add", address);
                                    request.setAttribute("email", email);
                                    request.setAttribute("phy", physician);
                                    request.setAttribute("mode", mode);
                                    request.setAttribute("trans", transArr);
                                    request.setAttribute("incomingID",
                                            patientID2);
                                    request.setAttribute("getAlert", "Yes");
                                    ResultSet res = psALL.executeQuery(queryALL);
                                    request.setAttribute("res", res);
                                }
                            }
                        } catch (NullPointerException n) {
                            String DeleteRec =
                                    "delete from patientdb where patientid = ?";

                            PreparedStatement psDel = con.prepareStatement(
                                    DeleteRec);
                            psDel.setInt(1, patientID2);
                            psDel.executeUpdate();

                            ResultSet res = psALL.executeQuery(queryALL);
                            request.setAttribute("res", res);
                            request.setAttribute("incomingID", patientID2);
                            request.setAttribute("trans", "");
                            request.setAttribute("fam", "");
                            request.setAttribute("mid", "");
                            request.setAttribute("first", "");
                            request.setAttribute("sex", "");
                            request.setAttribute("bday", "");
                            request.setAttribute("cnum", "");
                            request.setAttribute("add", "");
                            request.setAttribute("email", "");
                            request.setAttribute("phy", "");
                            request.setAttribute("mode", "");
                            request.setAttribute("getAlert", "No");
                        }
                    }
                }
            }

            if (request.getParameter("createPDF") != null) {
                Patient p = new Patient();
                Record r = new Record();
                Attendant att = new Attendant(con);
                int patientID4 = 1;
                String queryIDD =
                        "SELECT MAX(patientID) as currentID FROM patientDB";
                Statement stmtIDD = con.createStatement();
                ResultSet rsD = stmtIDD.executeQuery(queryIDD);
                if (rsD.next()) {
                    patientID4 += rsD.getInt("currentID");
                }
                request.setAttribute("incomingID", patientID4);
                request.setAttribute("trans", "");
                request.setAttribute("fam", "");
                request.setAttribute("mid", "");
                request.setAttribute("first", "");
                request.setAttribute("sex", "");
                request.setAttribute("bday", "");
                request.setAttribute("cnum", "");
                request.setAttribute("add", "");
                request.setAttribute("email", "");
                request.setAttribute("phy", "");
                request.setAttribute("mode", "");
                request.setAttribute("getAlert", "Yes2");
                ResultSet res = psALL.executeQuery(queryALL);
                request.setAttribute("res", res);

                String familyName = request.getParameter("familyName");
                String firstName = request.getParameter("firstName");
                String middleName = request.getParameter("middleName");
                String sex = request.getParameter("sex");
                String birthday = request.getParameter("birthday");
                String physician = request.getParameter("physician");
                String mode = request.getParameter("modeOfPayment");
                p.setName(familyName, middleName, firstName);
                p.setGender(sex);
                p.setBirthday(birthday);
                r.setModeOfPayment(mode);
                r.setPhysician(physician);
                NewPatientServlet.FooterPageEvent event =
                        new NewPatientServlet.FooterPageEvent();
                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                String getPatientID =
                    "SELECT MAX(patientid) as currentID from patientdb";
            Statement stmtID = con.createStatement();
            ResultSet rs = stmtID.executeQuery(getPatientID);
            String id = "";
            if (rs.next()) {
                id = rs.getString("currentid");
            }
                att.createPDF(p, r, event, d, id);
            }

            if (isAttendant) {
                request.setAttribute("session", "attendantHome");
                request.getRequestDispatcher("newPatient.jsp").include(request,
                        response);
            } else {
                request.setAttribute("session", "adminHome");
                request.getRequestDispatcher("newPatient.jsp").include(request,
                        response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    class FooterPageEvent extends PdfPageEventHelper {

        private PdfTemplate t;
        private Image total;

        public void onOpenDocument(PdfWriter writer, Document document) {
            t = writer.getDirectContent().createTemplate(30, 16);
            try {
                total = Image.getInstance(t);
                total.setRole(PdfName.ARTIFACT);
            } catch (DocumentException de) {
                throw new ExceptionConverter(de);
            }
        }

        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            addFooter(writer);
        }

        private void addFooter(PdfWriter writer) {
            PdfPTable footer = new PdfPTable(3);
            try {
                // set defaults
                //            footer.setWidthPercentage(100);
                footer.setWidths(new int[]{24, 2, 1});
                footer.setTotalWidth(530);
                footer.setLockedWidth(true);
                footer.getDefaultCell().setFixedHeight(40);
                footer.getDefaultCell().setBorder(Rectangle.TOP);
                footer.getDefaultCell().setBorderColor(BaseColor.LIGHT_GRAY);

                // add copyright
                footer.addCell(new Phrase("Date and Time: " +
                        new java.util.Date() + "\n" + getServletContext().
                                getInitParameter("Footer"), new Font(
                        Font.FontFamily.HELVETICA, 10)));
                
                // add current page count
                footer.getDefaultCell().setHorizontalAlignment(
                        Element.ALIGN_RIGHT);
                footer.addCell(new Phrase(String.format("Page %d of", writer.
                        getPageNumber()), new Font(Font.FontFamily.HELVETICA, 8)));

                // add placeholder for total page count
                PdfPCell totalPageCount = new PdfPCell(total);
                totalPageCount.setBorder(Rectangle.TOP);
                totalPageCount.setBorderColor(BaseColor.LIGHT_GRAY);
                footer.addCell(totalPageCount);

                // write page
                PdfContentByte canvas = writer.getDirectContent();
                canvas.beginMarkedContentSequence(PdfName.ARTIFACT);
                footer.writeSelectedRows(0, -1, 34, 50, canvas);
                canvas.endMarkedContentSequence();
            } catch (DocumentException de) {
                throw new ExceptionConverter(de);
            }
        }

        public void onCloseDocument(PdfWriter writer, Document document) {
            int totalLength = String.valueOf(writer.getPageNumber()).length();
            int totalWidth = totalLength * 5;
            ColumnText.showTextAligned(t, Element.ALIGN_RIGHT,
                    new Phrase(String.valueOf(writer.getPageNumber()), new Font(
                            Font.FontFamily.HELVETICA, 8)),
                    totalWidth, 6, 0);
        }
    }

}
