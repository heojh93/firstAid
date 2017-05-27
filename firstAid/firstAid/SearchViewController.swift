//
//  SearchViewController.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 27..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: SearchTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.layoutMargins = UIEdgeInsets.zero
        searchTableView.separatorInset = UIEdgeInsets.zero
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        searchTableView.searchDataSource = self
        
        searchTableView.itemList = BookList
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            guard let indexPath = searchTableView.indexPathForSelectedRow else{
                return
            }
            guard let selectedProject = searchTableView.itemList[indexPath.row] as? BookData else {
                return
            }
            
            segue.destination.title = selectedProject.bookName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTableView.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        let Book = searchTableView.itemList[indexPath.row] as! BookData
        
        cell.bookName.text = Book.bookName
        cell.bookWriter.text = Book.bookWriter
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}

extension SearchViewController : SearchTableViewDataSource {
    
    func searchPropertyName() -> String {
        return "bookName"
    }

}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
