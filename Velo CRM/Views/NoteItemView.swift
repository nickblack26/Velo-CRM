//
//  NoteItemView.swift
//  Velo CRM
//
//  Created by Nick Black on 11/15/23.
//

import SwiftUI

struct NoteItemView: View {
	@State private var isPresented: Bool = false
	let urlString = "https://cdn.dribbble.com/users/5187183/avatars/normal/2d823e8fd37edbf67ae40f7a0e7a0099.png?1658763329"
	var note: ServiceTicketNoteModel
	
	init(_ note: ServiceTicketNoteModel) {
		self.note = note
	}
	
    var body: some View {
		HStack(alignment: .top) {
			AsyncImage(url: URL(string: urlString)) { image in
				image
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
				
			} placeholder: {
				Circle()
					.fill(.blue)
			}
			.frame(width: 24, height: 24)
			
			VStack(alignment: .leading) {
				HStack {
					Text("\(note.originalAuthor) \(Text("• 24 hrs ago").foregroundStyle(.secondary))")
						.font(.title3)
						.fontWeight(.medium)
					
					Spacer()
					
					let isResolved = note.resolutionFlag ?? false
					
					Button {
						isPresented.toggle()
					} label: {
						Image(systemName: isResolved ? "checkmark.circle.fill" : "ellipsis")
							.imageScale(.small)
							.foregroundStyle(isResolved ? .green : .primary)
					}
					.popover(isPresented: $isPresented) {
						Button(action: {}, label: {
							Label("Resolve", systemImage: "checkmark.circle.fill")
						})
						
						Button(action: {}, label: {
							Label("Reply", systemImage: "arrow.turn.down.right")
						})
					}
				}
				
				Text(note.text)
					.foregroundStyle(.secondary)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
					.background {
						RoundedRectangle(cornerRadius: 8)
							.fill(.clear)
							.stroke(Color(uiColor: .systemGray5), style: .init(lineWidth: 1))
					}
			}
		}
    }
}

#Preview {
	NoteItemView(
			.init(
				id: 123,
				text: "Complete all tasks.  Add Internal note of completion.  Mark off tasks as you complete them.",
				originalAuthor: "template674",
				timeStart: "2011-10-05T14:48:00.000Z",
				timeEnd: ""
			)
	)
}
