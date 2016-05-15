//
//  ViewController.swift
//  WorkH
//
//  Created by Zel Marko on 5/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var totalTimeTodayLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var startPauseButton: UIButton!
	
	var timer: NSTimer!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		Timekeeper.sharedInstance.delegate = self
		RealmHandler.sharedInstance.fetchTodaysSessions()
	}

	@IBAction func startPauseTapped(sender: AnyObject) {
		if Timekeeper.sharedInstance.active {
			Timekeeper.sharedInstance.stopTimer()
			startPauseButton.setTitle("Stop", forState: .Normal)
		} else {
			Timekeeper.sharedInstance.startTimer()
			startPauseButton.setTitle("Start", forState: .Normal)
		}
	}
	
}

extension ViewController: TimekeeperDelegate {
	func updateTimeLabel(text: String) {
		timeLabel.text = text
	}
	
	func updateTotalTimeLabel(text: String) {
		totalTimeTodayLabel.text = text
	}
}

