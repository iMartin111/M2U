//
//  DetailsTableViewController.swift
//  M2U
//
//  Created by Yan Akhrameev on 21/09/21.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    // MARK: - Properties:
    
    private var apiManager = APIManager()
    private var movie: Movie?
    private var movies: Movies?
    
    // MARK: - View LifeCycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsTableViewCell")
        self.tableView.register(UINib(nibName: "RelatedTableViewCell", bundle: nil), forCellReuseIdentifier: "RelatedTableViewCell")
        self.tableView.tableFooterView = UIView()
        
        self.apiManager.fetchMovie { (result) in
            switch result {
                case .success(let movie):
                    DispatchQueue.main.async {
                        self.movie = movie
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        self.apiManager.fetchRelatedMovies { (result) in
            switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self.movies = movies
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    

    // MARK: - Table View Data Source:

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            guard let movies = movies else {return 0}
            return movies.results.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.frame.height / 2
        } else {
            return 100
        }
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: DetailsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as? DetailsTableViewCell
            if let movie = movie {
                cell?.setup(with: movie)
            }
            return cell ?? UITableViewCell()
        } else {
            let cell: RelatedTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RelatedTableViewCell", for: indexPath) as? RelatedTableViewCell
            if let movies = movies {
                cell?.setup(with: movies.results[indexPath.row])
            }
            return cell ?? UITableViewCell()
        }
    }
   

    
}
