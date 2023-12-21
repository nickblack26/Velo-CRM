import SwiftUI

enum CallStatus: String {
	case incoming
	case inProgress
}

struct CallWidget: View {
	@State private var muteMic: Bool = false
	@State private var showDialer: Bool = false
	@State private var showDirectory: Bool = false
	@State private var isHovering: Bool = false
	@State private var status: CallStatus?
	
    var body: some View {
		Grid {
			CallWidgetCallDetail(status: $status)
			
			if showDirectory {
				CallDirectory()
			}
			
			if showDialer {
				if status != nil {
					Divider()
						.background(.cardBackgroundSecondary)
				}
				
				GridRow {
					OutboundDialer()
				}
			}

			GridRow {
				Grid {
					GridRow(alignment: .bottom) {
						if status == .inProgress {
							Button {
								muteMic.toggle()
							} label: {
								Image(systemName: "mic.slash.fill")
							}
							.frame(maxHeight: .infinity)
							.gridCellUnsizedAxes(.vertical)
							.foregroundStyle(muteMic ? .red : .white)
							.background(muteMic ? .white : .clear)
							.buttonStyle(.bordered)
							.clipShape(RoundedRectangle(cornerRadius: 6))
							
							Button {
								
							} label: {
								Image(systemName: "pause.fill")
							}
							
							.frame(maxHeight: .infinity)
							.buttonStyle(.bordered)
							.gridCellUnsizedAxes(.vertical)
							
							Button {
								withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
									showDirectory.toggle()
								}
							} label: {
								Image(systemName: "phone.arrow.up.right.fill")
							}
							.frame(maxHeight: .infinity)
							.buttonStyle(.bordered)
							.gridCellUnsizedAxes(.vertical)
						}
						
						Button {
							
						} label: {
							Image(systemName: "book.closed.fill")
						}
						.frame(maxHeight: .infinity)
						.buttonStyle(.bordered)
						.gridCellUnsizedAxes(.vertical)
						
						Button {
							withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
								showDialer.toggle()
							}
						} label: {
							Image(systemName: "circle.grid.3x3.fill")
						}
						.frame(maxHeight: .infinity)
						.buttonStyle(.bordered)
						.gridCellUnsizedAxes(.vertical)
						
						Menu {
							Picker("Input", selection: .constant("Device1")) {
								ForEach(0..<3, id: \.self) {
									Text("Device\($0)")
										.tag("Device\($0)")
								}
							}
							
							Picker("Output", selection: .constant("Device3")) {
								ForEach(3..<6, id: \.self) {
									Text("Device\($0)")
										.tag("Device\($0)")
								}
							}
						} label: {
							Image(systemName: "gearshape.fill")
						}
						.frame(maxHeight: .infinity)
						.buttonStyle(.bordered)
						.gridCellUnsizedAxes(.vertical)
						
						Spacer(minLength: 16)
							.gridCellUnsizedAxes(.vertical)
						
						Circle()
							.fill(.green)
							.frame(width: 12, height: 12)
					}
				}
			}
			.padding()
			.background(.cardBackgroundSecondary)
			.onTapGesture {
				status = .incoming
			}
		}
		.onHover { isHovering = $0 }
		.foregroundStyle(.white)
		.tint(.white)
		.background(.cardBackgroundPrimary)
		.clipShape(RoundedRectangle(cornerRadius: 16))
		.shadow(radius: isHovering ? 25 : 0)
		.frame(minWidth: 100, idealWidth: 350, maxWidth: 400, alignment: .bottomTrailing)
    }
	
}

#Preview("Incoming") {
	CallWidget()
		.previewLayout(.sizeThatFits)
}

#Preview("In Progress") {
	CallWidget()
		.previewLayout(.sizeThatFits)
}

#Preview("Nothing") {
	CallWidget()
		.previewLayout(.sizeThatFits)
}

