//
//  MoiveDetails.swift
//  Movies
//
//  Created by Sara Alaa on 3/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MoiveDetails: UIViewController {
     var delegate: MyFavorits?
    @IBOutlet weak var favBtn: UIButton!
    var movieKeys = [String]()
    var flagSlected = false
    @IBAction func goToReviews(_ sender: Any) {
        
        var  movieReviews : MovieReviews = self.storyboard?.instantiateViewController(withIdentifier: "reviews") as! MovieReviews
        movieReviews.movieId = self.movieShow.mId
    self.navigationController?.pushViewController(movieReviews, animated: true)
        
    }
    @IBOutlet weak var movieTrailers: UITableView!
    @IBAction func favoriteMovie(_ sender: UIButton) {

        if flagSlected ==  false{
            if #available(iOS 13.0, *) {
                favBtn.setImage( UIImage.init(named: "starFill"), for: .normal)
              
//                delegate = self as? MyFavorits
                delegate?.favMovies(favMov: self.movieShow)

                
            } else {
            }
        flagSlected = true
        }else {
            if #available(iOS 13.0, *) {
                         favBtn.setImage( UIImage.init(named: "star"), for: .normal)
                     } else {
                     }
                 flagSlected = false
        }
        
    }

     func fetchTrialers() {
        print("http://api.themoviedb.org/3/movie/\(movieShow.mId)/videos?api_key=4b31f0efe12a16c14046bd6788aa555b")
        Alamofire.request("https://api.themoviedb.org/3/movie/\(movieShow.mId)/videos?api_key=4b31f0efe12a16c14046bd6788aa555b", method: .get).responseJSON {
                    (myresponse) in
                    switch myresponse.result
                    {
                        
                    case .success:
                        print(myresponse.result)
                        let myresult = try? JSON(data: myresponse.data!)
                        let resultArray = myresult!["results"]
                        for i in resultArray.arrayValue
                        {

                            var movKey = i["key"].stringValue
                            self.movieKeys.append(movKey)
                            print (movKey)
                        }
                        break
                    case .failure:
                        print(myresponse.error)
                        
                        break
                    }
            self.movieTrailers.reloadData()

                }
    }
    @IBOutlet weak var myMovieOverView: UITextView!
    @IBOutlet weak var myMovieRelY: UILabel!
    @IBOutlet weak var myMovieRating: UILabel!
    @IBOutlet weak var myMovieTitle: UILabel!
    @IBOutlet weak var myMovieImage: UIImageView!
    var movieShow = Movie()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 31/255, green: 33/255, blue:36/255 , alpha: 1.0)
        self.movieTrailers.backgroundColor = UIColor.init(red: 31/255, green: 33/255, blue:36/255 , alpha: 1.0)

        self.movieTrailers.delegate = self
        self.movieTrailers.dataSource = self
//        self.navigationItem.title = " Movie Details"
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor.lightGray

        myMovieTitle.text = movieShow.mTitle
        myMovieRelY.text  = movieShow.mReleaseDate
        myMovieRating.text = movieShow.mVoteAvg + "/10"
        myMovieOverView.text = movieShow.mOverView
        myMovieImage.sd_setImage(with: URL(string: movieShow.mPosterPath), placeholderImage: UIImage(named: "placeholder.png"))
        fetchTrialers()
        for k in movieKeys
        {
            movieShow.mTrailerKey.append(k)

        }
        let oth = MoviesFavorits()
                self.delegate = oth
                      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MoiveDetails: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTrailers.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Tailer " + "\(indexPath.row+1)"
        return cell!
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var  videoTrailerPlayer : VideoYoutubePlayer = self.storyboard?.instantiateViewController(withIdentifier: "videoPlayer") as! VideoYoutubePlayer
        videoTrailerPlayer.movieTraile = self.movieKeys[indexPath.row]
                       self.navigationController?.pushViewController(videoTrailerPlayer, animated: true)
        
    }
    
}
