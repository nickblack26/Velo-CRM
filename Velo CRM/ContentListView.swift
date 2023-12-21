//
//  ContentListView.swift
//  Velo CRM
//
//  Created by Nick Black on 11/17/23.
//

import SwiftUI

struct ContentListView: View {
	@Binding var selectedTab: SidebarTab?
	@Binding var columnVisibility: NavigationSplitViewVisibility
	
    var body: some View {
		switch selectedTab {
			case .myFavorites:
				List {
					Text("Today")
					Text("My Calendar")
				}
				.navigationTitle("My Favorites")
				.navigationBarTitleDisplayMode(.inline)
				.listStyle(.insetGrouped)
			case .companies:
				List {
					Text("Companies")
					Text("Contacts")
					Text("Configurations")
					Text("Company Activity Exceptions")
					Text("Company Reports")
					Text("Pax8")
				}
				.navigationTitle("Companies")
				.listStyle(.insetGrouped)
				.onAppear(perform: {
					columnVisibility = .doubleColumn
				})
			case .sales:
				List {
					Text("My Opportunities")
					Text("My List")
					Text("My Calendar")
					Text("Sales Overview")
					Text("My Sales Overview")
					Text("Sales Funnel")
					Text("Sales Orders")
					Text("Sell")
					Text("Sales Reports")
				}
				.listStyle(.insetGrouped)
			case .marketing:
				List {
					Text("Groups")
					Text("Communications Manager")
					Text("Marketing Campaign")
					Text("ConnectWise Campaign")
				}
				.listStyle(.insetGrouped)
			case .procurement:
				EmptyView()
			case .project:
				EmptyView()
			case .serviceDesk:
				EmptyView()
			case .timeAndExpense:
				EmptyView()
			case .finance:
				EmptyView()
			case .system:
				EmptyView()
			case nil:
				EmptyView()
		}
    }
}

#Preview {
	ContentListView(
		selectedTab: .constant(.companies),
		columnVisibility: .constant(.doubleColumn)
	)
}
