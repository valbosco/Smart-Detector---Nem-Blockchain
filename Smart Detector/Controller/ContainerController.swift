//
//  ContainerController.swift
//  Smart Detector
//



import UIKit
import Firebase

class ContainerController: UIViewController {
    //mark: - properties
    var menuController: MenuController!
    var centerController: UIViewController!
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    var isExpanded = false
    
    //mark: - init
    
    //mark: - Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfigureView()
       
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    func configureMenuController(){
        if menuController == nil {
            //adding menu controller
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menu controller ...")
        }
    }
    
    
    func configureHomeController(){
     //   let presenter = MainViewPresenter()
        let flowLayout = UICollectionViewFlowLayout()
        
        //let myCollectionVC
      // let homeController = HomeController()
        let homeController = MyCollectionViewController(collectionViewLayout: flowLayout)
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
      
        
    }
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption{
        case .PlaceOrders:
    
            //let controller = OrdersViewController()
           //  present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
            //print("show Profile")
            let flowLayout = UICollectionViewFlowLayout()
            
            let myCollectionVC = MedicineViewController(collectionViewLayout: flowLayout)
        let navController = UINavigationController(rootViewController: myCollectionVC)
    //navigationController?.pushViewController(navController, animated: true)
           present(navController, animated: true, completion: nil)
        case .Inbox:
            print("show Inbox")
        case .Notifications:
            print("show Notifications")
        case .Settings:
            let controller = SettingsController()
            controller.username = "Batman"
            present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?){
        if shouldExpand {
            //show the menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        }else{
            //hide the menu
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else {return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
    }
    func animateStatusBar(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
           self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    // MARK: - API
    
    func authenticateUserAndConfigureView() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
               
                let navController = UINavigationController(rootViewController: LoginController())
                navController.navigationBar.barStyle = .black
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            configureHomeController()
            // configureViewComponents()
            //loadUserData()
        }
    }
   
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard let username = snapshot.value as? String else { return }
            self.welcomeLabel.text = "Welcome, \(username)"
            
            UIView.animate(withDuration: 0.5, animations: {
                self.welcomeLabel.alpha = 1
            })
        }
    }


    
    
    
}
extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
    
    
    
    
}
