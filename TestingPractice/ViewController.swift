//
//  ViewController.swift
//  TestingPractice
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var tableview: UITableView!
    
    var movies = [Movie]() {
        didSet {
            self.tableview.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableview.delegate = self
        self.tableview.dataSource = self
        loadData()
        
        tableview.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func loadData() {
        MovieAPI.manager.searchMovies(keyword: "comedy") { (error, movie) in
            if let error = error {
                print(error)
            }
            else if let movie = movie {
                let filteredMovie = movie.filter({ (movie) -> Bool in
                  return movie.contentAdvisoryRating == "unrated"
                })
                self.movies = filteredMovie
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! TableViewCell
        cell.title.text = movie.artistName
        cell.detailLabel.text = movie.kind
        cell.imageView?.image = nil
        ImageHelper.manager.loadImage(urlString: movie.artworkUrl60) { (error, image) in
            cell.imageView?.image = image
        }
        return cell
    }
    
}
