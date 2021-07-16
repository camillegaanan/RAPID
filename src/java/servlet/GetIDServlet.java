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
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Attendant;
import model.Patient;
import model.Record;

/**
 *
 * @author Camille
 */
public class GetIDServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            boolean isAttendant = (session.getAttribute("password") != null); //true if attendant, false if admin
            boolean isUpdate = false;

            if (request.getParameter("enterIDHome") != null) { //from admin or attendant Home
                if (isAttendant) {
                    request.setAttribute("session", "attendantHome");
                    request.getRequestDispatcher("enterId.jsp").include(request,
                            response);
                } else {
                    request.setAttribute("session", "adminHome");
                    request.getRequestDispatcher("enterId.jsp").include(request,
                            response);
                }
            }

            if (request.getParameter("enterID") != null) { //from enterid.jsp
                Attendant att = new Attendant(con);
                String id = request.getParameter("id");
                ResultSet rs = att.enterPatientID(id);
                if (rs.next()) {
                    request.setAttribute("results", rs);
                    request.setAttribute("trans", "");
                    request.setAttribute("phy", "");
                    request.setAttribute("mode", "");
                    request.setAttribute("name", "updateRec");
                    request.setAttribute("value", "Update");
                    request.setAttribute("getAlert", null);
                    isUpdate = true;
                } else {
                    //no existing records for patientid

                    request.setAttribute("results", rs);
                    request.setAttribute("trans", "");
                    request.setAttribute("phy", "");
                    request.setAttribute("mode", "");
                    request.setAttribute("name", "updateRec");
                    request.setAttribute("value", "Update");
                    request.setAttribute("getAlert", "No");
                    if (isAttendant) {
                        request.setAttribute("session", "attendantHome");
                        request.getRequestDispatcher("enterId.jsp").include(
                                request,
                                response);

                    } else {
                        request.setAttribute("session", "adminHome");
                        request.getRequestDispatcher("enterId.jsp").include(
                                request,
                                response);
                    }
                }
            }

            if (request.getParameter("updateRec") != null) { //will only attempt to update if from updateRecords jsp
                isUpdate = true;

                Attendant att = new Attendant(con);
                Patient p = new Patient();
                int getPatientID = Integer.parseInt(request.getParameter("id"));
                p.setPatientID(getPatientID);

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
                att.updatePatient(p);
                Record r = new Record();

                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");
                String dateToday = date.format(d.getDate());
                String timeToday = time.format(d.getDate());
                String physician = request.getParameter("physician");
                String mode = request.getParameter("modeOfPayment");
                String transaction[] = request.getParameterValues("transaction");
                String transArr = "";
                r.setPatientID(getPatientID);
                r.setDate(dateToday);
                r.setTimestamp(timeToday);
                r.setPhysician(physician);
                r.setModeOfPayment(mode);
                r.setTransArray(transaction);

                try {
                    for (int i = 0; i < transaction.length; i++) {
                        int count2 = att.addRecord(r, i, transArr);
                        String[] splited = r.getTransArray()[i].
                                split("\\s+");
                        String trans = splited[0];
                        transArr += trans + " ";
                        if (count2 > 0) {
                            String id = request.getParameter("id");
                            String query =
                                    "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where recorddb.patientID = ?";

                            PreparedStatement ps = con.prepareStatement(query,
                                    ResultSet.TYPE_SCROLL_SENSITIVE,
                                    ResultSet.CONCUR_READ_ONLY);
                            ps.setString(1, id);
                            ResultSet rs = ps.executeQuery();
                            request.setAttribute("phy", physician);
                            request.setAttribute("mode", mode);
                            request.setAttribute("trans", transArr);
                            request.setAttribute("results", rs);
                            request.setAttribute("name", "createPDF");
                            request.setAttribute("value", "Create PDF");
                            request.setAttribute("getAlert", "Yes");
                        }
                    }
                } catch (NullPointerException n) {
                    String id = request.getParameter("id");
                    ResultSet rs = att.enterPatientID(id);
                    request.setAttribute("results", rs);
                    request.setAttribute("trans", "");
                    request.setAttribute("phy", "");
                    request.setAttribute("mode", "");
                    request.setAttribute("name", "updateRec");
                    request.setAttribute("value", "Update");
                    request.setAttribute("getAlert", "No");
                }
            }

            if (request.getParameter("createPDF") != null) {
                isUpdate = true;
                
                 Patient p = new Patient();
                Record r = new Record();
                Attendant att = new Attendant(con);
                
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
                
                String id = request.getParameter("id");
                String query =
                        "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where recorddb.patientID = ?";

                PreparedStatement ps = con.prepareStatement(query,
                        ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();
                request.setAttribute("phy", "");
                request.setAttribute("mode", "");
                request.setAttribute("trans", "");
                request.setAttribute("results", rs);
                request.setAttribute("name", "updateRec");
                request.setAttribute("value", "Update");
                request.setAttribute("getAlert", "Yes2");
                FooterPageEvent event = new FooterPageEvent();
                model.DateObject d = (model.DateObject) request.getServletContext().getAttribute("date");
                att.createPDF(p, r, event, d, id);
            }
            if (isAttendant && isUpdate) {
                request.setAttribute("session", "attendantHome");
                request.getRequestDispatcher("updateRecords.jsp").
                        include(
                                request, response);
            }
            if (!isAttendant && isUpdate) {
                request.setAttribute("session", "adminHome");
                request.getRequestDispatcher("updateRecords.jsp").
                        include(
                                request, response);
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
    
        private void addFooter(PdfWriter writer){
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
                footer.addCell(new Phrase("Date and Time: " + new Date() + "\n" + getServletContext().getInitParameter("Footer"), new Font(Font.FontFamily.HELVETICA, 10) ));
    //            footer.addCell(new Phrase("Date and Time: " + new java.util.Date() + "\n" + "copyright", new Font(Font.FontFamily.HELVETICA, 10) ));

                // add current page count
                footer.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
                footer.addCell(new Phrase(String.format("Page %d of", writer.getPageNumber()), new Font(Font.FontFamily.HELVETICA, 8)));

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
            } catch(DocumentException de) {
                throw new ExceptionConverter(de);
            }
        }
    
        public void onCloseDocument(PdfWriter writer, Document document) {
            int totalLength = String.valueOf(writer.getPageNumber()).length();
            int totalWidth = totalLength * 5;
            ColumnText.showTextAligned(t, Element.ALIGN_RIGHT,
                    new Phrase(String.valueOf(writer.getPageNumber()), new Font(Font.FontFamily.HELVETICA, 8)),
                    totalWidth, 6, 0);
        }
    }

}
