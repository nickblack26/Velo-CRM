import SwiftUI

struct StatusItemView: View {
    var body: some View {
		HStack(alignment: .top) {
			VStack(alignment: .center) {
					Image(systemName: "arrow.up.right")
						.imageScale(.small)
						.frame(maxWidth: 20, maxHeight: 20)
						.foregroundStyle(.white)
						.padding(8)
						.background(.blue, in: Circle())
					
				Capsule()
					.fill(Color(uiColor: .systemGray6))
					.frame(minHeight: 50)
					.frame(width: 4)
			}
			
			VStack(alignment: .leading) {
				Text("Sales status updated")
					.fontWeight(.medium)
				
				Text("From Requirement closed • by OPS team")
					.font(.caption)
					.fontWeight(.medium)
					.foregroundStyle(.secondary)
			}
		}
		.frame(minHeight: 50, maxHeight: 250)
    }
}

#Preview {
    StatusItemView()
}
