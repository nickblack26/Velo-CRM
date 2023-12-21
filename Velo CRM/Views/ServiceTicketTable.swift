import SwiftUI

struct ServiceTicketModelTable: View {
	@State private var tickets: [TicketModel] = []
	@State private var selectedTicketModels = Set<TicketModel.ID>()
	@State private var sortOrder = [KeyPathComparator(\TicketModel.id)]
	@State private var searchText: String = ""
	@State private var isOn: Bool = false
	@SceneStorage("TicketModelTableConfig")
	private var columnCustomization: TableColumnCustomization<TicketModel>
		
    var body: some View {
		Table(of: TicketModel.self, columnCustomization: $columnCustomization) {
			TableColumn("Ticket #") { ticket in
				let contains = selectedTicketModels.contains(ticket.id)
				Toggle(isOn: Binding<Bool>(
					get: {
						return contains
					},
					set: { checked in
						if checked {
							selectedTicketModels.insert(ticket.id)
						} else {
							selectedTicketModels.remove(ticket.id)
						}
					})) {
						Text(verbatim: "\(ticket.id)")
					}
					.toggleStyle(iOSCheckboxToggleStyle())
			}
			.customizationID("ticket")
			
//			TableColumn("Priority") { ticket in
//				Text(verbatim: ticket.priority?.name ?? .placeholder(length: 30))
//			}
//			
//			TableColumn("Age") { ticket in
//				Text(ticket.Info?.dateEntered ?? "")
//			}
//			
//			TableColumn("Status") { ticket in
//				Text(ticket.status?.name ?? "")
//			}
//			
//			TableColumn("Company") { ticket in
//				Text(ticket.company?.name ?? "")
//			}
//			
			TableColumn("Summary Description", value: \.summary)
//			TableColumn("Contact") { ticket in
//				Text(ticket.contactName ?? "")
////					.background
//			}
		} rows: {
			ForEach(tickets) { ticket in
				TableRow(ticket)
			}
		}
//		.navigationTitle("Service Board \(selectedTicketModels.count > 0 ? "- \(selectedTicketModels.count)" : "")")
		.searchable(text: $searchText)
//		.toolbar {
//			ToolbarItemGroup(placement: .topBarLeading) {
//				Button {} label: {
//					Image(systemName: "plus")
//				}
//				
//				Button {} label: {
//					Image(systemName: "shareplay")
//				}
//				
//				Button {} label: {
//					Image(systemName: "printer")
//				}
//				
//				Menu {
//					Button("Delete TicketModel") {}
//					Button("Move To Another Board") {}
//					Button("Update Status") {}
//					Button("Update TicketModel Type") {}
//					Button("Update Service Team") {}
//					Button("Update Location") {}
//					Button("Update Source") {}
//					Button("Update Priority") {}
//					Button("Update Billing Information") {}
//					Button("Update Shipping Information") {}
//					Button("Send to Communications Manager") {}
//					Button("Add Resource/Owner to TicketModel") {}
//					Button("Add Cc To TicketModel") {}
//					Button("Follow") {}
//					Button("Unfollow") {}
//					Button("Bundle") {}
//					Button("Set Predecessor") {}
//					Button("Clear Predecessor") {}
//					Button("Adjust Schedule") {}
//					Button("Add TicketModel Notes") {}
//					Button("Update Custom Field") {}
//				} label: {
//					HStack {
//						Text("Actions")
//						Image(systemName: "chevron.down")
//					}
//				}
//				
//				Button {} label: {
//					Text("Search")
//				}
//				
//				Button {} label: {
//					Text("Clear")
//				}
//			}
//		}
		.task {
			guard let url = URL(string: "https://manage.velomethod.com/v4_6_release/apis/3.0/service/tickets") else { fatalError("Missing URL") }
			var request = URLRequest(url: url)
			request.addValue("900822ef-aa1c-4f08-aae6-f070919b56fa", forHTTPHeaderField: "clientId")
			request.addValue("Basic dmVsbytyS3F3bmg5SWpoMTZwa2k2Ok9ndnphMTNlZUVWVUExZ1M=", forHTTPHeaderField: "Authorization")
			
			request.httpMethod = "GET"
			
			do {
				let (data, response) = try await URLSession.shared.data(for: request)
				
				guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
				tickets = try JSONDecoder().decode([TicketModel].self, from: data)
			} catch {
				print(error)
			}
		}
    }
}

#Preview {
    NavigationStack {
    	ServiceTicketModelTable()
			.toolbar {
				
			}
    }
}
