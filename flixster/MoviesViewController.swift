//
//  MoviesViewController.swift
//  flixster
//
//  Created by Osama Soliman on 2/2/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit
import AlamofireImage




class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
    @IBOutlet var MoviesTable: UITableView!
    
    
    
    
    
    var Movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        MoviesTable.dataSource = self
        MoviesTable.delegate = self
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.Movies = dataDictionary["results"] as! [[String : Any]]
                
                self.MoviesTable.reloadData()
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
               // print(dataDictionary)
            }
        }
        task.resume()


        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesTable.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let movie = Movies[indexPath.row]
        let overview = movie["overview"] as! String
        let title = movie["title"] as! String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterURL = URL(string: baseURL + posterPath )
        
        cell.PosterView.af_setImage(withURL: posterURL!)
        
        cell.TitleLable!.text = title
        cell.SynLable!.text = overview
        return cell
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

