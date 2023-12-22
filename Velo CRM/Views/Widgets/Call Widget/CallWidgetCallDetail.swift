import SwiftUI
import TwilioVoice

struct CallWidgetCallDetail: View {
    @Environment(CallManager.self) var callManager
    @Binding var call: Call?
    
    var body: some View {
        
        if let call {
            let state = call.state
            let isConnected = call.state == .connected
            let isRinging = call.state == .ringing
            GridRow {
                Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                    GridRow {
                        Avatar(image: tempUrl, fallback: "NB", size: .large)
                        
                        VStack(alignment: .leading) {
                            Text("Nicholas Black")
                                .font(.headline)
                            
                            Text(state.helperText)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if isConnected {
                            Button {
                                withAnimation(.snappy(duration: 0.1, extraBounce: 0.1)) {
                                    guard let uuid = call.uuid else { return }
                                    callManager.performEndCallAction(uuid: uuid)
                                }
                            } label: {
                                Image(systemName: "phone.down.circle.fill")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 38, height: 38)
                                    .foregroundColor(.mutedRed)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    
                    if isRinging {
                        GridRow {
                            HStack {
                                Button {
                                    withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
                                        guard let uuid = call.uuid else { return }
                                        callManager.performAnswerVoiceCall(uuid: uuid) { status in
                                            
                                        }
                                    }
                                } label: {
                                    Text("Accept")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.mutedGreen)
                                
                                Button {
                                    withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
                                        guard let uuid = call.uuid else { return }
                                        callManager.performEndCallAction(uuid: uuid)
                                    }
                                } label: {
                                    Text("Reject")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.mutedRed)
                                .frame(maxWidth: .infinity)
                            }
                            .gridCellColumns(3)
                        }
                        
                    }
                }
                .padding()
            }
        }
    }
}
