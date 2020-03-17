//
//  VideoYoutubePlayer.swift
//  Movies
//
//  Created by Sara Alaa on 3/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit


class VideoYoutubePlayer: UIViewController {
//    var movieSelcted = Movie()
    var movieTraile = ""

    @IBOutlet weak var youtubePlayer: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 31/255, green: 33/255, blue:36/255 , alpha: 1.0)
        
//        youtubePlayer.loadWithVideoId("6JnN1DmbqoU")
        youtubePlayer.load(withVideoId: movieTraile)
        // Do any additional setup after loading the view.
        
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
