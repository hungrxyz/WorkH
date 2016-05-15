//
//  RealmHandler.swift
//  WorkH
//
//  Created by Zel Marko on 5/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHandler {
	
	static let sharedInstance = RealmHandler()
	
	let realm = try! Realm()
	
	var activeSession: Session?
	
	func newSession(startDate: NSDate) {
		let session = Session()
		session.startDate = startDate
		
		activeSession = session
		
		do {
			try realm.write {
				realm.add(session)
			}
		} catch {
			print(error)
		}
	}
	
	func updateSession(endDate: NSDate) {
		if let activeSession = activeSession {
			do {
				try realm.write {
					activeSession.endDate = endDate
					realm.add(activeSession, update: true)
				}
			} catch {
				print(error)
			}
		}
	}
	
	func checkForActiveSession() {
		let sessions = realm.objects(Session.self).filter("endDate == nil")
		if let session = sessions.first {
			activeSession = session
			
			Timekeeper.sharedInstance.startDate = session.startDate
			Timekeeper.sharedInstance.startTimer()
		}
	}
	
	
}
