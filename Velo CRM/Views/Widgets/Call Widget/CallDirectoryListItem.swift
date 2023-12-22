import SwiftUI

struct CallDirectoryListItem: View {
    @Environment(CallManager.self) private var callManager
    @State private var isHovering: Bool = false
    
    var name: String
    
    var body: some View {
        GridRow {
            HStack {
                Avatar(image: tempUrl, fallback: "Nicholas Black", size: .tiny)
                Text(name)
                
                Spacer()
                
                if isHovering {
                    Button {
                        startCall()
                    } label: {
                        Image(systemName: "phone.connection")
                            .imageScale(.small)
                    }
                    
                    Button {
                        startCall()
                    } label: {
                        Image(systemName: "phone.arrow.up.right")
                            .imageScale(.small)
                    }
                }
            }
        }
        .padding(8)
        .background(isHovering ? .cardBackgroundSecondary : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .contentShape(Rectangle())
        .onHover{ isHovering = $0 }
        .onTapGesture {
            startCall()
        }
    }
    
    func startCall() {
        if let activeCall = callManager.activeCall {
            callManager.userInitiatedDisconnect = true
            callManager.performEndCallAction(uuid: activeCall.uuid!)
            return
        }

        let uuid = UUID()
        let handle = "Voice Bot"
        callManager.performStartCallAction(uuid: uuid, handle: handle)
    }
}

#Preview {
    @State var callManager = CallManager()
    return CallDirectoryListItem(name: "")
        .environment(callManager)
}
