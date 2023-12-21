import SwiftUI

struct CompanyTable: View {
	@State private var companies: [CompanyModel] = []
	
    var body: some View {
		Table(companies) {
			TableColumn("Company Name") { company in
				NavigationLink(company.name, value: company)
			}
			
			TableColumn("Company ID") { company in
				NavigationLink(company.identifier, value: company)
			}
			
			TableColumn("Phone Number") { company in
				NavigationLink(company.phoneNumber ?? "", value: company)
			}
		}
		.navigationTitle("Companies")
//		.searchable(text: $searchText)
		.toolbar {
			ToolbarItemGroup(placement: .topBarLeading) {
				Button {} label: {
					Image(systemName: "plus")
				}
				
				Button {} label: {
					Image(systemName: "shareplay")
				}
				
				Button {} label: {
					Image(systemName: "printer")
				}
				
				Menu {
					Button("Delete Ticket") {}
					Button("Move To Another Board") {}
					Button("Update Status") {}
					Button("Update Ticket Type") {}
					Button("Update Service Team") {}
					Button("Update Location") {}
					Button("Update Source") {}
					Button("Update Priority") {}
					Button("Update Billing Information") {}
					Button("Update Shipping Information") {}
					Button("Send to Communications Manager") {}
					Button("Add Resource/Owner to Ticket") {}
					Button("Add Cc To Ticket") {}
					Button("Follow") {}
					Button("Unfollow") {}
					Button("Bundle") {}
					Button("Set Predecessor") {}
					Button("Clear Predecessor") {}
					Button("Adjust Schedule") {}
					Button("Add Ticket Notes") {}
					Button("Update Custom Field") {}
				} label: {
					HStack {
						Text("Actions")
						Image(systemName: "chevron.down")
					}
				}
				
				Button {} label: {
					Text("Search")
				}
				
				Button {} label: {
					Text("Clear")
				}
			}
		}
		.task {
			guard let url = URL(string: "https://manage.velomethod.com/v4_6_release/apis/3.0/company/companies?conditions=status%2Fid%3D1&orderBy=name&pageSize=500") else { fatalError("Missing URL") }
			var request = URLRequest(url: url)
			request.addValue("900822ef-aa1c-4f08-aae6-f070919b56fa", forHTTPHeaderField: "clientId")
			request.addValue("Basic dmVsbytyS3F3bmg5SWpoMTZwa2k2Ok9ndnphMTNlZUVWVUExZ1M=", forHTTPHeaderField: "Authorization")
			
			request.httpMethod = "GET"
			
			do {
				let (data, response) = try await URLSession.shared.data(for: request)
				
				guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
				companies = try JSONDecoder().decode([CompanyModel].self, from: data)
			} catch {
				print(error)
			}
		}
    }
}

#Preview {
	NavigationStack {
		CompanyTable()		
	}
}
