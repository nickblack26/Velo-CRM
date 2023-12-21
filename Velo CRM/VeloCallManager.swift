import Foundation
import Observation
import CallKit

final class VeloCallManager: NSObject {
	let callController = CXCallController()
	
	// MARK: - Actions
	
	/// Starts a new call with the specified handle and indication if the call includes video.
	/// - Parameters:
	///   - handle: The caller's phone number.
	///   - video: Indicates if the call includes video.
	func startCall(handle: String, video: Bool = false) {
		let handle = CXHandle(type: .phoneNumber, value: handle)
		let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
		
		startCallAction.isVideo = video
		
		let transaction = CXTransaction()
		transaction.addAction(startCallAction)
		
		requestTransaction(transaction)
	}
	
	/// Ends the specified call.
	/// - Parameter call: The call to end.
	func end(call: VeloCall) {
		let endCallAction = CXEndCallAction(call: call.uuid)
		let transaction = CXTransaction()
		transaction.addAction(endCallAction)
		
		requestTransaction(transaction)
	}
	
	/// Sets the specified call's on hold status.
	/// - Parameters:
	///   - call: The call to update on hold status for.
	///   - onHold: Specifies whether the call should be placed on hold.
	func setOnHoldStatus(for call: VeloCall, to onHold: Bool) {
		let setHeldCallAction = CXSetHeldCallAction(call: call.uuid, onHold: onHold)
		let transaction = CXTransaction()
		transaction.addAction(setHeldCallAction)
		
		requestTransaction(transaction)
	}
	
	/// Requests that the actions in the specified transaction be asynchronously performed by the telephony provider.
	/// - Parameter transaction: A transaction that contains actions to be performed.
	private func requestTransaction(_ transaction: CXTransaction) {
		callController.request(transaction) { error in
			if let error = error {
				print("Error requesting transaction:", error.localizedDescription)
			} else {
				print("Requested transaction successfully")
			}
		}
	}
	
	// MARK: - Call Management
	
	/// A publisher of active calls.
	private(set) var calls = [VeloCall]()
	
	/// Returns the call with the specified UUID if it exists.
	/// - Parameter uuid: The call's unique identifier.
	/// - Returns: The call with the specified UUID if it exists, otherwise `nil`.
	func callWithUUID(uuid: UUID) -> VeloCall? {
		guard let index = calls.firstIndex(where: { $0.uuid == uuid }) else { return nil }
		
		return calls[index]
	}
	
	/// Adds a call to the array of active calls.
	/// - Parameter call: The call  to add.
	func addCall(_ call: VeloCall) {
		calls.append(call)
	}
	
	/// Removes a call from the array of active calls if it exists.
	/// - Parameter call: The call to remove.
	func removeCall(_ call: VeloCall) {
		guard let index = calls.firstIndex(where: { $0 === call }) else { return }
		
		calls.remove(at: index)
	}
	
	/// Empties the array of active calls.
	func removeAllCalls() {
		calls.removeAll()
	}
}
