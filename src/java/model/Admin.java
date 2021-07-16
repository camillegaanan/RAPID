
package model;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
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
import java.sql.Statement;
import java.text.SimpleDateFormat;

/**
 *
 * @author Camille
 */
public class Admin extends Attendant {

    private String username;

    public Admin(Connection c) {
        super(c);
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public ResultSet viewAllrecords(String searchFam, String searchType,
            String searchDate, String delete) throws SQLException {
        String queryALL =
                "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientid";
        Statement psALL = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet records = psALL.executeQuery(queryALL);
        if (searchDate != null) {
            String encryptedDate = Security.encrypt(searchDate);
            String query =
                    "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where datetoday = ?";
            PreparedStatement ps = con.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, encryptedDate);
            ResultSet recordsDate = ps.executeQuery();
            return recordsDate;
        }
        if (searchFam != null) {

            String encryptedFam = Security.encrypt(searchFam);
            String query =
                    "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where familyname = ?";
            PreparedStatement ps = con.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, encryptedFam);
            ResultSet recordsFam = ps.executeQuery();
            return recordsFam;
        }
        if (searchType != null) {
            String encryptedType = Security.encrypt(searchType);
            String query =
                    "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where typeoftransaction = ?";
            PreparedStatement ps = con.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, encryptedType);
            ResultSet recordsType = ps.executeQuery();
            return recordsType;
        }
        if (delete != null) {

            String DeleteRec =
                    "delete from recorddb where recordid = ?";

            PreparedStatement psDel = con.prepareStatement(DeleteRec);
            psDel.setString(1, delete);
            int count = psDel.executeUpdate();
            if (count > 0) {
                String queryALL2 =
                        "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientid";
                Statement psALL2 = con.createStatement(
                        ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                ResultSet records2 = psALL2.executeQuery(queryALL2);
                return records2;
            }
        }

        return records;
    }

    public ResultSet viewTodaysRecords(model.DateObject d, String searchFam,
            String searchType, String delete) throws SQLException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String strDate = formatter.format(d.getDate());
        String encryptedDate = Security.encrypt(strDate);
        String queryToday =
                "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where datetoday = ?";
        PreparedStatement ps = con.prepareStatement(queryToday,
                ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ps.setString(1, encryptedDate);
        ResultSet records = ps.executeQuery();

        if (searchFam != null) {

            String encryptedFam = Security.encrypt(searchFam);
            String querySF =
                    "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where familyname = ? and datetoday = ?";
            PreparedStatement psSF = con.prepareStatement(querySF,
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            psSF.setString(1, encryptedFam);
            psSF.setString(2, encryptedDate);
            ResultSet recordsFam = psSF.executeQuery();
            return recordsFam;
        }
        if (searchType != null) {
            String encryptedType = Security.encrypt(searchType);
            String queryST =
                    "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID where typeoftransaction = ? and datetoday = ?";
            PreparedStatement psST = con.prepareStatement(queryST,
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            psST.setString(1, encryptedType);
            psST.setString(2, encryptedDate);
            ResultSet recordsType = psST.executeQuery();
            return recordsType;
        }
        if (delete != null) {

            String DeleteRec =
                    "delete from recorddb where recordid = ? and datetoday = ?";

            PreparedStatement psDel = con.prepareStatement(DeleteRec);
            psDel.setString(1, delete);
            psDel.setString(2, encryptedDate);
            int count = psDel.executeUpdate();
            if (count > 0) {
                String queryToday2 =
                        "SELECT * FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientid where datetoday = ?";
                PreparedStatement psToday2 = con.prepareStatement(queryToday2,
                        ResultSet.TYPE_SCROLL_SENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                psToday2.setString(1, encryptedDate);
                ResultSet records2 = psToday2.executeQuery();
                return records2;
            }
        }

        return records;
    }

    public ResultSet createViewPDF(String check, ResultSet records,
            ResultSet recordsF, PdfPageEventHelper event, model.DateObject d)
            throws SQLException, DocumentException {
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);

        String desktopPath = System.getProperty("user.home") +
                "/Desktop/UTZ Records";
        String path = desktopPath.replace("\\", "/");
        String path2 = "";
        File file = new File(System.getProperty("user.home") +
                "\\Desktop\\UTZ Records");
        file.mkdir();

        Paragraph type = new Paragraph();
        PdfPTable pTable = new PdfPTable(12);
        pTable.setWidthPercentage(100);
        pTable.setWidths(new int[]{1, 2, 2, 2, 1, 2, 2, 3, 2, 2, 1, 2});

        if (check.equalsIgnoreCase("all")) {
            path2 = path + "/all_records_" + date + ".pdf";

            type.add("List of transactions: All Records");

            String query =
                    "SELECT PatientDB.patientID AS \"ID\", PatientDB.familyName AS \"Family Name\", PatientDB.firstName AS \"First Name\", PatientDB.middleName AS \"Middle Name\", PatientDB.sex AS \"Sex\", PatientDB.birthday AS \"Birthday\", PatientDB.contactNum AS \"Contact No.\", PatientDB.address AS \"Address\", PatientDB.email AS \"Email\", RecordDB.typeoftransaction AS \"Type of Ultrasound\", RecordDB.price AS \"Price\", RecordDB.datetoday AS \"Date\" FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID";
            PreparedStatement ps = con.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            records = ps.executeQuery();
            int colCount = records.getMetaData().getColumnCount();

            Font tableFont = new Font(Font.FontFamily.HELVETICA, 10);
            Font boldFont = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);
            for (int i = 1; i <= colCount; i++) {
                PdfPCell cell = new PdfPCell();
                Paragraph p = new Paragraph(records.getMetaData().
                        getColumnName(i), boldFont);
                p.setAlignment(Element.ALIGN_CENTER);
                cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                cell.addElement(p);
                pTable.addCell(cell);
                pTable.setHeaderRows(1);
            }
            while (records.next()) {
                for (int i = 1; i <= colCount; i++) {
                    if (i == 1) {
                        PdfPCell cell = new PdfPCell();
                        Paragraph p = new Paragraph(records.getString(records.
                                getMetaData().getColumnName(i)), tableFont);
                        p.setAlignment(Element.ALIGN_CENTER);
                        cell.addElement(p);
                        pTable.addCell(cell);
                    } else {
                        PdfPCell cell = new PdfPCell();
                        Paragraph p = new Paragraph(Security.decrypt(records.
                                getString(records.getMetaData().
                                        getColumnName(i))), tableFont);
                        p.setAlignment(Element.ALIGN_CENTER);
                        cell.addElement(p);
                        pTable.addCell(cell);
                    }
                }
            }

            String delete = null;
            String searchFam = null;
            String searchType = null;
            String searchDate = null;
            recordsF = viewAllrecords(searchFam, searchType,
                    searchDate, delete);

        }
        if (check.equalsIgnoreCase("today")) {
            path2 = path + "/records_for_" + date + ".pdf";

            type.add("List of transactions: " + date);

            String encryptDate = Security.encrypt(date.toString());

            String query =
                    "SELECT PatientDB.patientID AS \"ID\", PatientDB.familyName AS \"Family Name\", PatientDB.firstName AS \"First Name\", PatientDB.middleName AS \"Middle Name\", PatientDB.sex AS \"Sex\", PatientDB.birthday AS \"Birthday\", PatientDB.contactNum AS \"Contact No.\", PatientDB.address AS \"Address\", PatientDB.email AS \"Email\", RecordDB.typeoftransaction AS \"Type of Ultrasound\", RecordDB.price AS \"Price\", RecordDB.datetoday AS \"Date\" FROM PatientDB INNER JOIN RecordDB ON patientDB.patientID=recorddb.patientID WHERE datetoday = ?";
            PreparedStatement ps = con.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, encryptDate);
            records = ps.executeQuery();
            int colCount = records.getMetaData().getColumnCount();

            Font tableFont = new Font(Font.FontFamily.HELVETICA, 10);
            Font boldFont = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);
            for (int i = 1; i <= colCount; i++) {
                PdfPCell cell = new PdfPCell();
                Paragraph p = new Paragraph(records.getMetaData().
                        getColumnName(i), boldFont);
                p.setAlignment(Element.ALIGN_CENTER);
                cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                cell.addElement(p);
                pTable.addCell(cell);
                pTable.setHeaderRows(1);
            }
            while (records.next()) {
                for (int i = 1; i <= colCount; i++) {
                    if (i == 1) {
                        PdfPCell cell = new PdfPCell();
                        Paragraph p = new Paragraph(records.getString(records.
                                getMetaData().getColumnName(i)), tableFont);
                        p.setAlignment(Element.ALIGN_CENTER);
                        cell.addElement(p);
                        pTable.addCell(cell);
                    } else {
                        PdfPCell cell = new PdfPCell();
                        Paragraph p = new Paragraph(Security.decrypt(records.
                                getString(records.getMetaData().
                                        getColumnName(i))), tableFont);
                        p.setAlignment(Element.ALIGN_CENTER);
                        cell.addElement(p);
                        pTable.addCell(cell);
                    }
                }
            }

            String delete = null;
            String searchFam = null;
            String searchType = null;
            recordsF = viewTodaysRecords(d, searchFam,
                    searchType, delete);
        }

        Document doc =
                new Document(PageSize.LETTER.rotate(), 30, 30, 30, 53); 

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

            Paragraph space = new Paragraph(" ");

            doc.add(header1);
            doc.add(header2);
            doc.add(header3);
            doc.add(header4);
            doc.add(space);
            doc.add(type);
            doc.add(space);
            doc.add(pTable);

            doc.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return recordsF;
    }

}
