import SwiftUI

let contacts: [Contact] = [
	.init(id: 2201, firstName: "Taylor", lastName: "Toce"),
	.init(id: 2204, firstName: "Ruthie", lastName: "Toce"),
	.init(id: 2206, firstName: "Ryan", lastName: "Earles"),
	.init(id: 2218, firstName: "Kohl", lastName: "Dyer"),
	.init(id: 2209, firstName: "Dana", lastName: "Duckworth"),
	.init(id: 2234 , firstName: "Julia", lastName: "Towry"),
]

struct CallDirectory: View {
	@State private var searchText: String = ""
	
	var results: [Contact] {
		if searchText.isEmpty {
			return contacts
		} else {
			return contacts.filter { $0.firstName.localizedStandardContains(searchText) || $0.lastName.localizedStandardContains(searchText) }
		}
	}
	
    var body: some View {
		Grid(verticalSpacing: 16) {
			GridRow {
				TextField("Search", text: $searchText, prompt: Text("Search"))
					.textFieldStyle(.roundedBorder)
			}
			
			GridRow {
				ScrollView(.vertical, showsIndicators: false) {
					LazyVStack(spacing: 0) {
						ForEach(results) { result in
							CallDirectoryListItem(name: "\(result.firstName) \(result.lastName)")
						}
					}
				}
			}
		}
		.frame(maxHeight: 800)
		.padding()
    }
}

#Preview {
    CallDirectory()
}
