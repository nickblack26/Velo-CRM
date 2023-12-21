//
//  Test.swift
//  Velo CRM
//
//  Created by Nick Black on 11/13/23.
//

import UIKit
import CallKit

class CallProviderDelegate: NSObject {
	private let provider: CXCallProvider
	
	init(provider: CXCallProvider) {
		self.provider = provider
	}
	
	func incomingCall(with call: CXCall) {
		let callUpdate = CXCallUpdate()
		callUpdate.remoteHandle = "1234567890"
		callUpdate.callerDisplayName = "John Doe"
		
		provider.reportIncomingCall(with: call, update: callUpdate)
	}
	
	func outgoingCall(with call: CXCall) {
		let callUpdate = CXCallUpdate()
		callUpdate.remoteHandle = "0987654321"
		callUpdate.callerDisplayName = "Jane Smith"
		
		provider.reportOutgoingCall(with: call, update: callUpdate)
	}
	
	func callChanged(_ call: CXCall) {
		let callUpdate = CXCallUpdate()
		callUpdate.isMuted = call.isMuted
		callUpdate.audioSession = call.audioSession
		
		provider.reportCall(with: call, update: callUpdate)
	}
	
	func callEnded(_ call: CXCall) {
		provider.reportCallEnded(with: call)
	}
}

class CallProvider: NSObject, CXProviderDelegate {
	private let provider: CXCallProvider
	private let delegate: CallProviderDelegate
	
	init() {
		let configuration = CXProviderConfiguration(localizedName: "MyApp")
		provider = CXCallProvider(config: configuration)
		delegate = CallProviderDelegate(provider: provider)
		provider.setDelegate(delegate, queue: DispatchQueue.main)
	}
	
	func requestCallPermissions() {
		CXCallManager.requestAuthorization { authorization in
			switch authorization {
				case .authorized:
					print("Call permissions granted")
				case .notDetermined:
					print("Call permissions not determined")
				case .denied:
					print("Call permissions denied")
				default:
					break
			}
		}
	}
	
	func makeOutgoingCall(to number: String) {
		let callUpdate = CXCallUpdate()
		callUpdate.remoteHandle = number
		
		provider.reportOutgoingCall(with: UUID(), update: callUpdate)
	}
}
