import SwiftUI

struct SidebarListView: View {
	@Binding var selectedTab: String?

    var body: some View {
        List {
            SidebarSectionView(label: "My Favorites") {
                ForEach(FavoriteTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Companies") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Sales") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Marketing") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Procurment") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Project") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Service Desk") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Time & Expense") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "Finance") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            SidebarSectionView(label: "System") {
                ForEach(CompanyTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
		}
    }
}

#Preview {
    NavigationSplitView(sidebar: {
        SidebarListView(selectedTab: .constant(FavoriteTab.Today.rawValue))
    }, detail: {
        
    })
}
