import SwiftUI

struct SidebarListView: View {
	@Binding var selectedTab: SidebarTab?

    var body: some View {
		List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
			Label(tab.rawValue, systemImage: tab.icon)
		}
    }
}

#Preview {
	SidebarListView(selectedTab: .constant(.myFavorites))
}
