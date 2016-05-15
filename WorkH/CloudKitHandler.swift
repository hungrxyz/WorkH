//
//  CloudKitHandler.swift
//  WorkH
//
//  Created by Zel Marko on 5/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import CloudKit


class CKHandler {
	
	static let sharedInstance = CKHandler()
	
	let privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
	
	func newSession(session: Session) {
		let recordID = CKRecordID(recordName: session.uuid)
		let record = CKRecord(recordType: "Session", recordID: recordID)
		
		record["startDate"] = session.startDate
		
		saveRecord(record)
	}
	
	func updateSession(session: Session) {
		privateDatabase.fetchRecordWithID(CKRecordID(recordName: session.uuid)) { record, error in
			if let error = error {
				print(error)
			} else if let record = record {
				dispatch_async(dispatch_get_main_queue(), { 
					record["endDate"] = session.endDate
					
					self.saveRecord(record)
				})
			}
		}
	}
	
	func saveRecord(record: CKRecord) {
		privateDatabase.saveRecord(record) { record, error in
			if let error = error {
				print(error)
			} else if let record = record {
				print("Record saved: " + record.recordID.recordName)
			}
		}
	}
}
