import SwiftUI

struct MetricCardView<Content: View, Subtitle: View>: View {
	var title: String
	var content: () -> Content
	var subtitle: () -> Subtitle
	
	init(
		_ title: String,
		content: @escaping () -> Content,
		subtitle: @escaping () -> Subtitle
	) {
		self.title = title
		self.content = content
		self.subtitle = subtitle
	}
	
    var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text(title)
				.font(.callout)
				.fontWeight(.bold)
				.foregroundStyle(.secondary)
			
			HStack(content: content)
				.font(.title2)
				.fontWeight(.bold)
			
			HStack(content: subtitle)
				.foregroundStyle(.secondary)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(.clear)
				.strokeBorder(style: .init(lineWidth: 1))
		}
    }
}

#Preview {
	MetricCardView("Primary Contact") {
		HStack {
			Image(systemName: "person.text.rectangle")
			Text("Jessica McKey")
		}
	} subtitle: {
		Text("Assistant Controller")
			.foregroundStyle(.secondary)
	}
}
