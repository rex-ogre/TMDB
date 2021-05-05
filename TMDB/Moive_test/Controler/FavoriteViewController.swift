//
//  FavoriteViewController.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/4/27.
//

import Foundation
import UIKit






class FavoriteViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var FavoriteTableView: UITableView!
    
    //------------------------------------------ tableview method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 取得 tableView 目前使用的 cell
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "FavoriteMovieCell", for: indexPath as IndexPath) as!
            FavoriteMovieCell
        cell.movieTitle.text = favoriteMovieTitleArray[indexPath.row]
        cell.ratingLabel.text = favoriteMovieRatingArray[indexPath.row]
        cell.releaseDate.text = favoriteMoviewReleaseArray[indexPath.row]
        
        parsedfavoritMoviesImageURL = URL(string: "https://image.tmdb.org/t/p/w92/" + favoritePostPathArray[indexPath.row] )
        
        
        cell.movieCover.loadImage(url: parsedfavoritMoviesImageURL!)
       
        return cell
       
    }




    //點選cell 出現movieinfo

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let MIF = storyBoard.instantiateViewController(withIdentifier: "MoiveInfoViewControler") as! MoiveInfoViewControler
      
        self.present(MIF, animated: true, completion: nil)
        MIF.overview.text = favoriteOverviewArray[indexPath.row]
        MIF.movieTitle.text = favoriteMovieTitleArray[indexPath.row]
        MIF.rating.text = favoriteMovieRatingArray[indexPath.row]
        MIF.releaseDate.text = favoriteMoviewReleaseArray[indexPath.row]
        
        
       if  let moviesImageURL = URL(string: "https://image.tmdb.org/t/p/w300/" + favoritePostPathArray[indexPath.row])
       {
        MIF.postpath = favoritePostPathArray[indexPath.row]
        MIF.movieCover.loadImage(url: moviesImageURL)
       } else {
        MIF.movieCover = .none  
       }
    }
    
    
    
    
    
    
//------------------------------------------
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.FavoriteTableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // 委任
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
        
        
    }
//----------------------------------------- 
//reloaddata when unfavorite
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.FavoriteTableView.reloadData()
               
                
            }
        }
    }


    
    
    
}




