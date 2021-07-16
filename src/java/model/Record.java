
package model;

/**
 *
 * @author Camille
 */
public class Record {
    private int recordID;
    private String date;
    private String timestamp;
    private String typeOfUltrasound;
    private int price;
    private String modeOfPayment;
    private int patientID;
    private String physician;
    private String[] transArray;

    public String[] getTransArray() {
        return transArray;
    }

    public void setTransArray(String[] transArray) {
        this.transArray = transArray;
    }
    
    

    public int getRecordID() {
        return recordID;
    }

    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getTypeOfUltrasound() {
        return typeOfUltrasound;
    }

    public void setTypeOfUltrasound(String typeOfUltrasound) {
        this.typeOfUltrasound = typeOfUltrasound;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getModeOfPayment() {
        return modeOfPayment;
    }

    public void setModeOfPayment(String modeOfPayment) {
        this.modeOfPayment = modeOfPayment;
    }

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public String getPhysician() {
        return physician;
    }

    public void setPhysician(String physician) {
        this.physician = physician;
    }
    
}
