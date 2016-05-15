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
	func updateTotalTimeLabel(text: String)
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
		
		if startDate == nil {
			startDate = NSDate()
			
			RealmHandler.sharedInstance.newSession(startDate)
		}
	}
	
	func stopTimer() {
		let endDate = NSDate()
		startDate = nil
		
		timer.invalidate()
		timer = nil
		
		if let delegate = delegate {
			delegate.updateTimeLabel("00:00:00")
		}
		
		RealmHandler.sharedInstance.updateSession(endDate)
	}
	
	@objc func calculateElapsedTime() {
		let elapsedTime = -startDate.timeIntervalSinceNow
		
		if let delegate = delegate {
			delegate.updateTimeLabel(transformElapsedTime(elapsedTime))
		}
	}
	
	func calculateTotalTime(sessions: [Session]) {
		var totalElapsedTime: NSTimeInterval = 0.0
		
		for session in sessions {
			totalElapsedTime += -session.startDate.timeIntervalSinceDate(session.endDate!)
		}
		
		if let delegate = delegate {
			delegate.updateTotalTimeLabel(transformElapsedTime(totalElapsedTime))
		}
	}
	
	func transformElapsedTime(elapsedTime: NSTimeInterval) -> String {
		return String(format: "%0.2d:%0.2d:%0.2d", Int(elapsedTime / 3600), Int(elapsedTime / 60), Int(round(elapsedTime % 60)))
	}
}
