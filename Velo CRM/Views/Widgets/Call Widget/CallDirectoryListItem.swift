//
//  CallDirectoryListItem.swift
//  Velo CRM
//
//  Created by Nick Black on 12/20/23.
//

import SwiftUI

struct CallDirectoryListItem: View {
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
						
					} label: {
						Image(systemName: "phone.connection")
							.imageScale(.small)
					}
					
					Button {
						
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
    }
}

#Preview {
	CallDirectoryListItem(name: "")
}
