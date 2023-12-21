import SwiftUI

struct ContactModal: View {
    var body: some View {
		GeometryReader {
			let size = $0.size
			VStack {
				HStack {
					Button {
						
					} label: {
						Image(systemName: "arrow.up.left.and.arrow.down.right")
					}
					.borderedButton()
					
					Spacer()
					
					Button {
						
					} label: {
						Image(systemName: "xmark")
					}
					.borderedButton()
				}
				
				Avatar(image: tempUrl, fallback: "Nicholas Black", size: .xlarge)
				
				Text("Nicholas Black")
					.font(.largeTitle)
					.fontWeight(.semibold)
				
				HStack {
					Text(verbatim: "nicholas.black98@icloud.com")
					Image(systemName: "square.on.square")
				}
				
				HStack {
					Button {
						
					} label: {
						Image(systemName: "pencil")
					}
					.borderedButton()
					
					Button {
						
					} label: {
						Image(systemName: "arrow.triangle.2.circlepath.circle")
					}
					.borderedButton()
					
					Button {
						
					} label: {
						Image(systemName: "tag")
					}
					.borderedButton()
					
					Button {
						
					} label: {
						Image(systemName: "app.gift")
					}
					.borderedButton()
					
					Button {
						
					} label: {
						Image(systemName: "ellipsis")
					}
					.borderedButton()
				}
				
				Divider()
			}
			.padding()
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			.background(.white)
			.clipShape(UnevenRoundedRectangle(bottomTrailingRadius: 16, topTrailingRadius: 16))
			.shadow(radius: 5)
			.frame(maxWidth: size.width / 3, alignment: .topTrailing)
			.padding()
		}
//		.shadow(radius: 25)
    }
}

#Preview {
    ContactModal()
}
