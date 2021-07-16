
package model;

/**
 *
 * @author Camille
 */
public class Patient {
    private int patientID;
    private String familyName;
    private String firstName;
    private String middleName;
    private String gender;
    private String birthday;
    private String contactNum;
    private String address;
    private String email;

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public int getPatientID() {
        return patientID;
    }
    public void setName(String fam, String mid, String first) {
        familyName = fam;
        middleName = mid;
        firstName = first;
    }
    public String getFamilyName() {
        return familyName;
    }
    
    public String getMiddleName() {
        return middleName;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public String getGender() {
        return gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public String getContactNum() {
        return contactNum;
    }

    public String getAddress() {
        return address;
    }

    public String getEmail() {
        return email;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public void setContactNum(String contactNum) {
        this.contactNum = contactNum;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
}
