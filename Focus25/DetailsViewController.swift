//
//  DetailsViewController.swift
//  Focus25
//
//  Created by Agustiadi on 1/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit
import AVFoundation


class DetailsViewController: UIViewController {
    
    var imageSelected = String()
    var imageNameSelected = String()
    var soundSelected = String()

    var timer = NSTimer()
    
    var counter = 1500
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    let timerLabelText = UILabel()
    
    let playButton = UIButton()
    
    let stopButton = UIButton()
    
    let replayButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        imageView.image = UIImage(named: imageSelected)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        let timerLabel = UILabel()
        timerLabel.frame = CGRectMake(50, 0, self.view.frame.width-100, 200)
        timerLabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        timerLabel.backgroundColor = UIColor.blackColor()
        
        timerLabel.textColor = UIColor.whiteColor()
        timerLabel.alpha = 0.5
        
        
        timerLabelText.frame = CGRectMake(imageView.frame.width/2 - 50, imageView.frame.height/2 - 40, 100, 40)
        timerLabelText.textColor = UIColor.whiteColor()
        timerLabelText.text = "25:00"
        timerLabelText.textAlignment = NSTextAlignment.Center
        timerLabelText.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        
        let stopImage = UIImage(named: "stop.png")
        stopButton.frame = CGRectMake(imageView.frame.width/3 - 10, imageView.frame.height/2 + 30, 30, 30)
        stopButton.setImage(stopImage, forState: UIControlState.Normal)
        stopButton.addTarget(self, action: "stopBtnTouched:", forControlEvents: .TouchUpInside)
        
        let playImage = UIImage(named: "play.png")
        playButton.frame = CGRectMake(imageView.frame.width/2 - 15, imageView.frame.height/2 + 30, 30, 30)
        playButton.setImage(playImage, forState: UIControlState.Normal)
        playButton.addTarget(self, action: "playBtnTouched:", forControlEvents: .TouchUpInside)
        
        let replayImage = UIImage(named: "replay.png")
        replayButton.frame = CGRectMake(imageView.frame.width/2 + 40, imageView.frame.height/2 + 30, 30, 30)
        replayButton.setImage(replayImage, forState: UIControlState.Normal)
        replayButton.addTarget(self, action: "replayBtnTouched:", forControlEvents: .TouchUpInside)
        
        
        view.addSubview(imageView)
        view.addSubview(timerLabel)
        view.addSubview(timerLabelText)
        view.addSubview(stopButton)
        view.addSubview(playButton)
        view.addSubview(replayButton)
        
        
        let fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(soundSelected, ofType: "mp3")!)
        
        var error : NSError? = nil
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)

        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation), error: &error)
        player.numberOfLoops = -1
        
        
    }
    
    func playBtnTouched(sender: UIButton!) {
        
        player.play()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
        
    }
    
    func stopBtnTouched(sender: UIButton!) {
        
        player.pause()
        timer.invalidate()
        
        
    }
    
    func replayBtnTouched(sender: UIButton!){
        
        player.stop()
        player.currentTime = 0
        timerLabelText.text = "25:00"
        counter = 1500
        timer.invalidate()
        
    }
    
    func result(){

        if counter == 0 {
            player.stop()
            counter = 1500
            timerLabelText.text = "25:00"
            
        } else {
            
            counter--
            timerLabelText.text = timeConverter(counter)
        }
        
    }
    
    
    func timeConverter(input: Int) -> String {
        
        let min: Int = input / 60
        let sec: Int = input - (min * 60)
        var timeString = String()
        
        if sec < 10 {
            
            timeString = "\(min):0\(sec)"
            
        } else if min < 0 {
            
            timeString = "0\(min):\(sec)"
            
        } else if min < 0 && sec < 0 {
            
            timeString = "0\(min):0\(sec)"
            
        } else {
            
            timeString = "\(min):\(sec)"
        }
        
        return timeString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        player.stop()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
