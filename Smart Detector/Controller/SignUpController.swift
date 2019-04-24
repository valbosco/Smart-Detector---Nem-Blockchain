//
//  SignUpController.swift
//  CreateFirebaseUser


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
//import GoogleSignIn

class SignUpController: UIViewController {
    //, GIDSignInUIDelegate
    // MARK: - Properties
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "220px-Manipal_University_logo.png")!.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(named: "ic_mail_outline_white_2x.png")!.withRenderingMode(.alwaysOriginal), emailTextField)
    }()
    
    lazy var usernameContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(named: "ic_person_outline_white_2x.png")!.withRenderingMode(.alwaysOriginal), usernameTextField)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "ic_lock_outline_white_2x"), passwordTextField)
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Email", isSecureTextEntry: false)
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Username", isSecureTextEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Password", isSecureTextEntry: true)
    }()
    
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var dividerView: UIView = {
        let dividerView = UIView()
        
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor(white: 1, alpha: 0.88)
        label.font = UIFont.systemFont(ofSize: 14)
        dividerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: dividerView.centerXAnchor).isActive = true
        
        let separator1 = UIView()
        separator1.backgroundColor = UIColor(white: 1, alpha: 0.88)
        dividerView.addSubview(separator1)
        separator1.anchor(top: nil, left: dividerView.leftAnchor, bottom: nil, right: label.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.0)
        separator1.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
        
        let separator2 = UIView()
        separator2.backgroundColor = UIColor(white: 1, alpha: 0.88)
        dividerView.addSubview(separator2)
        separator2.anchor(top: nil, left: label.rightAnchor, bottom: nil, right: dividerView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 1.0)
        separator2.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor).isActive = true
        
        return dividerView
    }()
    
//    let googleLoginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 5
//        button.setTitle("Sign In with Google", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        button.backgroundColor = .googleRed()
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
//        return button
//    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
       // GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    // MARK: - Selectors
    
    @objc func handleGoogleSignIn() {
        print("letter")
      //  GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        createUser(withEmail: email, password: password, username: username)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - API
    
    func createUser(withEmail email: String, password: String, username: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to sign user up with error: ", error.localizedDescription)
                return
            }
            
            guard let uid = result?.uid else { return }
            
            let values = ["email": email, "username": username]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to update database values with error: ", error.localizedDescription)
                    return
                }
                
                //place holder where copied
                self.login(withEmail: email, password: password)
            })
            
        }
        
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlue()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 14, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(usernameContainerView)
        usernameContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 14, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: usernameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 06, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7                                                                                                                                            , paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(dividerView)
        dividerView.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
//        view.addSubview(googleLoginButton)
//        googleLoginButton.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 12, paddingRight: 32, width: 0, height: 50)
        
    }
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
    }
    
    func login(withEmail: String, password: String){
        Auth.auth().signIn(withEmail: withEmail , password: password, completion: {
            (user, error) in
            if error != nil {
                  print("WE have an Error \(error)")
                //self.handleErrors(err: error! as NSError , LoginHandler: loginHandler);
                
            }else {
                
//                guard let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }
//                guard let controller = navController.viewControllers[0] as? ContainerController else { return }
//                controller.configureHomeController()
                let controller = ContainerController()
                
                if Auth.auth().currentUser == nil {
                    DispatchQueue.main.async {
                        
                        let navController = UINavigationController(rootViewController: LoginController())
                        navController.navigationBar.barStyle = .black
                        self.present(navController, animated: true, completion: nil)
                    }
                } else {
                      controller.configureHomeController()
                    
                   
                    //configureHomeController()
                    // configureViewComponents()
                    //loadUserData()
                }
               // controller.configureHomeController()
                //controller.loadUserData()
                
                self.dismiss(animated: false, completion: nil)
                 return
                //perform Segue
               // loginHandler?(nil)
                // print("We are log in")
            }
        } )    }
}
