

import Foundation
import FirebaseDatabase
class DBProvider{
    private static let _instance = DBProvider();
    static var Instance: DBProvider{
        return _instance
    }
    var dbRef: DatabaseReference{
        return Database.database().reference()
    }
    
    var riderRef: DatabaseReference{
        return dbRef.child(Constants.PATIENT)
    }
    var appointmentsRef: DatabaseReference{
        return dbRef.child(Constants.APPOINTMENTS)
    }
    var switchRef: DatabaseReference{
        return dbRef.child(Constants.LEDSWITCH)
    }
    var requestRef: DatabaseReference{
        return dbRef.child(Constants.ORDER_REQUEST)
    }
    var requestAcceptedRef: DatabaseReference{
        return dbRef.child(Constants.ORDER_ACCEPTED)
    }
    func saveUser(withID: String, email: String, firstName: String, lastName: String,  phoneNo: String){
        let data:Dictionary<String, Any> = [Constants.EMAIL: email,Constants.FIRSTNAME: firstName,Constants.LASTNAME: lastName, Constants.PHONENUMBER: phoneNo, Constants.ISPATIENT: true];
       //riderRef.child(withID).child(Constants.DATA).setValue(data)
       riderRef.child(withID).setValue(data)
        
    }
    func saveAppointment(withID: String, category :String, name: String, phoneNo : String, date :String, time: String, purpose: String){
        let data:Dictionary<String, Any> = [Constants.NAME: name, Constants.PHONENUMBER: phoneNo,Constants.DATE: date, Constants.TIME : time, Constants.PURPOSE : purpose, Constants.CATEGORY : category ];
        appointmentsRef.child(withID).childByAutoId().setValue(data)
        //appointmentsRef.child(withID).setValue(data)
        
    }
    func switchLight(withID: String, name: String, phoneNo: String){
        let data:Dictionary<String, Any> = [Constants.NAME: name,Constants.PHONENUMBER: phoneNo, Constants.isRider: true];
        switchRef.child(withID).child(Constants.STATE).setValue(data)
        
    }
    
}



