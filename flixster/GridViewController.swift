//
//  GridViewController.swift
//  flixster
//
//  Created by Osama Soliman on 2/10/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit
import AlamofireImage

class GridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    
    @IBOutlet var CollectionView: UICollectionView!
    var Movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        let layout = CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width  = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width*1.5)

        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // TODO: Get the array of movies
                self.Movies = dataDictionary["results"] as! [[String : Any]]
                self.CollectionView.reloadData()
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviewGridCell", for: indexPath) as! MoviewGridCell
        
        let movie = Movies[indexPath.item]
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterURL = URL(string: baseURL + posterPath )
        
        cell.posterView.af_setImage(withURL: posterURL!)
        
        return cell
    }

    
    // MARK: - Navigation

     
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let cell = sender as! UICollectionViewCell
        let indexPath = CollectionView.indexPath(for: cell)
        let movie = Movies[indexPath!.item]
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.movie = movie
        // Pass the selected object to the new view controller.
    }
    

}
