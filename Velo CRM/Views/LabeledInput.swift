//
//  LabeledInput.swift
//  Velo CRM
//
//  Created by Nick Black on 11/13/23.
//

import SwiftUI

struct LabeledInput: View {
	var fieldName: String
	@Binding var fieldBinding: String
	
    var body: some View {
		LabeledContent {
			TextField(fieldName, text: $fieldBinding, prompt: Text(""))
				.textFieldStyle(.roundedBorder)
		} label: {
			Text("\(fieldName):")
				.lineLimit(1)
				.fontWeight(.bold)
				.foregroundStyle(.secondary)
				.underline()
				.frame(minWidth: 100, maxWidth: 100, alignment: .leading)
		}
    }
}

#Preview {
	LabeledInput(fieldName: "Company", fieldBinding: .constant(""))
}
