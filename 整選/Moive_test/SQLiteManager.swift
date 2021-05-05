//
//  SQLiteManager.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/4/26.
//

import Foundation
import UIKit
class SQLiteManager: NSObject {
    private static let manager: SQLiteManager = SQLiteManager()
    class func shareManger() -> SQLiteManager {
        return manager
    }
    //數據庫名稱
    private let dbName = "test.db"
    
    lazy var dbURL: URL = {
        // 根据传入的数据库名称拼接数据库的路径
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask,
                 appropriateFor: nil, create: true)
            .appendingPathComponent(dbName)
        print("数据库地址：", fileURL)
        return fileURL
    }()
    
    //
    lazy var db: FMDatabase = {
        let database = FMDatabase(url: dbURL)
        return database
    }()
    // FMDatabaseQueue对象（用于多线程事务处理）
    lazy var dbQueue: FMDatabaseQueue? = {
        // 根据路径返回数据库
        let databaseQueue = FMDatabaseQueue(url: dbURL)
        return databaseQueue
    }()
    
}
//SQL function

public func createTable() {
    let sql = "CREATE TABLE IF NOT EXISTS Favorite( \n" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
        "MovieTitle TEXT, \n" +
        "Rating FLOAT, \n" +
        "Release TEXT, \n" +
        "Overview TEXT, \n" +
        "Postpath TEXT \n" +
        "); \n"
    let db = SQLiteManager.shareManger().db
    if db.open() {
        if db.executeUpdate(sql, withArgumentsIn: []) {
            print("創建資料庫成功")
        }else{
            print("創建資料庫失敗")
        }
        
    }
    db.close()
}
//SQL INSERT


public func Insert(_ MovieTitle: String,_ Rating: Float,_ Overview: String,_ Release: String,_ Postpath: String){
   
    let db = SQLiteManager.shareManger().db
  
    let sql = "INSERT INTO Favorite (MovieTitle, Rating,Release,Overview,Postpath) VALUES (?,?,?,?,?)"
     
    // 执行SQL语句
    
    if db.open() {
        if db.executeUpdate(sql, withArgumentsIn: [MovieTitle,Rating,Release,Overview,Postpath]){
            
            favoriteMovieTitleArray.append(MovieTitle)
            favoriteMoviewReleaseArray.append(Release)
            favoriteMovieRatingArray.append(String(format: "%.2f", Rating))
            favoritePostPathArray.append(Postpath)
            favoriteOverviewArray.append(Overview)
            
            print("插入成功")
        }else{
            print("插入失败")
        }
    }
    db.close()
    
}
public func drop(){
    
     let db = SQLiteManager.shareManger().db
   
    let sql = "drop table Favorite"
      
     // 执行SQL语句
     
     if db.open() {
         if db.executeUpdate(sql, withArgumentsIn: []){
             print("刪除成功")
         }else{
             print("刪除失败")
         }
     }
     db.close()
     
}


public func count()->Int{
    let db = SQLiteManager.shareManger().db
    let sql = "SELECT COUNT(*) AS count FROM favorite"
    db.open()
    if let res = db.executeQuery(sql, withArgumentsIn: []){
        if res.next() {
            return Int(res.int(forColumn: "count"))
        } else {
            return 0
        }
        
        
        
    }
    db.close()
    return 0
}


public func selectsql() {
let sql = "SELECT * FROM Favorite "

// 执行SQL语句
let db = SQLiteManager.shareManger().db
if db.open() {
if let res = db.executeQuery(sql, withArgumentsIn: []){
    // 遍历输出结果
    while res.next() {
       print("查詢成功")
        let MovieTitle = res.string(forColumn: "MovieTitle")!
        let Release = res.string(forColumn: "Release")!
        let Overview = res.string(forColumn: "Overview")!
        let Postpath = res.string(forColumn: "Postpath")!
        let Rating = res.double(forColumn: "Rating")
        
        favoriteMovieTitleArray.append(MovieTitle)
        favoriteMoviewReleaseArray.append(Release)
        favoriteMovieRatingArray.append(String(format: "%.2f", Rating))
        favoritePostPathArray.append(Postpath)
        favoriteOverviewArray.append(Overview)
            
    }
}else{
    print("查询失败")
    
}
}
db.close()
}
public func unfavorite(_ MovieTitle: String){
    let db = SQLiteManager.shareManger().db
    let sql = "DELETE FROM Favorite WHERE MovieTitle = ?"
 
    
    if db.open() {
        if db.executeUpdate(sql, withArgumentsIn: [MovieTitle]){
            
            if let idx = favoriteMovieTitleArray.firstIndex(of: MovieTitle) {
            
            
            favoriteMovieTitleArray.remove(at: idx)
            favoriteMoviewReleaseArray.remove(at: idx)
            favoriteMovieRatingArray.remove(at: idx)
            favoritePostPathArray.remove(at: idx)
            favoriteOverviewArray.remove(at: idx)
            }
            print("移除成功")
        }else{
            print("移除失败")
        }
    }

    db.close()
    
}
