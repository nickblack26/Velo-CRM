import SwiftUI

struct CompanyDetailView: View {
	@State private var selectedTab: CompanyDetailTab = .Overview
	@State private var fullCompany: CompanyModel?
	@State private var tickets: [TicketModel] = []
	var company: CompanyModel
	
    var body: some View {
		Grid(horizontalSpacing: 24, verticalSpacing: 24) {
			GridRow {
				RoundedCardView {
					HStack {
						Image(systemName: "building.2.fill")
							.imageScale(.large)
							.padding(8)
							.background(Color(uiColor: .systemGray4))
							.clipShape(RoundedRectangle(cornerRadius: 8))
						
						Text(company.name)
							.font(.largeTitle)
							.fontWeight(.semibold)
					}
				}
				
				VStack {
					RoundedCardView {
						HStack(alignment: .top) {
							VStack(alignment: .leading) {
								Text("Customers")
									.font(.title2)
									.fontWeight(.semibold)
								
								Text("These people can request help in your project. Select a customer to manage their details.")
									.fontWeight(.medium)
									.foregroundStyle(.secondary)
							}
						}
					}
					
					RoundedCardView {
						HStack(alignment: .top) {
							VStack(alignment: .leading) {
								Text("Requests")
									.font(.title2)
									.fontWeight(.semibold)
								
								Text("All the requests opened by customers in this organization for this project.")
									.fontWeight(.medium)
									.foregroundStyle(.secondary)
							}
						}
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				.gridCellColumns(2)
//				HStack {
//					ForEach(CompanyDetailTab.allCases, id: \.self) { tab in
//						Button(tab.rawValue) {
//							withAnimation(.snappy) {
//								selectedTab = tab								
//							}
//						}
//						.tint(tab == selectedTab ? .accentColor : .secondary)
//						.padding(tab == .Overview ? .trailing : .horizontal)
//					}
//				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding()
		.toolbar {
			ToolbarItemGroup(placement: .topBarLeading) {
				Text("Company Search")
					.foregroundStyle(.secondary)
				
				Image(systemName: "chevron.right")
					.imageScale(.small)
				
				Text("Company")
					.foregroundStyle(.secondary)
			}
		}
		.task {
			guard let url = URL(string: "https://manage.velomethod.com/v4_6_release/apis/3.0/service/tickets/\(company.id)") else { fatalError("Missing URL") }
			var request = URLRequest(url: url)
			request.addValue("900822ef-aa1c-4f08-aae6-f070919b56fa", forHTTPHeaderField: "clientId")
			request.addValue("Basic dmVsbytyS3F3bmg5SWpoMTZwa2k2Ok9ndnphMTNlZUVWVUExZ1M=", forHTTPHeaderField: "Authorization")
			
			request.httpMethod = "GET"
			
			do {
				let (data, response) = try await URLSession.shared.data(for: request)
				
				guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
				fullCompany = try JSONDecoder().decode(CompanyModel.self, from: data)
			} catch {
				print(error)
			}
		}
    }
}

#Preview {
	NavigationStack {
		CompanyDetailView(company: .init(id: 25929, identifier: "ABCO", name: "Acadiana Bottling Co., Inc."))
	}
}

enum CompanyDetailTab: String, CaseIterable {
	case Overview
	case Servers
	case Applications
	case Projects
	case Attachments
}
