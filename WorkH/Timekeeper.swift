//
//  Timekeeper.swift
//  WorkH
//
//  Created by Zel Marko on 5/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

protocol TimekeeperDelegate {
	func updateTimeLabel(text: String)
}

class Timekeeper {
	
	static let sharedInstance = Timekeeper()
	
	var delegate: TimekeeperDelegate?
	var timer: NSTimer!
	var startDate: NSDate!
	var active: Bool {
		return timer == nil ? false : true
	}
	
	func startTimer() {
		timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(calculateElapsedTime), userInfo: nil, repeats: true)
		startDate = NSDate()
		
	}
	
	func stopTimer() {
		timer.invalidate()
		timer = nil
	}
	
	@objc func calculateElapsedTime() {
		let elapsedTime = -startDate.timeIntervalSinceNow
		
		if let delegate = delegate {
			delegate.updateTimeLabel(String(format: "%0.2d:%0.2d:%0.2d", Int(elapsedTime / 3600), Int(elapsedTime / 60), Int(round(elapsedTime % 60))))
		}
	}
}
