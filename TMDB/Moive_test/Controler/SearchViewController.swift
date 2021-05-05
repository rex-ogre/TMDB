//
//  ViewController.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/4/16.
//
import UIKit

import Foundation






class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate   {
    
 
    
    var tableView : UITableView!
    var searchController : UISearchController!
    var movieArray =  [MoviesData]()
    @IBOutlet weak var searchMovieBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
 
    // 實作：有幾個array
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "cell", for: indexPath as IndexPath) as!
            MovieTableViewCell
    
        
        // 顯示的內容
        if let myLabel = cell.Label {
            myLabel.text =
                movieArray[indexPath.row].title
        }
        
        return cell
    }
//-----------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
        // 設置委任對象
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchMovieBar.delegate = self

       
       
    }
    // 點擊選項 展示出電影細節

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let MIF = storyBoard.instantiateViewController(withIdentifier: "MoiveInfoViewControler") as! MoiveInfoViewControler
      
        self.present(MIF, animated: true, completion: nil)
        MIF.overview.text = movieArray[indexPath.row].overview!
        MIF.movieTitle.text = movieArray[indexPath.row].title!
        MIF.rating.text = String(movieArray[indexPath.row].vote_average!)
        MIF.releaseDate.text = movieArray[indexPath.row].release_date!
        
        if
            let moviesImageURL = URL(string: "https://image.tmdb.org/t/p/w300/" + movieArray[indexPath.row].poster_path!)
        {
        
        MIF.postpath = movieArray[indexPath.row].poster_path!
            MIF.movieCover.loadImage(url: moviesImageURL)
        } else {
            MIF.movieCover = .none
        }
    }
    
    
}       

//SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        loadData(key_word: searchText)
    }
    
// SearchBar API
    func loadData(key_word: String) {
        
        guard let  url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=8f2f08dd68882b59deddf10221a64a5a&language=en-US&query=\(key_word)&page=1&include_adult=false".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {
            print("invalid")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){data , response , error in
            if let data = data{
                if let decodeResponse = try? JSONDecoder().decode(Film.self, from: data){
                    DispatchQueue.main.async {
                        
                        self.movieArray = decodeResponse.results
                        self.movieTableView.reloadData()
                    }
                }
            }
            
        }.resume()
    }
    
}

