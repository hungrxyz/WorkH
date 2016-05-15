//
//  Session.swift
//  WorkH
//
//  Created by Zel Marko on 5/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import RealmSwift

class Session: Object {
	dynamic var uuid: String = NSUUID().UUIDString
	dynamic var startDate: NSDate!
	dynamic var endDate: NSDate?
	
	override static func primaryKey() -> String? {
		return "uuid"
	}
}
