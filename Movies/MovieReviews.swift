//
//  MovieReviews.swift
//  Movies
//
//  Created by Sara Alaa on 3/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MovieReviews: UITableViewController {
    var movieId = ""
    var reviewAuthor = [String]()
    var reviewContent = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 250
        self.navigationItem.title = "Movie Reviews"
        self.tableView.backgroundColor = UIColor.init(red: 31/255, green: 33/255, blue:36/255 , alpha: 1.0)
fetchReviews()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
func showAlert()
{
    let alertController = UIAlertController(title: "Reviews", message: "There are no Reviews For This Movie", preferredStyle: .alert)
            
    let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
//        self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(action1)
    self.present(alertController, animated: true, completion: nil)


    }
        
            func fetchReviews() {
       Alamofire.request("http://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=4b31f0efe12a16c14046bd6788aa555b", method: .get).responseJSON {
                    (myresponse) in
                    switch myresponse.result
                    {
                        
                    case .success:
                        print(myresponse.result)
                        let myresult = try? JSON(data: myresponse.data!)
    //                    print(myresult!["results"])
                        let resultArray = myresult!["results"]
                        if(resultArray.count<=0)
                        {
                            self.showAlert();
                        }
                        for i in resultArray.arrayValue
                        {
                            var revAuth = i["author"].stringValue
                             var revCont = i["content"].stringValue
                            self.reviewAuthor.append(revAuth)
                            self.reviewContent.append(revCont)

                        }
                        

                        break
                    case .failure:
                        print(myresponse.error)

                        break
                    }
    //
    //
        self.tableView.reloadData()

                }
                
      
                }
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviewAuthor.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewCellTableViewCell

        // Configure the cell...
//        cell.detailTextLabel?.text =
        cell.contentText.text = reviewAuthor[indexPath.row]
        cell.authorText.text = reviewContent[indexPath.row]
        cell.authorText.sizeToFit()
            return cell
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
