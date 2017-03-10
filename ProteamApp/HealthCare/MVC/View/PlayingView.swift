//
//  PlayingView.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//


import UIKit
import AVFoundation
import CoreMedia
import MBProgressHUD
import youtube_ios_player_helper
import SnapKit
class PlayingView: UIView,YTPlayerViewDelegate {
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblCurentTime: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var sliderProgress: UISlider!
    
    var playerView:YTPlayerView?
    var sliderEditing:Bool?
    var meterTimer:Timer?
    var check:Timer?
    var currentSong:String?
    override func awakeFromNib() {
        //        self.animate(duration: 0.4, animations: {
        //            self.center.y += -Constant.Systems.screen_size.height
        //            }, completion: nil)
        //initPlayerView()
        sliderEditing = false
        sliderProgress.setThumbImage(UIImage(named: "ic-thumb"), for: .normal)
        check = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkPlayer), userInfo: nil, repeats: true)
        showLoadingHUD()
    }
    
    //MARK: Play youtube
    func initPlayerView(videoID:String){
        playerView = YTPlayerView()
        self.playerView!.delegate = self
        let playerVars = ["playsinline": 1,"autohide":0,"autoplay" :1]
        // if currentSong != nil{
        playerView!.load(withVideoId: videoID, playerVars: playerVars)
        
        self.addSubview(playerView!)
        playerView?.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.leading.equalTo(self).offset(0)
            make.trailing.equalTo(self).offset(-0)
            make.bottom.equalTo(self).offset(-0)
            
        }
    }
    
    @IBAction func btnPlayTouchUp(sender: AnyObject) {
        // playerView!.playVideo()
            if btnPlay.isSelected{
                print("play")
                btnPlay.isSelected = false
                    playerView!.playVideo()
                let duration : CMTime = CMTimeMake(Int64(self.playerView!.duration()),1)
                let seconds : Float64 = CMTimeGetSeconds(duration)
                sliderProgress.maximumValue = Float(Int(Float(seconds))) - 1
                sliderProgress.isContinuous = true
                sliderProgress.tintColor = .green
            }else{
                self.playerPause()
                print("pause")
            }
    }
    
    func playerPause(){
        self.btnPlay.isSelected = true
        self.playerView?.pauseVideo()
        self.meterTimer?.invalidate()
    }
    
    //var i = 0
    func UpdateSlider(){
        if lblCurentTime.text != lblDuration.text{
            if playerView != nil{
                if sliderEditing == false {
                    sliderProgress.value = Float(Int(Float(playerView!.currentTime())))
                    lblCurentTime.text = self.formatTime(time: CGFloat(Int(Float(playerView!.currentTime())))) as String
                    //                print(i)
                    //                i = i + 1
                    
                }
            }
        }else{
            sliderProgress.value = 0
           playerView!.seek(toSeconds: 0, allowSeekAhead: true)
            lblCurentTime.text = "00:00"
            playerView?.pauseVideo()
            btnPlay.isSelected = true
        }
    }
    @IBAction func sliderProgressValueChanged(sender: AnyObject) {
        let newProgress:Float = self.sliderProgress.value
        let newPercentage:Float = newProgress / (self.sliderProgress.maximumValue - self.sliderProgress.minimumValue)
        let seekToTime = Float64(newPercentage) * CMTimeGetSeconds(CMTimeMake(Int64(playerView!.duration()),1))
        playerView!.seek(toSeconds: Float(seekToTime), allowSeekAhead: true)
    }
    
    @IBAction func sliderProgressTouchDow(sender: AnyObject) {
        sliderEditing = true
        playerView!.pauseVideo()
    }
    
    @IBAction func sliderProgressTouchUp(sender: AnyObject) {
        sliderEditing = false
        btnPlay.isSelected = false
        playerView!.playVideo()
    }
    
    @IBAction func btnPreviousTouchUp(sender: AnyObject) {
        if playerView?.currentTime() != 0{
            var timeCurent = Float(playerView!.currentTime())
            if timeCurent <= 5.0 {
                timeCurent = 0
            }else{
                timeCurent = timeCurent - 5.0
            }
            playerView!.seek(toSeconds: timeCurent, allowSeekAhead: true)
            self.UpdateSlider()
        }
    }
    
    @IBAction func btnNextTouchUp(sender: AnyObject) {
        if playerView?.currentTime() != 0{
            var timeCurent = Float(Int(Float(playerView!.currentTime())))
            if Float(playerView!.duration()) - timeCurent <= 5.0 {
                timeCurent = Float(Int(Float(playerView!.duration())))
            }else{
                timeCurent = timeCurent + 5.0
                
            }
            playerView!.seek(toSeconds: timeCurent, allowSeekAhead: true)
         //   meterTimer?.invalidate()
            self.UpdateSlider()
            
        }
    }
    
    func checkPlayer(){
        if playerView?.duration() != 0{
            btnPlay.isSelected = true
            check?.invalidate()
            hideLoadingHUD()
        }
    }
    //MARK: youtubeAPI Delegate
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch (state) {
        case YTPlayerState.unstarted:
            print("")
            
        break
        case YTPlayerState.playing:
            self.meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateSlider), userInfo: nil, repeats: true)
            lblDuration.text = self.formatTime(time: CGFloat(self.playerView!.duration())) as String
            
            break
        case YTPlayerState.paused:
            self.meterTimer?.invalidate()
            break
        case YTPlayerState.ended:
            refreshPlayer()
            //playerView.pauseVideo()
        default:
            break;
        }
    }
    
    func refreshPlayer(){
        meterTimer?.invalidate()
        sliderProgress.value = 0
        btnPlay.isSelected = true
        lblCurentTime.text = "00:00"
        
    }
    
    func formatTime(time:CGFloat) ->NSString{
        let hours:NSInteger = NSInteger(time) / 3600
        let seconds:NSInteger = NSInteger(time) % 60
        let minutes:NSInteger = (NSInteger(time) - NSInteger(hours) * 3600 - seconds) / 60
        return NSString(format:"%02ld:%02ld",minutes,seconds)
    }
    
    func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
