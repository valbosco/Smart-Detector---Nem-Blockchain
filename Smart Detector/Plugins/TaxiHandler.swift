
import Foundation
import FirebaseDatabase
class TaxiHandler{
    private static let _instance = TaxiHandler()
    //  let defaults = UserDefaults.standard
    var rider = ""
    var driver = ""
    var rider_id = ""
    static var Instance: TaxiHandler{
        return _instance;
    }
    
    func requestOrder(latitude:Double,longitude: Double, Order: String){
        // var rider = defaults.string(forKey: "phoneID")!
        let data: Dictionary<String, Any> = [Constants.NAME: rider, Constants.LATITUDE: latitude, Constants.LONGITUDE: longitude,Constants.ORDER: Order];
        DBProvider.Instance.requestRef.childByAutoId().setValue(data);
    }
}



