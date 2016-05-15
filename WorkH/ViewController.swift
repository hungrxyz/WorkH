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
		
		setButtonImage()
		
		Timekeeper.sharedInstance.delegate = self
		RealmHandler.sharedInstance.fetchTodaysSessions()
	}

	@IBAction func startPauseTapped(sender: AnyObject) {
		if Timekeeper.sharedInstance.active {
			Timekeeper.sharedInstance.stopTimer()
			setButtonImage()
		} else {
			Timekeeper.sharedInstance.startTimer()
			setButtonImage()
		}
	}
	
	func setButtonImage() {
		if Timekeeper.sharedInstance.active {
			startPauseButton.setImage(UIImage(named: "stop_button"), forState: .Normal)
		} else {
			startPauseButton.setImage(UIImage(named: "start_button"), forState: .Normal)
		}
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
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

