//
//  MoviesFavoritsCollectionViewController.swift
//  Movies
//
//  Created by Sara Alaa on 3/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesFavorits: UICollectionViewController,MyFavorits {
    func favMovies(favMov: Movie) {
        myFavoriteMovies.append(favMov)
//        let layout = UICollectionViewFlowLayout()
//               self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//               layout.scrollDirection = .vertical
//               view.addSubview(collectionView)
//        self.collectionView.reloadData()
        
    }
    
var myFavoriteMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
       
        // Register cell classes
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.backgroundColor = UIColor.init(red: 31/255, green: 33/255, blue:36/255 , alpha: 1.0)
        self.navigationItem.title = "Favorite Movies"

        // Do any additional setup after loading the view.
    }

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
        print("The val is " )
//            print(favMovies.myFavoriteMovies.count)
        return myFavoriteMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavorietMovieCell
    
        // Configure the cell
//          cell.fav.sd_setImage(with: URL(string: myMovies[indexPath.row].mPosterPath), placeholderImage: UIImage(named: "placeholder.png"))
        cell.favMovPoster.sd_setImage(with: URL(string: myFavoriteMovies[indexPath.row].mPosterPath), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        return cell
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
