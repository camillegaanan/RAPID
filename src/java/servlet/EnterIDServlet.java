package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Security;

/**
 *
 * @author Camille
 */
public class EnterIDServlet extends HttpServlet {

    Connection con;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName"));
            String username = getServletContext().getInitParameter("dbUserName");
            String password = getServletContext().getInitParameter("dbPassword");
            String url = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(url, username, password);

        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - "
                    + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - "
                    + nfe.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            boolean isAttendant = (session.getAttribute("password") != null);

            if (request.getParameter("enterID") != null) {
                String id = request.getParameter("id");
                String query
                        = "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where recorddb.patientID = ?";

                PreparedStatement ps = con.prepareStatement(query,
                        ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("results", rs);
                }
            }

            if (request.getParameter("updateRec") != null) { 

                int getPatientID = Integer.parseInt(request.getParameter("id"));

                String familyName = request.getParameter("familyName");
                String firstName = request.getParameter("firstName");
                String middleName = request.getParameter("middleName");
                String sex = request.getParameter("sex");
                String birthday = request.getParameter("birthday");
                String contactNum = request.getParameter("contactNum");
                String address = request.getParameter("address");
                String email = request.getParameter("email");

                model.DateObject d = (model.DateObject) request.
                        getServletContext().getAttribute("date");
                SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");
                String dateToday = date.format(d.getDate());
                String timeToday = time.format(d.getDate());
                String physician = request.getParameter("physician");
                String mode = request.getParameter("modeOfPayment");

                String encryptFamilyName = Security.encrypt(familyName);
                String encryptFirstName = Security.encrypt(firstName);
                String encryptMiddleName = Security.encrypt(middleName);
                String encryptSex = Security.encrypt(sex);
                String encryptBirthday = Security.encrypt(birthday);
                String encryptContactNum = Security.encrypt(contactNum);
                String encryptAddress = Security.encrypt(address);
                String encryptEmail = Security.encrypt(email);

                String encryptedDate = Security.encrypt(dateToday);
                String encryptedTime = Security.encrypt(timeToday);
                String encryptedPhy = Security.encrypt(physician);
                String encryptedMode = Security.encrypt(mode);

                String updateRec
                        = "update patientdb set familyname = ?, firstname = ?, middlename = ?, sex = ?, birthday = ?, contactnum = ?, address = ?, email = ? where patientid = ?";

                PreparedStatement psUpRec = con.prepareStatement(updateRec);

                psUpRec.setString(1, encryptFamilyName);
                psUpRec.setString(2, encryptFirstName);
                psUpRec.setString(3, encryptMiddleName);
                psUpRec.setString(4, encryptSex);
                psUpRec.setString(5, encryptBirthday);
                psUpRec.setString(6, encryptContactNum);
                psUpRec.setString(7, encryptAddress);
                psUpRec.setString(8, encryptEmail);
                psUpRec.setInt(9, getPatientID);
                int count = psUpRec.executeUpdate();
                System.out.println("execute update" + count);
                String transaction[] = request.getParameterValues("transaction");
                if (transaction[0] != null) {
                    for (int i = 0; i < transaction.length; i++) {
                        String[] splited = transaction[i].split("\\s+");
                        String trans = splited[0];
                        String price = splited[1];
                        String encryptedTrans = Security.encrypt(trans);
                        String encryptedPrice = Security.encrypt(price);
                        String addRecord
                                = "insert into recorddb (patientID, datetoday, timetoday, physician, typeoftransaction, modeofpayment, price) "
                                + "values (?,?,?,?,?,?,?)";

                        PreparedStatement psAddRec = con.prepareStatement(addRecord);

                        psAddRec.setInt(1, getPatientID);
                        psAddRec.setString(2, encryptedDate);
                        psAddRec.setString(3, encryptedTime);
                        psAddRec.setString(4, encryptedPhy);
                        psAddRec.setString(5, encryptedTrans);
                        psAddRec.setString(6, encryptedMode);
                        psAddRec.setString(7, encryptedPrice);
                        int count2 = psAddRec.executeUpdate();
                        System.out.println("update new trans" + count2);
                    }
                } else {
                    System.out.print("error");
                }

            }

            if (isAttendant) {
                request.setAttribute("session", "attendantHome");
                request.getRequestDispatcher("enterId.jsp").include(request, response);
            } else {
                request.setAttribute("session", "adminHome");
                request.getRequestDispatcher("enterId.jsp").include(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(EnterIDServlet.class.getName()).log(Level.SEVERE, null, ex);
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

}
