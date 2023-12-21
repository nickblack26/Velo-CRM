struct BoardModel: Identifiable, Codable {
	var id: Int
	var name: String
	var location: SystemLocationModel?
	var department: DepartmentModel?
}
