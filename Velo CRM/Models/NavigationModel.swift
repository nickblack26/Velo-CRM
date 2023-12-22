import Foundation

enum TestSection: Hashable {
    case myFavorites(FavoriteTab)
    case companies(CompanyTab)
}

enum SidebarSection: String, CaseIterable {
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
    
    var tabs: [String] {
        switch self {
        case .myFavorites:
            return FavoriteTab.allCases.map { $0.rawValue }
        case .companies:
            return CompanyTab.allCases.map { $0.rawValue }
        case .sales:
            return []
        case .marketing:
            return []
        case .procurement:
            return []
        case .project:
            return []
        case .serviceDesk:
            return []
        case .timeAndExpense:
            return []
        case .finance:
            return []
        case .system:
            return []
        }
    }
}

enum FavoriteTab: String, CaseIterable {
    case Today
    case MyCalendar = "My Calendar"
}

enum CompanyTab: String, CaseIterable {
    case Companies
    case Contacts
    case Configurations
    case CompanyActivityExceptions = "Company Activity Exceptions"
    case CompanyReports = "Company Reports"
    case Pax8
}
