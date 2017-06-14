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
    let bookList = BookList()
    
    
    
    
    
    
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
        /*
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
         */
        //BookList.removeAll()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        /*
        DispatchQueue.main.async(execute: {
            self.bookList.setBookList(table: self.tableView)
        })
        print("klsdnfwneorinanldks")
        */
        bookList.setBookList(table: self.tableView)
        
        
        self.tableView.reloadData()
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
        return bookList.booklist.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let book:BookData
        
        if searchController.isActive && searchController.searchBar.text != "" {
            book = filteredBook[indexPath.row]
        } else {
            book = bookList.booklist[indexPath.row]
        }
        
        cell.bookName.text = book.bookName
        cell.bookWriter.text = book.bookWriter
        
        cell.bookName.numberOfLines = 0
        if (book.bookImage != nil && book.bookImage != ""){
            print(book.bookImage)
            
            if (book.bookImageData != nil) {
                cell.bookImage.image = book.bookImageData
            }
            else{
                
                cell.bookImage.image = UIImage(named: "Photo")
                let q = DispatchQueue(label: book.bookImage)
                q.async {
                    let url = URL(string:book.bookImage)
                    let data = try? Data(contentsOf: url!)
                    
                    if let imageData = data {
                        book.bookImageData = UIImage(data: imageData)
                        cell.bookImage.image = book.bookImageData
                        
                        cell.bookImage.image = book.bookImageData
                        
                        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
                        cell.bookImage.addGestureRecognizer(tapRecognizer)
                        cell.bookImage.isUserInteractionEnabled = true
                        
                        
                    }
                }
                return cell
            }
            /*
             let url = URL(string:book.bookImage)
             let data = try? Data(contentsOf: url!)
             
             if let imageData = data {
             cell.bookImage.image = UIImage(data: imageData)
             }*/
            cell.bookImage.image = book.bookImageData
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gestureRecognizer:)))
            cell.bookImage.addGestureRecognizer(tapRecognizer)
            cell.bookImage.isUserInteractionEnabled = true
        }else {
            cell.bookImage.image = UIImage(named: "noImage")
            cell.bookImage.isUserInteractionEnabled = false
        }
        
        return cell
        
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer){
        //tappedImageView is tapped image
        let tappedImageView = gestureRecognizer.view! as! UIImageView
        if (tappedImageView.image != nil) {
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ImageZoomNavigationViewController")
            let tmp = controller as! ImageZoomNavigationViewController
            tmp.tappedImage = tappedImageView.image
            
            self.present(tmp, animated: true, completion: nil)
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBook = bookList.booklist.filter({( book: BookData) -> Bool in
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
                    book = bookList.booklist[indexPath.row]
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
            addView.table = self.tableView
            addView.bookList = self.bookList
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
