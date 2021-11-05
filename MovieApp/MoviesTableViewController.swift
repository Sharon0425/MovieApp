//
//  MoviesTableViewController.swift
//  MovieApp
//
//  Created by Sharon on 2021/11/3.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    
    var items = [DatailMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.original_title
        
        if let posterStr = item.poster_path,
           let  url = URL(string:"https://image.tmdb.org/t/p/w500/" + posterStr ){
            
            URLSession.shared.dataTask(with:url) { (data, response, error) in
                if let data = data{
                    DispatchQueue.main.async {
                        cell.posterPhoto.image = UIImage(data: data)
                    }
                }
            }.resume()
            
        }
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
    
    @IBSegueAction func showDatailMovie(_ coder: NSCoder) -> DatailMovieViewController? {
        
        if let row = tableView.indexPathForSelectedRow?.row{
            return DatailMovieViewController(coder: coder,item: items[row])
        }else{
        return nil
        }
    }
    
    func getMovieData(){
        let urlStr = "https://api.themoviedb.org/3/discover/movie?api_key=ddfdbf1437484d15d2e88be7da8f38f4&sort_by=popularity.desc&primary_release_year=2021"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data{
                    do {
                        let dataResponse =  try decoder.decode(DataResponse.self, from: data)
                        self.items = dataResponse.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch  {
                        print(error)
                    }
                    
                }
            }.resume()
        }
    }
    
}
