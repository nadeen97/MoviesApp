//
//  Movie.swift
//  Movies
//
//  Created by Sara Alaa on 3/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class Movie {
    var mId = ""
    var mTitle = ""
    var mPosterPath = ""
    var mOverView = ""
    var mReleaseDate = ""
    var mVoteAvg = ""
    var mPopularity = ""
    var mFavorite = false
    var mTrailerKey = [String]()
    
    init(mvId:String,mvTitle :String,mvPostePath: String,mvOverView :String,mvReleasDate :String,mvVoteAvg :String,mvPopularity :String) {
        mId = mvId
        mTitle = mvTitle
        mPosterPath = mvPostePath
        mOverView = mvOverView
        mReleaseDate = mvReleasDate
        mVoteAvg = mvVoteAvg
        mPopularity = mvPopularity
        mFavorite = false
//        mTrailerKey.append("")
    }
 init() {
      mId = ""
      mTitle = ""
      mPopularity = ""
      mVoteAvg = ""
      mPosterPath = ""
      mReleaseDate = ""
      mOverView = ""
    mFavorite = false
//    mTrailerKey.append("")

  

}
    init(mvId:String,mvPostePath: String)
    {
        mId = mvId
        mPosterPath = mvPostePath
    }
//    init(mvId:String,mvFavorite : Bool) {
//        mId = mvId
//        mFavorite = mvFavorite
//    }
}
