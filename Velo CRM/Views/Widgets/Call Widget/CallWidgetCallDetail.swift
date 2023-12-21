//
//  CallWidgetCallDetail.swift
//  Velo CRM
//
//  Created by Nick Black on 12/20/23.
//

import SwiftUI

struct CallWidgetCallDetail: View {
	@Binding var status: CallStatus?
	
    var body: some View {
		GridRow {
			if let currentStatus = status {
				let isIncoming = currentStatus == .incoming
				let isInProgress = currentStatus == .inProgress
				let statusText = isIncoming ? "is now calling..." : "Call in progress - 00:31"
				Grid(horizontalSpacing: 16, verticalSpacing: 16) {
					GridRow {
						Avatar(image: tempUrl, fallback: "NB", size: .large)
						
						VStack(alignment: .leading) {
							Text("Nicholas Black")
								.font(.headline)
							
							Text(statusText)
								.font(.subheadline)
								.foregroundStyle(.secondary)
						}
						.frame(maxWidth: .infinity, alignment: .leading)
						
						if isInProgress {
							Button {
								withAnimation(.snappy(duration: 0.1, extraBounce: 0.1)) {
									status = nil
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
					
					if isIncoming {
						GridRow {
							HStack {
								Button {
									withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
										status = .inProgress
									}
								} label: {
									Text("Accept")
										.frame(maxWidth: .infinity)
								}
								.buttonStyle(.borderedProminent)
								.tint(.mutedGreen)
								
								Button {
									withAnimation(.snappy(duration: 0.25, extraBounce: 0.1)) {
										status = nil
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

#Preview {
	CallWidgetCallDetail(status: .constant(nil))
}
