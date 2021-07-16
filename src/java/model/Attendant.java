/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BarcodeQRCode;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Calendar;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Camille
 */
public class Attendant extends Role {

    private String password = "";
    Connection con;
    private int error;
    private HttpSession session;

    public Attendant(HttpSession session) {
        this.session = session;
    }

    public Attendant(Connection c) {
        con = c;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setError(int error) {
        this.error = error;
    }

    public int getError() {
        return error;
    }

    public boolean verifyLogin(String username, String password) throws
            SQLException {
        String r = getRole();
        if (r.equalsIgnoreCase("admin")) {
            String query =
                    "select * from adminDB where username = ? and password = ?";
            String query2 = "select * from adminDB where username = ?";

            PreparedStatement ps = con.prepareStatement(query);
            PreparedStatement ps2 = con.prepareStatement(query2);

            ps.setString(1, username);
            String encryptedPass = Security.encrypt(password);
            ps.setString(2, encryptedPass);
            ps.setString(2, password);

            ps2.setString(1, username);
            try (ResultSet records2 = ps2.executeQuery()) {
                if (records2.next()) {
                    String passw = records2.getString(2);
                    String retrievedPass = Security.decrypt(passw);
                    setError(3);
                    return password.equals(retrievedPass);
                } else {
                    return false;
                }
            }
        } else if (r.equalsIgnoreCase("attendant")) {
            String query = "select * from attendantDB where password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            String encryptedPass = Security.encrypt(password);
            ps.setString(1, encryptedPass);
            try (ResultSet records = ps.executeQuery()) {
                if (records.next()) {
                    String passw = records.getString(1);
                    String retrievedPass = Security.decrypt(passw);
                    return password.equals(retrievedPass);
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    public int addPatient(Patient p) throws SQLException {
        String encryptFamilyName = Security.encrypt(p.getFamilyName());
        String encryptFirstName = Security.encrypt(p.getFirstName());
        String encryptMiddleName = Security.encrypt(p.getMiddleName());
        String encryptSex = Security.encrypt(p.getGender());
        String encryptBirthday = Security.encrypt(p.getBirthday());
        String encryptContactNum = Security.encrypt(p.getContactNum());
        String encryptAddress = Security.encrypt(p.getAddress());
        String encryptEmail = Security.encrypt(p.getEmail());

        String queryInsert =
                "insert into patientDB (familyName, firstName, middleName, sex, birthday, contactNum, address, email) " +
                "values (?,?,?,?,?,?,?,?)";

        PreparedStatement psInsert = con.prepareStatement(queryInsert);

        psInsert.setString(1, encryptFamilyName);
        psInsert.setString(2, encryptFirstName);
        psInsert.setString(3, encryptMiddleName);
        psInsert.setString(4, encryptSex);
        psInsert.setString(5, encryptBirthday);
        psInsert.setString(6, encryptContactNum);
        psInsert.setString(7, encryptAddress);
        psInsert.setString(8, encryptEmail);

        return psInsert.executeUpdate();
    }

    public int addRecord(Record r, int i, String transArr) throws SQLException {
        String encryptedDate = Security.encrypt(r.getDate());
        String encryptedTime = Security.encrypt(r.getTimestamp());
        String encryptedPhy = Security.encrypt(r.getPhysician());
        String encryptedMode = Security.encrypt(r.getModeOfPayment());
        String[] splited = r.getTransArray()[i].split("\\s+");
        String trans = splited[0];
        transArr += trans + " ";
        String price = splited[1];
        String encryptedTrans = Security.encrypt(trans);
        String encryptedPrice = Security.encrypt(price);
        String addRecord =
                "insert into recorddb (patientID, datetoday, timetoday, physician, typeoftransaction, modeofpayment, price) " +
                "values (?,?,?,?,?,?,?)";

        PreparedStatement psAddRec = con.prepareStatement(
                addRecord);

        psAddRec.setInt(1, r.getPatientID());
        psAddRec.setString(2, encryptedDate);
        psAddRec.setString(3, encryptedTime);
        psAddRec.setString(4, encryptedPhy);
        psAddRec.setString(5, encryptedTrans);
        psAddRec.setString(6, encryptedMode);
        psAddRec.setString(7, encryptedPrice);

        return psAddRec.executeUpdate();
    }

    public void updatePatient(Patient p) throws SQLException {
        String encryptFamilyName = Security.encrypt(p.getFamilyName());
        String encryptFirstName = Security.encrypt(p.getFirstName());
        String encryptMiddleName = Security.encrypt(p.getMiddleName());
        String encryptSex = Security.encrypt(p.getGender());
        String encryptBirthday = Security.encrypt(p.getBirthday());
        String encryptContactNum = Security.encrypt(p.getContactNum());
        String encryptAddress = Security.encrypt(p.getAddress());
        String encryptEmail = Security.encrypt(p.getEmail());

        String updateRec =
                "update patientdb set familyname = ?, firstname = ?, middlename = ?, sex = ?, birthday = ?, contactnum = ?, address = ?, email = ? where patientid = ?";

        PreparedStatement psUpRec = con.prepareStatement(updateRec);

        psUpRec.setString(1, encryptFamilyName);
        psUpRec.setString(2, encryptFirstName);
        psUpRec.setString(3, encryptMiddleName);
        psUpRec.setString(4, encryptSex);
        psUpRec.setString(5, encryptBirthday);
        psUpRec.setString(6, encryptContactNum);
        psUpRec.setString(7, encryptAddress);
        psUpRec.setString(8, encryptEmail);
        psUpRec.setInt(9, p.getPatientID());
        psUpRec.executeUpdate();
    }

    public ResultSet enterPatientID(String id) throws SQLException {
        String query = "SELECT * FROM PatientDB where patientID = ?";

        PreparedStatement ps = con.prepareStatement(query,
                ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        return rs;
    }

    public void createPDF(Patient p, Record r, PdfPageEventHelper event, model.DateObject d, String id) {
        long millis = System.currentTimeMillis();
        java.sql.Date fileDate = new java.sql.Date(millis);

        String desktopPath = System.getProperty("user.home") +
                "/Desktop/UTZ Charge Slip"; //OG
//                String desktopPath = "D:/Media/Desktop/UTZ Charge Slip"; //for testing
        String path = desktopPath.replace("\\", "/");
        String path2 = path + "/" + p.getFamilyName() + "_" + p.getFirstName() +
                "_" + fileDate +
                ".pdf";

        File file = new File(System.getProperty("user.home") +
                "\\Desktop\\UTZ Charge Slip"); //comment this back after
//                File file = new File("D:\\Media\\Desktop\\UTZ Charge Slip"); //for testing only
        file.mkdir();

        Document doc = new Document(PageSize.LETTER, 50, 50, 50, 50);

        try {
            PdfWriter writer = PdfWriter.getInstance(doc,
                    new FileOutputStream(path2));
            writer.setPageEvent(event);

            doc.open();

            Paragraph header1 = new Paragraph(
                    "ACCUCARE DIAGNOSTIC CENTER");
            header1.setAlignment(Element.ALIGN_CENTER);

            Paragraph header2 = new Paragraph(
                    "The Cabanas Km 44/45 N3A Mc Arthur Hwy. Malolos City, Malolos Bulacan");
            header2.setAlignment(Element.ALIGN_CENTER);

            Paragraph header3 = new Paragraph(
                    "Contact No.: (044) 760-6465 ; 09324102357");
            header3.setAlignment(Element.ALIGN_CENTER);

            Paragraph header4 = new Paragraph(
                    "www.facebook.com/Accucare-Diagnostic-Center-246513915395497");
            header4.setAlignment(Element.ALIGN_CENTER);

            BarcodeQRCode my_code = new BarcodeQRCode(id, 100,
                    100, null);
            Image qr_image = my_code.getImage();
            qr_image.setAbsolutePosition(510, 690);

            Paragraph space = new Paragraph(" ");

            //Place paragraphs into a table
            PdfPTable infoPTable = new PdfPTable(2);
            infoPTable.setWidthPercentage(100);
            infoPTable.getDefaultCell().setBorder(0);
            infoPTable.getDefaultCell().setFixedHeight(20);

            infoPTable.addCell("CHARGE SLIP -- RADIOLOGY");
            infoPTable.addCell(" ");
            infoPTable.addCell("Patient ID: " + id);

            if (p.getGender().equals("m")) {
                infoPTable.addCell("Sex: MALE");
            } else if (p.getGender().equals("f")) {
                infoPTable.addCell("Sex: FEMALE");
            }

            infoPTable.addCell(
                    "Name: " + p.getFamilyName().toUpperCase() + ", " + p.
                    getFirstName().toUpperCase() + " " + p.getMiddleName().
                            toUpperCase());
            infoPTable.addCell("Requesting Physician: " + r.getPhysician());
            infoPTable.addCell("Birthday: " + p.getBirthday());

            SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");
            String dateToday = date.format(d.getDate());
            String timeToday = time.format(d.getDate());
            infoPTable.addCell("Transaction Date & Time: " + dateToday + " " +
                    timeToday);

            //to give the AGE
            java.util.Date birthdate = date.parse(p.getBirthday());
            Calendar c = Calendar.getInstance();
            c.setTime(birthdate);
            int year = c.get(Calendar.YEAR);
            int month = c.get(Calendar.MONTH) + 1;
            int day = c.get(Calendar.DATE);
            LocalDate l1 = LocalDate.of(year, month, day);
            LocalDate now1 = LocalDate.now();
            Period diff1 = Period.between(l1, now1);
            infoPTable.addCell("Age: " + diff1.getYears());

            infoPTable.addCell("Mode of Payment: " + r.getModeOfPayment().
                    toUpperCase());

            //to select columns that will be printed
            String query =
                    "SELECT typeoftransaction AS \"Type of Ultrasound\", price AS \"Price\" FROM Recorddb INNER JOIN PatientDB ON patientDB.patientID=recorddb.patientID WHERE recorddb.patientid = ? AND datetoday = ?"; // do you think 2x pupunta yung patient sa isang araw na hiwalay transaction?
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, id);
            ps.setString(2, Security.encrypt(dateToday));
            ResultSet records = ps.executeQuery();
            int colCount = records.getMetaData().getColumnCount();
            Integer sum = 0;

            PdfPTable pTable = new PdfPTable(2);
            Font boldFont = new Font(Font.FontFamily.HELVETICA, 12,
                    Font.BOLD);
            //Table Header
            for (int i = 1; i <= colCount; i++) {
                PdfPCell cell = new PdfPCell();
                Paragraph p1 = new Paragraph(records.getMetaData().
                        getColumnName(i), boldFont);
                p1.setSpacingAfter(10);
                p1.setAlignment(Element.ALIGN_CENTER);
                cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                cell.addElement(p1);
                pTable.addCell(cell);
            }
            while (records.next()) {
                for (int i = 1; i <= colCount; i++) {
//                    PdfPCell cell = new PdfPCell();
//                    Paragraph p1 = new Paragraph(Security.decrypt(records.getString(
//                            records.getMetaData().getColumnName(i))));
//                    p1.setSpacingAfter(10);
                    
//                    pTable.addCell(Security.decrypt(records.getString(
//                            records.getMetaData().getColumnName(i))));
//                    if ((i + 1) <= colCount) {
//                        p1.setAlignment(Element.ALIGN_RIGHT);
//                        sum += Integer.parseInt(Security.decrypt(
//                                records.getString(records.getMetaData().
//                                        getColumnName(i + 1))));
//                    }
                    
//                    cell.addElement(p1);
//                    pTable.addCell(cell);
                    
                    if (i == 1) {
                        PdfPCell cell = new PdfPCell();
                        Paragraph p1 = new Paragraph(Security.decrypt(records.getString(
                            records.getMetaData().getColumnName(i))));
//                        p1.setAlignment(Element.ALIGN_CENTER);
                        p1.setSpacingAfter(10);
                        cell.addElement(p1);
                        pTable.addCell(cell);
                    } else {
                        PdfPCell cell = new PdfPCell();
                        Paragraph p1 = new Paragraph("PhP " + Security.decrypt(records.getString(
                            records.getMetaData().getColumnName(i))));
                        p1.setAlignment(Element.ALIGN_RIGHT);
                        p1.setSpacingAfter(10);
                        cell.addElement(p1);
                        pTable.addCell(cell);
                        sum += Integer.parseInt(Security.decrypt(
                                records.getString(records.getMetaData().
                                        getColumnName(i))));
                    }
                }
            }

            PdfPCell cellTotal = new PdfPCell();
            Paragraph pTotal = new Paragraph("Total", boldFont);
            pTotal.setSpacingAfter(10);
            pTotal.setAlignment(Element.ALIGN_RIGHT);
            cellTotal.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cellTotal.addElement(pTotal);

            PdfPCell cellSum = new PdfPCell();
            Paragraph pSum = new Paragraph("PhP " + sum.toString(), boldFont);
            pSum.setSpacingAfter(10);
            pSum.setAlignment(Element.ALIGN_RIGHT);
            cellSum.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cellSum.addElement(pSum);

            pTable.addCell(cellTotal);
            pTable.addCell(cellSum);

            doc.add(header1);
            doc.add(header2);
            doc.add(header3);
            doc.add(header4);
            doc.add(space);
            doc.add(space);
            doc.add(infoPTable);
            doc.add(space);
            doc.add(space);
            doc.add(pTable);

            doc.add(qr_image);
            doc.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void logout() {
        session.removeAttribute("username");
        session.removeAttribute("password");
        session.removeAttribute("getAlert");
        session.invalidate();
    }
}
