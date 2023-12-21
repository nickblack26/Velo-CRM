//
//  iOSCheckboxToggleStyle.swift
//  Velo CRM
//
//  Created by Nick Black on 11/13/23.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		// 1
		Button(action: {
			
			// 2
			configuration.isOn.toggle()
			
		}, label: {
			HStack {
				// 3
				Image(systemName: configuration.isOn ? "checkmark.square" : "square")
				
				configuration.label
			}
		})
	}
}
