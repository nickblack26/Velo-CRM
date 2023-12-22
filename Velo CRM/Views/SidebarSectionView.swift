import SwiftUI

struct SidebarSectionView<Content: View>: View {
    @State private var isExpanded: Bool = false
    var label: String
    @ViewBuilder var content: Content
    
    var body: some View {
        Section(label, isExpanded: $isExpanded) {
            content
        }
    }
}

#Preview {
    SidebarSectionView(label: "My Favorites") {
        
    }
}
