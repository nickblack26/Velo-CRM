import SwiftUI

struct RoundedCardView<Content: View>: View {
	@ViewBuilder var content: Content
	
    var body: some View {
        content
			.padding(40)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			.background {
				RoundedRectangle(cornerRadius: 16)
					.fill(.clear)
					.strokeBorder(.secondary, style: .init(lineWidth: 1))
			}
    }
}

#Preview {
	RoundedCardView {
		HStack {
			Image(systemName: "building.2")
				.imageScale(.large)
				.padding(8)
				.background(.secondary)
				.clipShape(RoundedRectangle(cornerRadius: 8))
			
			Text("Hello")
		}
	}
	.padding()
}
