import SwiftUI

struct TicketDetailView: View {
	@State private var selectedTab: TicketTab = .Ticket
	@State private var selectedAction: TicketAction?
	@State private var ticket: TicketModel = .init(id: 1, summary: "Test")
	var ticketId: Int
	
	var body: some View {
		TabView(selection: $selectedTab, content:  {
			Form {
				Section {
					
				} header: {
					HStack(spacing: 12) {
						ForEach(TicketAction.allCases, id: \.self) { action in
							Button {
								
							} label: {
								if let icon = action.icon {
									Image(systemName: icon)
										.padding(.horizontal)
								} else {
									HStack {
										Text(action.rawValue)
										Image(systemName: "chevron.down")
									}
								}
							}
						}
						
						Spacer()
						
						Menu {
							
						} label: {
							HStack {
								Image(systemName: "gearshape")
								Image(systemName: "chevron.down")
							}
							.padding(.horizontal)
						}
						
						Image(systemName: "questionmark.circle")
							.padding(.horizontal)
						
						Image(systemName: "chevron.left")
							.padding(.horizontal)
						
						Image(systemName: "chevron.right")
							.padding(.horizontal)
					}
				}
				
				Section {
					LabeledContent {
						TextField("Summary", text: $ticket.summary)
							.textFieldStyle(.roundedBorder)
					} label: {
						Text("Summary:")
							.fontWeight(.bold)
							.foregroundStyle(.blue)
					}
				} footer: {
					HStack {
						Text("Age: 2d 18h 36m")
						
						Button("Screenconnect Session") {
							
						}
						.buttonStyle(.borderedProminent)
						.tint(.blue)
						.disabled(true)
						
						Button("Follow") {
							
						}
						.buttonStyle(.borderedProminent)
						.tint(.blue)
					}
				}
				
				Section {
					DisclosureGroup("Company Velo IT Group") {
						Grid {
							GridRow {
								LabeledInput(fieldName: "Company", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "Site", fieldBinding: .constant(""))
							}
							
							GridRow {
								LabeledInput(fieldName: "Contact", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "Address 1", fieldBinding: .constant(""))
							}
							
							GridRow {
								LabeledInput(fieldName: "Ticket", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "Address 2", fieldBinding: .constant(""))
							}
							
							GridRow {
								LabeledInput(fieldName: "Email", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "City", fieldBinding: .constant(""))
							}
						}
					}
				}
				
				Section {
					DisclosureGroup("Ticket #649814") {
						Grid {
							GridRow {
								LabeledInput(fieldName: "Board", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "SLA", fieldBinding: .constant(""))
							}
							
							GridRow {
								LabeledInput(fieldName: "Status", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "Agreement", fieldBinding: .constant(""))
							}
							
							GridRow {
								LabeledInput(fieldName: "Type", fieldBinding: .constant(""))
								
								LabeledInput(fieldName: "Predecessor", fieldBinding: .constant(""))
							}
							
							GridRow {
								LabeledInput(fieldName: "Subtype", fieldBinding: .constant(""))
								LabeledInput(fieldName: "Start Date", fieldBinding: .constant(""))
							}
						}
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			.tag(TicketTab.Ticket)
		})
		.tabViewStyle(.page(indexDisplayMode: .never))
		.toolbar(content: {
			ToolbarItemGroup(placement: .topBarLeading) {
				ScrollView(.horizontal) {
					HStack(spacing: 24) {
						ForEach(TicketTab.allCases, id: \.self) { tab in
							Button {
								selectedTab = tab
							} label: {
								Text(tab.rawValue)
									.tag(tab.rawValue)
							}
						}
					}
				}
				.scrollIndicators(.hidden)
			}
		})
		.task {
			guard let url = URL(string: "https://manage.velomethod.com/v4_6_release/apis/3.0/service/tickets/\(ticketId)") else { fatalError("Missing URL") }
			var request = URLRequest(url: url)
			request.addValue("900822ef-aa1c-4f08-aae6-f070919b56fa", forHTTPHeaderField: "clientId")
			request.addValue("Basic dmVsbytyS3F3bmg5SWpoMTZwa2k2Ok9ndnphMTNlZUVWVUExZ1M=", forHTTPHeaderField: "Authorization")
			
			request.httpMethod = "GET"
			
			do {
				let (data, response) = try await URLSession.shared.data(for: request)
				
				guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
				ticket = try JSONDecoder().decode(TicketModel.self, from: data)
			} catch {
				print(error)
			}
		}
	}
}

#Preview {
	NavigationStack {
		TicketDetailView(ticketId: 649814)
	}
}

enum TicketTab: String, CaseIterable {
	case Ticket
	case Tasks
	case Configurations
	case Products
	case Activites
	case Time
	case Expenses
	case Schedule
	case Attachments
	case OpenTickets = "Open Tickets"
	case Conversions
	case AuditTrail = "Audit Trail"
	case Surverys
	case Rma = "RMA"
	case ChangeApprovals = "Change Approvals"
}

enum TicketAction: String, CaseIterable {
	case NewItem
	case Save
	case SaveAndClose
	case Refresh
	case Print
	case Copy
	case More
	case Links
	case Share
	case NewTimeEntry
	case NewExpenseEntry
	case OpenDispatchPortal
	case PopoutTicketInNewWindow
	case History
	case Trash
	
	var icon: String? {
		switch self {
			case .NewItem:
				"plus"
			case .Save:
				"square.and.arrow.down"
			case .SaveAndClose:
				"shippingbox.and.arrow.backward"
			case .Refresh:
				"arrow.triangle.2.circlepath"
			case .Print:
				"printer"
			case .Copy:
				"doc.on.doc"
			case .More:
				nil
			case .Links:
				nil
			case .Share:
				nil
			case .NewTimeEntry:
				"clock"
			case .NewExpenseEntry:
				"dollarsign"
			case .OpenDispatchPortal:
				"shareplay"
			case .PopoutTicketInNewWindow:
				"rectangle.portrait.and.arrow.forward"
			case .History:
				nil
			case .Trash:
				"trash"
		}
	}
}
