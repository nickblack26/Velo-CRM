enum RecordType: String, CaseIterable, Codable {
	case ProjectIssue
	case ProjectTicket
	case ServiceTicket
}

struct TicketModel: Identifiable, Codable, Equatable {
	var id: Int
	var summary: String
	var recordType: RecordType?
}
