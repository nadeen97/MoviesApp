//
//  MoviesHome.swift
//  Movies
//
//  Created by Sara Alaa on 3/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//


//http://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=4b31f0efe12a16c14046bd6788aa555b

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage



//imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))


private let reuseIdentifier = "Cell"

class MoviesHome: UICollectionViewController {
    
    var poster_path = [String]()
    var popularity = [String]()
    var movieTitle = [String]()
    var releaseDate = [String]()
    var overView = [String]()
    var voteAverage = [String]()
    var movieId = [String]()
    
    var myMovies = [Movie] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor.black
        self.navigationItem.title = "Movies Show"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
        fetchFilms()
//        self.collectionView.reloadData()

        }
    
    
        func fetchFilms() {
   Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=4b31f0efe12a16c14046bd6788aa555b", method: .get).responseJSON {
                (myresponse) in
                switch myresponse.result
                {
                    
                case .success:
                    print(myresponse.result)
                    let myresult = try? JSON(data: myresponse.data!)
//                    print(myresult!["results"])
                    let resultArray = myresult!["results"]
                    for i in resultArray.arrayValue
                    {
//                        let posPath = i["poster_path"].stringValue
                        let posPath = "https://image.tmdb.org/t/p/w185/" + i["poster_path"].stringValue
                        let movId = i["id"].stringValue
                        let movPopular = i["popularity"].stringValue
                        let movTitle = i["title"].stringValue
                        let movRelDate = i["release_date"].stringValue
                        let movOverView = i["overview"].stringValue
                        let movVoteAvg = i["vote_average"].stringValue

                        self.poster_path.append(posPath)

                        self.myMovies.append(Movie(mvId: movId,mvTitle: movTitle,mvPostePath: posPath,mvOverView: movOverView,mvReleasDate: movRelDate,mvVoteAvg: movVoteAvg,mvPopularity: movPopular))
                        print(self.poster_path)
                    }
                    

                    break
                case .failure:
                    print(myresponse.error)

                    break
                }
//
//
    self.collectionView.reloadData()

            }
            
  
            }
    
    


        // Do any additional setup after loading the view.


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return poster_path.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        
        //        posterImageView = cell.viewWithTag(1) as! UIImageView
        cell.posterImageView.sd_setImage(with: URL(string: myMovies[indexPath.row].mPosterPath), placeholderImage: UIImage(named: "thumb.png"))
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select")
//        var id:Int?
        
        var  detailsView : MoiveDetails = self.storyboard?.instantiateViewController(withIdentifier: "details") as! MoiveDetails
//        detailsView.movie=self.moviesArray[indexPath.row]
        detailsView.movieShow=self.myMovies[indexPath.row]
        self.navigationController?.pushViewController(detailsView, animated: true)
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
   


}
