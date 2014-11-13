//
//  ViewController.swift
//  JingFM-RoundEffect-Swift
//
//  Created by isaced on 14-6-11.
//  Copyright (c) 2014 Year isaced. All rights reserved.
//

import UIKit

class ViewController: UIViewController,JingRoundViewDelegate {
                            
    @IBOutlet var roundView : JingRoundView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg"))
        self.roundView.roundImage = UIImage(named: "girl")
        self.roundView.isPlay = false;
        self.roundView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playStatuUpdate(playState: Bool) {
        NSLog("%@...", playState ? "Playing": "Pause")
    }


}

