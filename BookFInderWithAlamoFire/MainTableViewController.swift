//
//  MainTableViewController.swift
//  BookFInderWithAlamoFire
//
//  Created by yuri on 2022/11/03.
//

import UIKit
import Alamofire
import Kingfisher
import ProgressHUD

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    
    let apiKey = ""
    
    var books:[Book] = []
    
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

//        search(with: "가을", at: 1)

    }
    
    func search (with query: String?, at page: Int){
        guard let query = query else {return}
        ProgressHUD.show(icon: .bookmark)
        let str = "https://dapi.kakao.com/v3/search/book"
        let params:Parameters = ["query":query, "page":page]
        let headers:HTTPHeaders = ["Authorization": apiKey]
        let alamo = AF.request(str, method: .get, parameters: params, headers: headers)
        alamo.responseDecodable(of: ResultData.self){response in
            guard let root = response.value else { return }
            self.books = root.documents
            print("self.books:",self.books)
            self.tableView.reloadData()
            self.btnNext.isEnabled = !root.meta.is_end
            self.btnPrev.isEnabled = page > 1
            ProgressHUD.dismiss()
        }
        

    }

    @IBAction func actPrev(_ sender: Any) {
        page -= 1
        search(with: searchBar.text, at:page)
    }
    
    @IBAction func actNext(_ sender: Any) {
        page += 1
        search(with: searchBar.text, at: page)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath) as? BookCell else{ fatalError() }
        let book = books[indexPath.row]
    
        cell.thumbnail.kf.setImage(with: URL(string: book.thumbnail))
        cell.title.text = book.title
        cell.author.text = book.authors.joined(separator: ", ") + " 저"
        cell.publisher.text = book.publisher
        cell.price.text = numberFormatter(number: book.sale_price) + " 원"
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(bunttonClicked(sender:)), for: .touchUpInside)
        cell.sw.tag = indexPath.row
        cell.sw.addTarget(self, action: #selector(swValueChanged(sender:)), for: .valueChanged)

        return cell
    }
    @objc func bunttonClicked(sender:UIButton){
        let index = sender.tag
        let book = self.books[index]
        print("Button clicked", book.title)
    }
    @objc func swValueChanged(sender:UISwitch){
        let index = sender.tag
        let book = self.books[index]
        print("Button clicked", book.title)
        //값 변경
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        print("title",book.title)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        if segue.identifier == "detail" {
            let dvc = segue.destination as? DetailViewController
            dvc?.site = self.books[selectedIndexPath.row].url
            
        }
    }
    */
    

}

extension MainTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        search(with: searchBar.text, at: 1)
//        searchBar.resignFirstResponder() //키보드내림
    }
}
