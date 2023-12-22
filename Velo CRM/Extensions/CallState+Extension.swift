import Foundation
import TwilioVoice

extension Call.State {
    var helperText: String {
        switch self {
            case .connected: "Call in progress"
            case .ringing: "is now calling..."
            default: ""
        }
    }
}
