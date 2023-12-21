import Foundation

// MARK: - Contact
struct Contact: Codable, Identifiable {
	let id: Int
	var firstName, lastName: String
	var company: Company?
	var site: CompanyLocation?
	var inactiveFlag: Bool?
	var title: String?
	var marriedFlag, childrenFlag: Bool?
	var portalSecurityLevel: Int?
	var disablePortalLoginFlag, unsubscribeFlag: Bool?
	var mobileGUID, defaultPhoneType, defaultPhoneNbr: String?
	var defaultBillingFlag, defaultFlag: Bool?
	var companyLocation: CompanyLocation?
	var communicationItems: [CommunicationItem]?
	var customFields: [CustomField]?
	var ignoreDuplicates: Bool?
	
	enum CodingKeys: String, CodingKey {
		case id, firstName, lastName, company, site, inactiveFlag, title, marriedFlag, childrenFlag, portalSecurityLevel, disablePortalLoginFlag, unsubscribeFlag
		case mobileGUID = "mobileGuid"
		case defaultPhoneType, defaultPhoneNbr, defaultBillingFlag, defaultFlag, companyLocation, communicationItems, customFields, ignoreDuplicates
	}
}

// MARK: - CommunicationItem
struct CommunicationItem: Codable {
	let id: Int
	var type: CompanyLocation
	var value: String
	var defaultFlag: Bool
	var domain: String?
	var communicationType: String
}

// MARK: - CompanyLocation
struct CompanyLocation: Codable {
	let id: Int
	var name: String
}

// MARK: - Company
struct Company: Codable {
	let id: Int
	var identifier, name: String
}

// MARK: - CustomField
struct CustomField: Codable {
	let id: Int
	var caption, type, entryMethod: String
	var numberOfDecimals: Int
	var value: String
}

struct UserType: Codable {
	let id: Int
	var name: String
}
