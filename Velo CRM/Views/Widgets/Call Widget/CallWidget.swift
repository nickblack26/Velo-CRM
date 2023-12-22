import SwiftUI

struct CallWidget: View {
    @Environment(CallManager.self) var callManager
	@State private var showDialer: Bool = false
	@State private var showDirectory: Bool = false
	@State private var isHovering: Bool = false
	
    var body: some View {
        @Bindable var callManager = callManager
		Grid {
            if let _ = callManager.activeCall {
                CallWidgetCallDetail(call: $callManager.activeCall)
            }
			
			if showDirectory {
				CallDirectory()
			}
			
			if showDialer {
                if let _ = callManager.activeCall {
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
                        if let call = callManager.activeCall, call.state == .connected {
							Button {
                                call.isMuted.toggle()
							} label: {
								Image(systemName: "mic.slash.fill")
							}
							.frame(maxHeight: .infinity)
							.gridCellUnsizedAxes(.vertical)
                            .foregroundStyle(call.isMuted ? .red : .white)
                            .background(call.isMuted ? .white : .clear)
							.buttonStyle(.bordered)
							.clipShape(RoundedRectangle(cornerRadius: 6))
							
							Button {
                                call.isOnHold.toggle()
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
                            withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
                                showDirectory.toggle()
                            }
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
    @State var callManager = CallManager()
    return CallWidget()
        .previewLayout(.sizeThatFits)
        .environment(callManager)
}

#Preview("In Progress") {
    @State var callManager = CallManager()
    return CallWidget()
        .previewLayout(.sizeThatFits)
        .environment(callManager)
}

#Preview("Nothing") {
    @State var callManager = CallManager()
    return CallWidget()
		.previewLayout(.sizeThatFits)
        .environment(callManager)
}

