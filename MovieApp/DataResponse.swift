//
//  DataResponse.swift
//  MovieApp
//
//  Created by Sharon on 2021/11/3.
//

import Foundation

struct DataResponse:Codable {
    var results:[DatailMovie]
}

struct DatailMovie:Codable {
    var id : Int
    var original_title: String
    var overview: String
    var poster_path:String?
    var vote_average: Float
}
//https://api.themoviedb.org/3/movie/580489/videos?api_key=ddfdbf1437484d15d2e88be7da8f38f4
struct FindVideos:Codable {
    var results:[Video]
}

struct Video :Codable{
    var name:String?
    var key:String?
    var type:String?
}

struct Photo{
    let rgb: String
    let url: URL
}
