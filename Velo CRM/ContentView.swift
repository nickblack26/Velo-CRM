import SwiftUI

struct ContentView: View {
	@State private var selectedTab: String? = "Today"
	@State private var columnVisibility: NavigationSplitViewVisibility = .all
	
    var body: some View {
		NavigationSplitView(
			columnVisibility: $columnVisibility,
			preferredCompactColumn: .constant(.sidebar)
		) {
			SidebarListView(selectedTab: $selectedTab)
		} detail: {
			NavigationStack {
				ZStack {
//					switch selectedTab {
//						case .companies:
//							CompanyTable()
//						case nil:
//							EmptyView()
//						default:
//							EmptyView()
//					}
				}
				.navigationDestination(for: CompanyModel.self) { company in
					CompanyDetailView(company: company)
						.onAppear(perform: {
							columnVisibility = .detailOnly
						})
				}
			}
			
		}
    }
}

#Preview {
    RootView {
    	ContentView()
    }
}

extension View {
	@ViewBuilder
	func redacted(if condition: @autoclosure () -> Bool) -> some View {
		redacted(reason: condition() ? .placeholder : [])
	}
}

extension String {
	static func placeholder(length: Int) -> String {
		String(Array(repeating: "X", count: length))
	}
}
