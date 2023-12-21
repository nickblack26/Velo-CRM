import UIKit
import AVFoundation
import PushKit
import CallKit
import Observation
//import TwilioVoice

let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzMyMGFlYzcxMzA4ZTFmN2NmYTU2YzllM2E0MTkxYzA3LTE2OTk4OTM4NTQiLCJncmFudHMiOnsiaWRlbnRpdHkiOiJhbGljZSIsInZvaWNlIjp7ImluY29taW5nIjp7ImFsbG93Ijp0cnVlfSwib3V0Z29pbmciOnsiYXBwbGljYXRpb25fc2lkIjoiQVAzMzRjZTVjOTU0OTk4MzU2YjNlNjA1YzhhOGNiYzU3NyJ9fX0sImlhdCI6MTY5OTg5Mzg1NCwiZXhwIjoxNjk5ODk3NDU0LCJpc3MiOiJTSzMyMGFlYzcxMzA4ZTFmN2NmYTU2YzllM2E0MTkxYzA3Iiwic3ViIjoiQUMzMmU2ZmEyZjc2MDBkNzJjYThjMDA0NzYzYWIwNmYxYyJ9.4cyAjv7z8AaVl4FE2xSpHX_QarQKkFA-4W0Tnig0nsg"
let twimlParamTo = "to"

let kCachedDeviceToken = "CachedDeviceToken"

@Observable
final class TwilioManager {
	init() {
		// Create a push registry object
		let voipRegistry: PKPushRegistry = PKPushRegistry(queue: nil)
		// Set the push type to VoIP
		voipRegistry.desiredPushTypes = [.voIP]
	}
	
	func registerForVoIPCalls(_ voipRegistry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
		
		// Create an object to handle call configurations and settings
		let callConfigObject = CXProviderConfiguration()
		// Enable video calls
		callConfigObject.supportsVideo = true;
		// Show missed, received and sent calls in the phone app's Recents category
		callConfigObject.includesCallsInRecents = true;
		// Set a custom ring tone for incoming calls
		callConfigObject.ringtoneSound = "ES_CellRingtone23.mp3"
		
		// Create an object to give update about call-related events
		let callReport = CXCallUpdate()
		// Display the name of the caller
		callReport.remoteHandle = CXHandle(type: .generic, value: "Amos Gyamfi")
		// Enable video call
		callReport.hasVideo = true
		
		// Create an object to give update about incoming calls
		let callProvider = CXProvider(configuration: callConfigObject)
		callProvider.reportNewIncomingCall(with: UUID(), update: callReport, completion: { error in })
//		callProvider.setDelegate(self, queue: nil)
	}
}
