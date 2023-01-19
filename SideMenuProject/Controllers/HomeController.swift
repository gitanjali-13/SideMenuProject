//
//  HomeController.swift
//  SideMenuProject
//
//  Created by Admin on 15/01/23.
//


import UIKit

class HomeController: UIViewController  {
   
    //MARK : PROPERTIES
    //create delegate for homecontroller
    var isSearching = false
    var delegate: HomeControllerDelegate?
    
    var noteItem: [Note] = []
    var filterNote: [Note] = []
    
    var tableview = UITableView()
    
    // MARK : INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchController()
        configureNavigationBar()
    }
    
    //MARK : HANDLER
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)

    }
    
    func configureNavigationBar() {
        
//        navigationController?.navigationBar.barTintColor = .darkGray
//        navigationController?.navigationBar.barStyle = .black
        
       // navigationItem.title = "Side Menu"
        //Add image for menu.
//        navigationItem.leftBarButtonItem  = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: resizeImage(image: UIImage(named: "menuImage")! , newWidth: 30), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

       let scale = newWidth / image.size.width
       let newHeight = image.size.height * scale
       UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

        return newImage
   }
    
    
    func configureSearchController() {
        
        
        let searchController = UISearchController()
                searchController.searchResultsUpdater = self
                searchController.searchBar.delegate = self
                searchController.searchBar.placeholder = "Search for a user name"
                searchController.obscuresBackgroundDuringPresentation = false
                navigationItem.searchController = searchController
        //searchController?.searchBar.barTintColor = .blue
        searchController.searchBar.barTintColor = .darkGray
        
    }
    
}
extension HomeController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("search")
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {
            filterNote.removeAll()
//            updateData(on: noteItem)
            isSearching = false
            return }
        
        print("After guard")
        isSearching = true
        filterNote = noteItem.filter{
            $0.title!.lowercased().contains(filter.lowercased())}
    }
    
    
}
