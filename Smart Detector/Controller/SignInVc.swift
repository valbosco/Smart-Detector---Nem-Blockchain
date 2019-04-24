//
//  SignInVC.swift


import UIKit
import FirebaseAuth
private let RIDER_SEGUE = "RiderVc"

class SignInVC: UIViewController, UITextFieldDelegate{
    
   
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
   // }
    //@IBAction func login(_ sender: UIButton) {
    
        
        if emailTextField.text != nil && passwordTextField.text !=  nil{
            AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: {
                (message) in
                if message != nil {
                    print("WE have an Error \(message)")
                    self.alertTheUser(title: "Problem with Authentication", message: message!)
                    
                }else {
                    //perform Segue
                    TaxiHandler.Instance.rider = self.emailTextField.text!
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    
                    self.performSegue(withIdentifier: RIDER_SEGUE, sender: nil)
                }
            } )
        }else{
            self.alertTheUser(title: "Email and Password is required", message: "Please Enter the Email and Password in the textfield below")
        }
    }
    // func requestTaxi(latitude){}
    
    @IBAction func signUp(_ sender: UIButton) {
    //}
    
    //@IBAction func signUp(_ sender: UIButton) {
        
        performSegue(withIdentifier: RIDER_SEGUE, sender: nil)
        
        if emailTextField.text != nil && passwordTextField.text !=  nil{
            AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, firstName: "", lastName: "", phoneNo: "", loginHandler: {
                (message) in
                if message != nil {
                    //print("WE have an Error \(error)")
                    self.alertTheUser(title: "Problem with creating A New User", message: message!)
                    
                }else {
                    //perform Segue
                    
                    self.performSegue(withIdentifier: RIDER_SEGUE, sender: nil)
                }
            } )
            
        }
        else{
            self.alertTheUser(title: "Email and Password is required", message: "Please Enter the Email and Password in the textfield below")
            
        }
        
    }
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


