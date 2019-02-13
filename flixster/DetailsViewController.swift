//
//  DetailsViewController.swift
//  flixster
//
//  Created by Osama Soliman on 2/8/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var backDrop: UIImageView!
    
    @IBOutlet var poster: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as! String
        let overview = movie["overview"] as! String
        descriptionLabel.text = overview
        
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterURL = URL(string: baseURL + posterPath )
        
        poster.af_setImage(withURL: posterURL!)
        
        let backDropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseURL + backDropPath)
        backDrop.af_setImage(withURL: backdropURL!)
        
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! TrailerViewController
        detailsViewController.movie = movie
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
