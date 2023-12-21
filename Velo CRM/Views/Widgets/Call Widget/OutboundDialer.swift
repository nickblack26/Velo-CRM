import SwiftUI

let keys: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"]

struct OutboundDialer: View {
	@State private var phoneNumber: String = ""
	
    var body: some View {
		Grid(horizontalSpacing: 16, verticalSpacing: 16) {
			GridRow {
				TextField(
					"Phone Number",
					text: $phoneNumber,
					prompt: Text("(123) 456-7890")
						.foregroundStyle(.white.opacity(0.6))
				)
					.font(.title)
					.multilineTextAlignment(.center)
					.onChange(of: phoneNumber) {
						if !phoneNumber.isEmpty {
							phoneNumber = phoneNumber.formatPhoneNumber()
						}
					}
					.gridCellColumns(3)
					.gridCellUnsizedAxes(.horizontal)
					.foregroundStyle(.white)
			}
			
			GridRow {
				ForEach(0..<3, id: \.self) { index in
					Button {
						phoneNumber.append(keys[index])
					} label: {
						Text(keys[index])
							.font(.title)
							.padding()
						
					}
					.buttonStyle(.bordered)
					.clipShape(Circle())
				}
			}
			
			GridRow {
				ForEach(3..<6, id: \.self) { index in
					Button {
						phoneNumber.append(keys[index])
					} label: {
						Text(keys[index])
							.font(.title)
							.padding()
						
					}
					.buttonStyle(.bordered)
					.clipShape(Circle())
				}
			}
			
			GridRow {
				ForEach(6..<9, id: \.self) { index in
					Button {
						phoneNumber.append(keys[index])
					} label: {
						Text(keys[index])
							.font(.title)
							.padding()
						
					}
					.buttonStyle(.bordered)
					.clipShape(Circle())
				}
			}
			
			GridRow {
				ForEach(9..<12, id: \.self) { index in
					Button {
						phoneNumber.append(keys[index])
					} label: {
						Text(keys[index])
							.font(.title)
							.padding()
						
					}
					.buttonStyle(.bordered)
					.clipShape(Circle())
				}
			}
			
			GridRow {
				Button {} label: {
					Image(systemName: "phone.fill")
						.resizable()
						.frame(width: 20, height: 20)
						.padding()
				}
				.buttonStyle(.borderedProminent)
				.tint(.green)
				.clipShape(Circle())
				.gridCellColumns(3)
			}
		}
		.padding()
    }
}



#Preview {
    OutboundDialer()
		.frame(maxWidth: 350)
}


extension String {
	func formatPhoneNumber() -> String {
		let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
		
		let mask = "(XXX) XXX-XXXX"
		
		var result = ""
		var startIndex = cleanNumber.startIndex
		var endIndex = cleanNumber.endIndex
		
		for char in mask where startIndex < endIndex {
			if char == "X" {
				result.append(cleanNumber[startIndex])
				startIndex = cleanNumber.index(after: startIndex)
			} else {
				result.append(char)
			}
		}
		
		return result
	}
}
