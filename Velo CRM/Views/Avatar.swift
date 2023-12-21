import SwiftUI

let tempUrl = "https://s3.us-east-1.amazonaws.com/asana-user-private-us-east-1/assets/1201967348541907/profile_photos/1203922574287441/682a20e8db34c907fd6cb692410409c0_128x128.png"

enum AvatarSize {
	case tiny
	case small
	case medium
	case large
	case xlarge
	case xmega
	
	var sizing: CGFloat {
		switch self {
			case .tiny: return 15
			case .small: return 32
			case .medium: return 38
			case .large: return 48
			case .xlarge: return 64
			case .xmega: return 213
		}
	}
	
	var text: Font {
		switch self {
			case .tiny: return .caption
			case .small: return .callout
			case .medium: return .body
			case .large: return .title2
			case .xlarge: return .title
			case .xmega: return .largeTitle
		}
	}
}

enum AvatarStyle {
	case image
	case imageWithText
}

struct Avatar: View {
	let image: String?
	let fallback: String?
	let size: AvatarSize
	
	init(image: String?, fallback: String, size: AvatarSize) {
		self.image = image
		self.fallback = fallback
		self.size = size
	}
	
	var body: some View {
		AsyncImage(url: URL(string: image ?? "")) { Image in
			Image
				.resizable()
				.frame(width: size.sizing, height: size.sizing)
				.scaledToFill()
				.clipShape(Circle())
		} placeholder: {
			if let fallback = fallback {
				let _ = fallback.components(separatedBy: " ")
				
				Text("NB")
					.textCase(.uppercase)
					.frame(width: size.sizing, height: size.sizing)
					.background(.blue)
					.clipShape(Circle())
//				HStack(spacing: 0) {
//					if components.isIndexValid(index: 0) {
//						Text(components[0].prefix(1))
//							.font(size.text)
//						
//					}
//					
//					if components.isIndexValid(index: 1) {
//						Text(components[1].prefix(1))
//							.font(size.text)
//					}
//				}
//				.textCase(.uppercase)
//				.frame(width: size.sizing, height: size.sizing)
//				.background(.blue)
//				.clipShape(Circle())
			}
		}
	}
}

#Preview {
	Avatar(image: "IMG_0455.jpeg", fallback: "Nicholas", size: .large)
}
