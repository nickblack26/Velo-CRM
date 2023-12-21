import SwiftUI

struct ContentView: View {
	@State private var selectedTab: SidebarTab? = .myFavorites
	@State private var columnVisibility: NavigationSplitViewVisibility = .all
	
    var body: some View {
		NavigationSplitView(
			columnVisibility: $columnVisibility,
			preferredCompactColumn: .constant(.sidebar)
		) {
			SidebarListView(selectedTab: $selectedTab)
		} content: {
			ContentListView(
				selectedTab: $selectedTab,
				columnVisibility: $columnVisibility
			)
		} detail: {
			NavigationStack {
				ZStack {
					switch selectedTab {
						case .companies:
							CompanyTable()
						case nil:
							EmptyView()
						default:
							EmptyView()
					}
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

enum SidebarTab: String, CaseIterable {
	case myFavorites = "My Favorites"
	case companies = "Companies"
	case sales = "Sales"
	case marketing = "Marketing"
	case procurement = "Procurement"
	case project = "Project"
	case serviceDesk = "Service Desk"
	case timeAndExpense = "Time & Expense"
	case finance = "Finance"
	case system = "System"
	
	var icon: String {
		switch self {
			case .myFavorites:
				"star"
			case .companies:
				"building.2"
			case .sales:
				"chart.bar.xaxis.ascending"
			case .marketing:
				"target"
			case .procurement:
				"cart"
			case .project:
				"chart.dots.scatter"
			case .serviceDesk:
				"headphones"
			case .timeAndExpense:
				"clock.badge"
			case .finance:
				"plus.forwardslash.minus"
			case .system:
				"gearshape"
		}
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
