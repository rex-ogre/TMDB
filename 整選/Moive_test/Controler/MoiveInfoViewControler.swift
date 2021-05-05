//
//  MoiveInfoViewControler.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/4/16.
//

import Foundation
import UIKit
class MoiveInfoViewControler: UIViewController, UIScrollViewDelegate   {
    //-----------------------------------------
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    var postpath: String!
    //----------------------------------------- button function
    // favorite button
    @IBAction func AddToFavorite(_ sender: Any) {
        if favoriteMovieTitleArray.contains(movieTitle.text!)  {
            
            
            let alert = UIAlertController(title: "Already in favorite", message: "The movie already in favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            alert.addAction(UIAlertAction(title: "unfavorite", style: .destructive, handler: {
                                            (action: UIAlertAction!) -> Void in
                                            unfavorite(self.movieTitle.text!  )
                                            self.favoriteButton.isSelected = false;  self.performSegue(withIdentifier: "yourIdHere", sender: self) }))
            
            self.present(alert, animated: true, completion: nil)
            
            
            
        } else{
            
            
            Insert(movieTitle.text!,Float(rating.text!)!,overview.text!, releaseDate.text!,postpath!)
            
            favoriteButton.isSelected = true
            
        }
        
        
    }
    //-----------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        if favoriteMovieTitleArray.contains(movieTitle.text!) {
            
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
        }
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollView.delegate = self
        
        
    }
  
    
}


//-----------------------------------------
//檢索button狀態
extension MoiveInfoViewControler {
    
    func selectsqlforbutton() {
        let sql = "SELECT * FROM Favorite  "
        
        // 执行SQL语句
        let db = SQLiteManager.shareManger().db
        if db.open() {
            if let res = db.executeQuery(sql, withArgumentsIn: []){
                // 遍历输出结果
                while res.next() {
                    let SqlMovieTitle = res.string(forColumn: "MovieTitle")!
         
                    if movieTitle.text == SqlMovieTitle {
                        favoriteButton.isSelected = true
                        
                    } else{
                        favoriteButton.isSelected = false
                        
                    }
                }
            }else{
                print("查询失败")
            }
        }
        db.close()
    }
}
