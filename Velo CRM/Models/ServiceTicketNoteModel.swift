enum NoteType: String, CaseIterable, Codable {
	case TicketNote
	case TimeEntryNote
	case MeetingNote
}


struct ServiceTicketNoteModel: Identifiable, Codable {
	var id: Int
	var text: String
	var originalAuthor: String
	var timeStart: String
	var timeEnd: String
	var noteType: NoteType?
	var isMarkdownFlag: Bool?
	var detailDescriptionFlag: Bool?
	var internalAnalysisFlag: Bool?
	var resolutionFlag: Bool?
	var bundledFlag: Bool?
	var mergedFlag: Bool?
	var issueFlag: Bool?
//	var member: MemberModel
//	var contact: ContactModel
}

extension ServiceTicketNoteModel: Hashable {
	
}
