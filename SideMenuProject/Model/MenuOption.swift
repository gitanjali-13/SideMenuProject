//
//  MenuOption.swift
//  SideMenuProject
//
//  Created by Admin on 17/01/23.
//
import UIKit

enum MenuOption: Int , CustomStringConvertible {
    
    case Profile
    case Inbox
    case Notifications
    case Settings

    var description: String{
        
        switch self {
            
        case .Profile:
            return "Profile"
        case .Inbox:
            return "Inbox"
        case .Notifications:
            return "Notifications"
        case .Settings:
            return "Settings"
            
            
        }
        
    }
    
    var image: UIImage {
            
            switch self {
                
            case .Profile:
                return UIImage(systemName: "person") ?? UIImage()
            case .Inbox:
                return UIImage(systemName: "envelope.badge") ?? UIImage()
            case .Notifications:
                return UIImage(systemName: "bell") ?? UIImage()
            case .Settings:
                return UIImage(systemName: "gearshape") ?? UIImage()
               

                
            }
            
        }
}
