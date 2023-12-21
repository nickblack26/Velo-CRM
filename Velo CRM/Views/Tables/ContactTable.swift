//
//  ContactTable.swift
//  Velo CRM
//
//  Created by Nick Black on 12/20/23.
//

import SwiftUI

struct ContactTable: View {
	var contacts: [Contact]
	
	init(_ contacts: [Contact]) {
		self.contacts = contacts
	}
	
    var body: some View {
		Table(contacts) {
			TableColumn("Name") { contact in
				Text("\(contact.firstName) \(contact.lastName)")
			}
			
			TableColumn("Email") { contact in
				if let contact = contact.communicationItems?.first(where: { $0.type.id == 1 }) {
					Text(contact.value)
				} else {
					Text("")
				}
			}
			
			TableColumn("Title") { contact in
				Text(contact.title ?? "")
			}
			
			TableColumn("") { _ in
				Button {} label: {
					Image(systemName: "ellipsis")
				}
			}
		}
    }
}

#Preview {
	ContactTable(
		[
			.init(
				id: 10,
				firstName: "Aaron",
				lastName: "Fox",
				company: .init(
					id: 11,
					identifier: "",
					name: ""
				),
				site: .init(
					id: 12,
					name: ""
				),
				inactiveFlag: false,
				title: "", 
				marriedFlag: false,
				childrenFlag: false,
				portalSecurityLevel: 1,
				disablePortalLoginFlag: false,
				unsubscribeFlag: false,
				mobileGUID: "",
				defaultPhoneType: "",
				defaultPhoneNbr: "",
				defaultBillingFlag: false,
				defaultFlag: false,
				companyLocation: .init(
					id: 13,
					name: ""
				),
				communicationItems: [
					.init(
						id: 14,
						type: .init(
							id: 1,
							name: ""
						),
						value: "nblack@velomethod.com",
						defaultFlag: false,
						communicationType: "email"
					)
				],
				customFields: [],
				ignoreDuplicates: false
			)
		]
	)
}
