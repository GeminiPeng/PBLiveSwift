//
//  ViewController.swift
//  PBLiveSwift
//
//  Created by Pengbo on 2017/1/4.
//  Copyright © 2017年 LivewSwift. All rights reserved.
//

import UIKit
import Just


var SCREEN_WIDTH = UIScreen.main.bounds.size.width
var SCREEN_HEIGHT = UIScreen.main.bounds.size.height



class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    let liveListUrl = "http://service.inke.com/api/live/simpleall?lc=0000000000000045&cc=TG0001&cv=IK3.8.30_Iphone&proto=7&idfa=E4150662-DDC4-4D0F-ABF9-690B0BB3252C&idfv=05D0DF38-FE6C-44A0-B80E-D5EB92B4D699&devi=b8c91a64bdd3a67fd4f1e7fc9e4f66bbe30002a1&osversion=ios_10.200000&ua=iPhone9_2&imei=&imsi=&uid=342124849&sid=20Ri1sd7aoIPxux26FeIzNhhtaghi1PHi2R0FBi17saWnfXGwAsT9Y&conn=wifi&mtid=3ec50397bdcc1a8c6ff4d529dae35337&mtxid=20a6807b664&logid=133,5&s_sg=412b8178e2c21a75a2641768aabb5709&s_sc=100&s_st=1483517291"
    
    var listArray : [PBLiveCell] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(self.liveTableView)
        
        liveList()
        
        self.liveTableView.refreshControl = UIRefreshControl()
        self.liveTableView.refreshControl?.addTarget(self, action: #selector(liveList), for: UIControlEvents.touchUpInside)
        
        self.title = "映客直播"
    }
    
    func liveList() -> Void {
        Just.post(liveListUrl) { (r) in
            
            guard let json = r.json as? NSDictionary else {
                return
            }
            
            let lives = PBRootClass(fromDictionary: json).lives!
            self.listArray = lives.map({ (live) -> PBLiveCell in
                return PBLiveCell(headImage: live.creator.portrait, nick: live.creator.nick, location: live.city, number: live.onlineUsers, streamUrl: live.streamAddr)
            })
            
            OperationQueue.main.addOperation {
                self.liveTableView.reloadData()
                self.liveTableView.refreshControl?.endRefreshing()
            }
        }
    }

    
    lazy var liveTableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableViewStyle.plain)
        
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.white
        return table
    }()
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier="liveCell"
        
        let cell=LiveCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        cell.liveList = listArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 700
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detaile = DetailViewController()
        detaile.userInfo = listArray[indexPath.row]
        self.navigationController?.pushViewController(detaile, animated: true)
    }
}

