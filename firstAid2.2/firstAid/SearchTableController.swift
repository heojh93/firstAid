//
//  SearchTableController.swift
//  firstAid
//
//  Created by heoju on 2017. 5. 27..
//  Copyright © 2017년 HJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchTableController: UITableViewController {

    // Properties
    var filteredBook = [BookData]()
    var detailViewController: QuestionListController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        
        tableView.tableHeaderView = searchController.searchBar
        
        // 문제 리스트로 갔다가 돌아올 때, 검색 후 화면으로 가기 위해 split view를 사용
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? QuestionListController
        }
        
        // dummy 데이터들
        
        algorithm.addQuestion(question10)
        algorithm.addQuestion(question11)
        algorithm.addQuestion(question12)
        algorithm.addQuestion(question13)
        algorithm.addQuestion(question20)
        algorithm.addQuestion(question21)
        algorithm.addQuestion(question22)
        algorithm.addQuestion(question23)
        
        automata.addQuestion(question110)
        automata.addQuestion(question111)
        
        question10.addPage(questionPage11)
        question10.addPage(questionPage12)
        
        //BookList.removeAll()
        Alamofire.request("http://220.85.167.57:2288/solution/textbook_list/").responseJSON { response in
            
            if let j = response.result.value {
                
                let jsons = JSON(j)
                for (_, json) in jsons {
                    
                    guard let bookName = json["title"].string else {
                        continue
                    }
                    guard let bookWriter = json["author"].string else {
                        continue
                    }
                    guard let bookImage = json["image_url"].string else {
                        continue
                    }
                    guard let bookId = json["id"].int else {
                        continue
                    }
                    BookList.append(BookData(bookId: bookId, bookName: bookName, bookWriter: bookWriter, bookImage: bookImage))
                    self.tableView.reloadData()
                }
                
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBook.count
        }
        return BookList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let book:BookData
        
        if searchController.isActive && searchController.searchBar.text != "" {
            book = filteredBook[indexPath.row]
        } else {
            book = BookList[indexPath.row]
        }
        
        cell.bookName.text = book.bookName
        cell.bookWriter.text = book.bookWriter
        
        cell.bookName.numberOfLines = 0
        
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBook = BookList.filter({( book: BookData) -> Bool in
            return book.bookName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    // 문제 리스트를 위한 table view에 data를 넘겨주기 위함.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 책 선택
        if segue.identifier == "ShowDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                var book: BookData
                if searchController.isActive && searchController.searchBar.text != "" {
                    book = filteredBook[indexPath.row]
                } else {
                    book = BookList[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! QuestionListController
                controller.detailBook = book
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        // 책 추가
        
        if segue.identifier == "addTextbook" {
            let addView = (segue.destination as!UINavigationController).topViewController as! AddingBookViewController
            addView.table = tableView
        }
    }
    // cell의 height을 64로 맞춰줌.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}

extension SearchTableController: UISearchBarDelegate {
    
    // UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension SearchTableController: UISearchResultsUpdating {

    // UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
