//
//  DatailMovieViewController.swift
//  MovieApp
//
//  Created by Sharon on 2021/11/3.
//

import UIKit
import SafariServices
import AVFoundation

class DatailMovieViewController: UIViewController {
    
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    let movie : DatailMovie
    //    var key:String?
    
    init?(coder: NSCoder,item: DatailMovie) {
        self.movie = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.original_title
        overviewTextView.text = movie.overview
        
        if let posterStr = movie.poster_path,
           let  url = URL(string:"https://image.tmdb.org/t/p/w500/" + posterStr ){
            
            URLSession.shared.dataTask(with:url) { (data, response, error) in
                if let data = data{
                    
                    DispatchQueue.main.async {
                        self.postPhoto.image = UIImage(data: data)
                    }
                }
            }.resume()
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Play(_ sender: Any) {
        getVideoKey { (key) in
            guard let key = key else{return}
            if let url = URL(string: "http://youtube.com/watch?v=\(key)"){
                let safariVC = SFSafariViewController(url:url)
                DispatchQueue.main.async {
                    self.present(safariVC , animated: true , completion: nil)
                }
                
            }
        }
        
    }
    
    
    //找出type為Trailer的key
    func getVideoKey(completionHandler: @escaping (String?) -> Void) {
        let urlStr = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=ddfdbf1437484d15d2e88be7da8f38f4"
        var videoArray = [Video]()
        
        
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                let decoder = JSONDecoder()
                do{
                    if let data = data{
                        let videos =  try decoder.decode(FindVideos.self, from: data)
                        videoArray = videos.results
                        for i in 0...videoArray.count{
                            if let type = videoArray[i].type{
                                if type.elementsEqual("Trailer"){
                                    completionHandler(videoArray[i].key!)
                                    break
                                }
                            }
                        }
                    }else{
                        completionHandler(nil)
                    }
                }catch{
                    
                }
                
            }.resume()
        }
        
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
