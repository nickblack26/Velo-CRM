struct CompanyModel: Identifiable, Codable {
	var id: Int
	var identifier: String
	var name: String
	var addressLine1: String?
	var addressLine2: String?
	var city: String?
	var state: String?
	var zip: String?
	var phoneNumber: String?
	var faxNumber: String?
	var website: String?
	var territory: SystemLocationModel?
	var accountNumber: String?
}

extension CompanyModel: Hashable {
	static func == (lhs: CompanyModel, rhs: CompanyModel) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
