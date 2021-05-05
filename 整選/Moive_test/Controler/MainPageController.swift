//
//  MainPage.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/5/2.
//

import UIKit




class MainPageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var mainCover: UIImageView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var popularMovie = [MoviesData]()
    var mainPageArray = [MoviesData]()
    var timer:Timer?
    var index = 0
    
   //-----------------menu
    
    @IBOutlet weak var hotMoive: UILabel!
    @IBOutlet var options: [UIButton]!
   
    @IBAction func Menu(_ sender: Any) {
        
        for option in options{
               option.isHidden = !option.isHidden
           }
    }
    @IBAction func upComing(_ sender: Any) {
        loadTopRatedData()
        hotMoive.text = "TopRated"
    }
    
    @IBOutlet weak var topic: UIButton!
    
    @IBAction func Hot(_ sender: Any) {
        loadUpcomingData()
        hotMoive.text = "UpComing"
    }
    
    @IBAction func Hot20(_ sender: Any) {
        loadPopularData()
        hotMoive.text = "Hot 20"
    }
    
    
    //-------------------------------
    //顯示幾個cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovie.count
    }
    //顯示cell內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell( withReuseIdentifier: "MainCollectionViewCell", for: indexPath as IndexPath) as! MainCollectionViewCell
        if
            let moviesImageURL = URL(string: "https://image.tmdb.org/t/p/w300/" + popularMovie[indexPath.row].poster_path!)
        {
            
            
            cell.movieCollectionViewCellCover.loadImage(url: moviesImageURL)
        } else {
            cell.movieCollectionViewCellCover = .none
        }

        return cell
    }
//點選cell 顯示的內容
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let MIF = storyBoard.instantiateViewController(withIdentifier: "MoiveInfoViewControler") as! MoiveInfoViewControler
      
        self.present(MIF, animated: true, completion: nil)
        MIF.overview.text = popularMovie[indexPath.row].overview!
        MIF.movieTitle.text = popularMovie[indexPath.row].title!
        MIF.rating.text = String(popularMovie[indexPath.row].vote_average!)
        MIF.releaseDate.text = popularMovie[indexPath.row].release_date!
        
        if
            let moviesImageURL = URL(string: "https://image.tmdb.org/t/p/w300/" + popularMovie[indexPath.row].poster_path!)
        {
        
        MIF.postpath = popularMovie[indexPath.row].poster_path!
            MIF.movieCover.loadImage(url: moviesImageURL)
        } else {
            MIF.movieCover = .none
        }
    }

    
    
//------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        selectsql()
        //委任collection
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(movieInfoAction))
      
          loadPopularData()
        time()
        self.mainCover.addGestureRecognizer(gesture)
        
    }
    
    
    
}







extension MainPageViewController{
    //load popular movie func
    func loadPopularData() {
         
         guard let  url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=8f2f08dd68882b59deddf10221a64a5a&language=en-US&page=1".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {
             print("invalid")
             return
         }
         let request = URLRequest(url: url)
         URLSession.shared.dataTask(with: request){data , response , error in
             if let data = data{
                 if let decodeResponse = try? JSONDecoder().decode(Film.self, from: data){
                     DispatchQueue.main.async {

                        self.popularMovie = decodeResponse.results
                        self.mainPageArray = decodeResponse.results
                        self.mainCollectionView.reloadData()
                        print(self.mainPageArray.count)
                        
                     }
                 }
             }
             
         }.resume()
     }
    // load upcoming movie func
    func loadTopRatedData() {
         //https://api.themoviedb.org/3/search/movie?api_key=8f2f08dd68882b59deddf10221a64a5a&language=en-US&query=F&page=1&include_adult=false
         guard let  url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=8f2f08dd68882b59deddf10221a64a5a&language=en-US&page=1".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {
             print("invalid")
             return
         }
         let request = URLRequest(url: url)
         URLSession.shared.dataTask(with: request){data , response , error in
             if let data = data{
                 if let decodeResponse = try? JSONDecoder().decode(Film.self, from: data){
                     DispatchQueue.main.async {
                        
 //                        print(decodeResponse.results)
                        self.popularMovie = decodeResponse.results
//                        self.MainCollectionView.collectionViewLayout.invalidateLayout()
                        self.mainCollectionView.reloadData()
                     }
                 }
             }
             
         }.resume()
     }
    // loadupcoming
    func loadUpcomingData() {
         //https://api.themoviedb.org/3/search/movie?api_key=8f2f08dd68882b59deddf10221a64a5a&language=en-US&query=F&page=1&include_adult=false
         guard let  url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=8f2f08dd68882b59deddf10221a64a5a&language=en-US&page=11".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {
             print("invalid")
             return
         }
         let request = URLRequest(url: url)
         URLSession.shared.dataTask(with: request){data , response , error in
             if let data = data{
                 if let decodeResponse = try? JSONDecoder().decode(Film.self, from: data){
                     DispatchQueue.main.async {
                        
 //                        print(decodeResponse.results)
                        self.popularMovie = decodeResponse.results
//                        self.MainCollectionView.collectionViewLayout.invalidateLayout()
                        self.mainCollectionView.reloadData()
                     }
                 }
             }
             
         }.resume()
     }
    
    
}

//set image
extension MainPageViewController{
    
    func time() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true){
            (timer) in self.loadImageData()
            
        }
    }
    
    func loadImageData(){
        if index<mainPageArray.count{
            if
                let moviesImageURL = URL(string: "https://image.tmdb.org/t/p/w300/" +  mainPageArray[index].poster_path!)
            {

                mainCover.loadImage(url: moviesImageURL)
                index += 1
            } else {
                mainCover = .none
                index += 1
            }
        }else{
            index=0
        }
    }
    //click image function
    @objc func movieInfoAction(sender : UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let MIF = storyBoard.instantiateViewController(withIdentifier: "MoiveInfoViewControler") as! MoiveInfoViewControler
      
        self.present(MIF, animated: true, completion: nil)
        MIF.overview.text = mainPageArray[index-1].overview!
        MIF.movieTitle.text = mainPageArray[index-1].title!
        MIF.rating.text = String(mainPageArray[index-1].vote_average!)
        MIF.releaseDate.text = mainPageArray[index-1].release_date!
        
        if
            let moviesImageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + mainPageArray[index-1].poster_path!)
        {
        
        MIF.postpath = mainPageArray[index-1].poster_path!
            MIF.movieCover.loadImage(url: moviesImageURL)
        } else {
            MIF.movieCover = .none
        }
    }
    
    
    
    
    
    
    }

