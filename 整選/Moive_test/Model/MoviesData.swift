//
//  MoviesData.swift
//  movie_record
//
//  Created by 陳冠雄 on 2021/3/30.
//


import Foundation
struct MoviesData: Codable {
    var title: String?
    var vote_average: Double?
    var release_date: String?
    var poster_path: String?
    var overview : String?
    

}

struct Film: Codable {
    var results:[MoviesData]
}

struct MovieWithMoreInfo: Codable{
 var adult : Bool
 var genre_ids = [Int]()
 var title: String?
 var vote_average: Double?
 var release_date: String?
 var poster_path: String?
 var overview : String?
 var backdrop_path: String
 var id: Int
 var original_language: String
 var original_title: String
 var popularity: Double
 var vote_count: Int

 
 
}

