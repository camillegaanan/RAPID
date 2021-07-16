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
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Admin;

/**
 *
 * @author Camille
 */
public class RecordsServlet extends HttpServlet {

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

            Admin ad = new Admin(con);

            String view = request.getParameter("view");
            request.setAttribute("getAlert", null);
            if (view.equals("Download")) {
                String check = request.getParameter("viewCheck");
                ResultSet records = null;
                ResultSet recordsF = null;
                String redirect = "";
                RecordsServlet.FooterPageEvent event =
                        new RecordsServlet.FooterPageEvent();
                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                if (check.equals("all")) {
                    redirect = "all";
                }
                if (check.equals("today")) {
                    redirect = "today";
                }
                ResultSet recordsFF = ad.createViewPDF(check, records, recordsF,
                        event, d);
                request.setAttribute("getAlert", "Yes");
                if (redirect.equals("all")) {
                    if (recordsFF.next()) {
                        request.setAttribute("results", recordsFF);
                        request.getRequestDispatcher("viewALL.jsp").forward(
                                request,
                                response);
                    } else {
                        request.setAttribute("results", recordsFF);
                        request.getRequestDispatcher("viewALL.jsp").forward(
                                request,
                                response);
                    }
                } else {
                    if (recordsFF.next()) {
                        request.setAttribute("results", recordsFF);
                        request.getRequestDispatcher("viewToday.jsp").forward(
                                request,
                                response);
                    } else {
                        request.setAttribute("results", recordsFF);
                        request.getRequestDispatcher("viewToday.jsp").forward(
                                request,
                                response);
                    }
                }
            }

            if (view.equals("View ALL Records")) {
                String delete = null;
                String searchFam = null;
                String searchType = null;
                String searchDate = null;
                ResultSet record = ad.viewAllrecords(searchFam, searchType,
                        searchDate, delete);
                if (record.next()) {
                    request.setAttribute("results", record);
                    request.getRequestDispatcher("viewALL.jsp").forward(request,
                            response);
                } else {
                    request.setAttribute("results", record);
                    request.getRequestDispatcher("viewALL.jsp").forward(request,
                            response);
                }
            }
            if (view.equals("View Today's Records")) {
                String delete = null;
                String searchFam = null;
                String searchType = null;
                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                ResultSet records = ad.viewTodaysRecords(d, searchFam,
                        searchType, delete);

                if (records.next()) {
                    request.setAttribute("results", records);
                    request.getRequestDispatcher("viewToday.jsp").forward(
                            request, response);
                } else {
                    request.setAttribute("results", records);
                    request.getRequestDispatcher("viewToday.jsp").forward(
                            request, response);
                }
            }
            if (view.equals("Search")) {
                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                String choice = request.getParameter("cases");
                String delete = null;
                String searchFam = null;
                String searchType = null;
                String searchDate = null;
                if (choice != null) {
                    if (choice.equals("family")) {
                        searchFam = request.getParameter("fam");
                    } else if (choice.equals("ultra")) {
                        searchType = request.getParameter("case");
                    } else {
                        searchDate = request.getParameter("filterSearch");
                    }
                }

                String searchCheck = request.getParameter("searchCheck");
                ResultSet record = null;
                if (searchCheck.equals("all")) {
                    record = ad.
                            viewAllrecords(searchFam, searchType, searchDate,
                                    delete);
                    if (record.next()) {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewALL.jsp").forward(
                                request,
                                response);
                    } else {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewALL.jsp").forward(
                                request,
                                response);
                    }
                } else {
                    record = ad.viewTodaysRecords(d, searchFam, searchType,
                            delete);
                    System.out.println("date " + d + "fam " + searchFam +
                            "type " + searchType + "delete id " + delete);
                    if (record.next()) {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewToday.jsp").forward(
                                request,
                                response);
                    } else {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewToday.jsp").forward(
                                request,
                                response);
                    }
                }

            }
            if (view.equals("Delete")) {
                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                String delete = request.getParameter("delete");
                String searchFam = null;
                String searchType = null;
                String searchDate = null;

                String deleteCheck = request.getParameter("deleteCheck");
                ResultSet record = null;
                if (deleteCheck.equals("all")) {
                    record = ad.
                            viewAllrecords(searchFam, searchType, searchDate,
                                    delete);
                    if (record.next()) {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewALL.jsp").forward(
                                request,
                                response);
                    } else {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewALL.jsp").forward(
                                request,
                                response);
                    }
                } else {
                    record = ad.viewTodaysRecords(d, searchFam, searchType,
                            delete);
                    if (record.next()) {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewToday.jsp").forward(
                                request,
                                response);
                    } else {
                        request.setAttribute("results", record);
                        request.getRequestDispatcher("viewToday.jsp").forward(
                                request,
                                response);
                    }
                }

            }

        } catch (SQLException ex) {
            Logger.getLogger(RecordsServlet.class.getName()).
                    log(Level.SEVERE, null, ex);
        } catch (DocumentException ex) {
            Logger.getLogger(RecordsServlet.class.getName()).log(Level.SEVERE,
                    null, ex);
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
                footer.setWidths(new int[]{24, 2, 1});
                footer.setTotalWidth(725);
                footer.setLockedWidth(true);
                footer.getDefaultCell().setFixedHeight(40);
                footer.getDefaultCell().setBorder(Rectangle.TOP);
                footer.getDefaultCell().setBorderColor(BaseColor.LIGHT_GRAY);

                footer.addCell(new Phrase("Date and Time: " +
                        new java.util.Date() + "\n" + getServletContext().
                                getInitParameter("Footer"), new Font(
                        Font.FontFamily.HELVETICA, 10)));
                footer.getDefaultCell().setHorizontalAlignment(
                        Element.ALIGN_RIGHT);
                footer.addCell(new Phrase(String.format("Page %d of", writer.
                        getPageNumber()), new Font(Font.FontFamily.HELVETICA, 8)));

                PdfPCell totalPageCount = new PdfPCell(total);
                totalPageCount.setBorder(Rectangle.TOP);
                totalPageCount.setBorderColor(BaseColor.LIGHT_GRAY);
                footer.addCell(totalPageCount);

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
