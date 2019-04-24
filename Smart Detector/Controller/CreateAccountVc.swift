//
//  CreateAccountVC.swift


import UIKit
import FirebaseAuth

private let WELCOME_SEGUE1 = "welcomeSegue2"
class CreateAccountVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var nationalityTextFiled: UITextField!
    
    //@IBOutlet weak var InsurancetextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    // @IBOutlet weak var emailTextField: UITextField!
   // @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
   // @IBOutlet weak var confirmTextField: UITextField!
    // @IBOutlet weak var passwordTextField: UITextField!
    //@IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.contactTextField.resignFirstResponder()
        
        
       // self.nationalityTextFiled.resignFirstResponder()
       // self.InsurancetextField.resignFirstResponder()
        
       // self.confirmTextField.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUp(_ sender: UIButton) {
    //}
    
   // @IBAction func signUp(_ sender: UIButton) {
    //}
   // @IBAction func signUp(_ sender: UIButton) {
        if emailTextField.text != nil && passwordTextField.text !=  nil{
            AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, phoneNo: contactTextField.text!, loginHandler: {
            //AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!,  loginHandler: {
                (message) in
                if message != nil {
                    //print("WE have an Error \(error)")
                    self.alertTheUser(title: "Problem with creating A New User", message: message!)
                    
                }else {
                    //perform Segue
                    
                    
                    self.performSegue(withIdentifier: WELCOME_SEGUE1, sender: nil)
                }
            } )
            
        }
        else{
            self.alertTheUser(title: "Email and Password is required", message: "Please Enter the Email and Password in the textfield below")
            
        }    }
    
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


