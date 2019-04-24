import Foundation
import FirebaseAuth
typealias LoginHandler = ( _ msg: String?) -> Void
class AuthProvider{
    private static let _instance = AuthProvider();
    struct LoginErrorCode{
        static let INVALID_EMAIL = "Invalid Email Address please provide Real Email Address"
        static let WRONG_PASSWORD = "Wrong password please Enter the correct password"
        static let PROBLEM_CONNECTING = "Problem connecting to database"
        static let USER_NOT_FOUND = "User not found, Please Register"
        static let WEAK_PASSWORD = "Password should be At least 6 Characters Long"
        
    }
    
    
    static var Instance: AuthProvider{
        return _instance
    }
    func login(withEmail: String, password: String, loginHandler: LoginHandler?){
        Auth.auth().signIn(withEmail: withEmail , password: password, completion: {
            (user, error) in
            if error != nil {
                //  print("WE have an Error \(error)")
                self.handleErrors(err: error! as NSError , LoginHandler: loginHandler);
                
            }else {
                //perform Segue
                loginHandler?(nil)
                // print("We are log in")
            }
        } )    }
    func signUp(withEmail: String, password: String, firstName :String, lastName: String, phoneNo : String ,loginHandler: LoginHandler?){
        
        Auth.auth().createUser(withEmail: withEmail , password: password, completion: {
            (user, error) in
            if error != nil {
                //print("WE have an Error \(error)")
                self.handleErrors(err: error! as NSError , LoginHandler: loginHandler);
                
            }else {
                if user?.uid != nil {
                    DBProvider.Instance.saveUser(withID: user!.uid, email: withEmail, firstName: firstName,  lastName: lastName,  phoneNo: phoneNo)
                    //store the user in the database
                    //DBProvider.Instance.saveUser(withID: user!.uid, name: withEmail, phoneNo: password)
                    //Login the User
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler)
                }
                
            }
        } )
        
    }
    
    func logOut() -> Bool{
        if Auth.auth().currentUser != nil {
            do{
                try Auth.auth().signOut();
                return true
            }catch{
                return false
            }
        }
        return true
    }
    private func handleErrors(err: NSError, LoginHandler: LoginHandler?){
        
        if let errCode = AuthErrorCode(rawValue: err.code) {
            switch(errCode){
            case .wrongPassword:
                LoginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break;
            case .invalidEmail:
                LoginHandler?(LoginErrorCode.INVALID_EMAIL)
                break;
            case .userNotFound:
                LoginHandler?(LoginErrorCode.USER_NOT_FOUND)
                break;
            case .emailAlreadyInUse:
                LoginHandler?(LoginErrorCode.INVALID_EMAIL)
                break;
            case .weakPassword:
                LoginHandler?(LoginErrorCode.WEAK_PASSWORD)
                break;
            default:
                break;
                
            }}
    }
    
    
    
    
}


