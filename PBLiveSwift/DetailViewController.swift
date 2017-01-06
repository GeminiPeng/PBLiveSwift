//
//  DetailViewController.swift
//  PBLiveSwift
//
//  Created by Pengbo on 2017/1/5.
//  Copyright © 2017年 LivewSwift. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
    
    
    var _userInfo : PBLiveCell!
    var playerView : UIView!
    var ijkPlayer : IJKMediaPlayback!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSubViews()
        
        setPlayerView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        ijkPlayer.shutdown()
    }
    
    
    func setSubViews() -> Void {
        
        view.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        
        view.addSubview(gifBtn)
        gifBtn.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.width.height.equalTo(50)
        }
        
        view.addSubview(xinBtn)
        xinBtn.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.width.height.equalTo(50)
        }
        xinBtn.layer.cornerRadius = 25
    }
    
    
    func setPlayerView() -> Void {
        self.playerView = UIView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64))
        view.addSubview(self.playerView)
        
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: _userInfo.streamUrl, with: nil)
        let pv = ijkPlayer.view!
        pv.frame = playerView.bounds
        pv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView.insertSubview(pv, at: 1)
        ijkPlayer.scalingMode = .aspectFill
        
        
        view.bringSubview(toFront: gifBtn)
        view.bringSubview(toFront: xinBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.ijkPlayer.isPlaying() {
            ijkPlayer.prepareToPlay()
        }
    }

    lazy var backView: DetailView = {
        let back = DetailView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        back.backgroundColor = UIColor.white
        return back
    }()
    
    lazy var gifBtn: UIButton = {
        let gif = UIButton(type: UIButtonType.custom)
        gif.backgroundColor = UIColor.red
        gif.addTarget(self, action: #selector(giveGif), for: UIControlEvents.touchUpInside)
        return gif
    }()
    
    lazy var xinBtn: UIButton = {
        let xin = UIButton(type: UIButtonType.custom)
        xin.backgroundColor = UIColor.green
        xin.addTarget(self, action: #selector(clickXin), for: UIControlEvents.touchUpInside)
        return xin
    }()
    
    var userInfo: PBLiveCell! {
        
        didSet {
            _userInfo = userInfo
            backView.backImage.image = UIImage(data: NSData(contentsOf: NSURL(string: _userInfo!.headImage) as! URL) as! Data)
        }
    }
    
    func giveGif() -> Void {
        
        let duration = 3.0
        let hua = UIImageView(image: #imageLiteral(resourceName: "meiguihua"))
        
        hua.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        view.addSubview(hua)
        
        let widthHua:CGFloat = 120.0
        let heightHua:CGFloat = 90.0
        
        UIView.animate(withDuration: duration) {
            hua.frame = CGRect(x: SCREEN_WIDTH/2-widthHua, y: SCREEN_HEIGHT/2-heightHua, width: widthHua, height: heightHua)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+duration){
            
            UIView.animate(withDuration: duration, animations: { 
                hua.alpha = 0
            }, completion: { (completed) in
                hua.removeFromSuperview()
            })
        }
    }
    
    func clickXin() -> Void {
        
        let heart = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        heart.center = CGPoint(x: xinBtn.frame.origin.x, y: xinBtn.frame.origin.y)
        
        view.addSubview(heart)
        heart.animate(in: view)
        
        let btnAnima = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnima.values =   [1.0,0.7,0.5,0.3,0.5,0.7,1.0,1.2,1.4,1.2,1.0]
        btnAnima.keyTimes = [0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
        btnAnima.duration = 0.2
        xinBtn.layer.add(btnAnima, forKey: "SHOW")
        
    }
    
}
