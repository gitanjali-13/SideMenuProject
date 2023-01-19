//
//  ContainerController.swift
//  SideMenuProject
//
//  Created by Admin on 15/01/23.
//


import UIKit

class ContainerController: UIViewController {
  
    //MARK : PROPERTIES
    var menuController : MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    // MARK : INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call method for change background color
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    //-------------  MARK : HANDLER  ---------------------------//
    
    func configureHomeController() {
        
        let homeController = HomeController()
        homeController.delegate = self
        
        //controller is embedded in navigation controller.
        centerController = UINavigationController(rootViewController: homeController)
        
        //ADD SUBVIEW IN VIEW CONTROLLER
        view.addSubview(centerController.view)
        
        addChild(centerController)
        
        //home controller did move to the parent view controller of self which is ContainerController.
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        
        if menuController == nil {
            //Add our menuController
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            menuController.delegate = self
//            print("did add menu controller")
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
               
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)

        } else {
            //hide menu
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
//            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations:  {
                self.centerController.view.frame.origin.x = 0
            }) { _ in
                guard let menuOption = menuOption else{return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    //Acton handler
    func didSelectMenuOption(menuOption: MenuOption) {
        
        switch menuOption {
        case .Profile:
            print("Show profile")
        case .Inbox:
            print("Show Inbox")
        case .Notifications:
            print("Show Notification")
        case .Settings:
            //print("Show settings")
            let controller = SettingController()
            let navController = UINavigationController(rootViewController: controller)
            //controller.userName = "XYZ"
            //navController.modalPresentationStyle = .automatic
            
            present (navController, animated: true,completion: nil)
            
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
        
    }
}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        //configureMenuController()
        if !isExpanded{
            configureMenuController()
        }
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
