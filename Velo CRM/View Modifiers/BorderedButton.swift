import SwiftUI

struct BorderedButton: ViewModifier {
	func body(content: Content) -> some View {
		content
			.buttonStyle(.bordered)
			.tint(.clear)
			.foregroundStyle(.secondary)
			.overlay(
				Circle()
					.strokeBorder(
						.secondary,
						style: StrokeStyle(lineWidth: 1)
					)
			)
			.clipShape(Circle())
	}
}

extension Button {
	func borderedButton() -> some View {
		modifier(BorderedButton())
	}
}
