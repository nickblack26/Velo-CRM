import SwiftUI

struct TicketNotesListView: View {
	@State private var sectionedNotes: [Date: [ServiceTicketNoteModel]]?
	@State private var noteText: String = ""
	var notes: [ServiceTicketNoteModel]
	
	init(_ notes: [ServiceTicketNoteModel]) {
		do {
			self.sectionedNotes = try Dictionary(
				grouping: notes,
				by: {
					try Date($0.timeStart, strategy: .dateTime)
				}
			)
		} catch {
			self.sectionedNotes = nil
		}
		
		self.notes = notes
	}
	
	var body: some View {
		VStack {
			if notes.isEmpty {
				Spacer()
				
				Image("EmptyMessage")
					.resizable()
					.scaledToFit()
					.frame(maxHeight: 64)
				
				Text("No comments available")
					.fontWeight(.medium)
				
				Text("There are currently no comments on this ticket.")
					.foregroundStyle(.secondary)
				
				Button("Add comment", systemImage: "plus") {
					
				}
				.padding(.horizontal)
				.padding(.vertical, 8)
				.foregroundStyle(.primary)
				.background {
					RoundedRectangle(cornerRadius: 10)
						.fill(.clear)
						.stroke(.secondary, style: .init(lineWidth: 1))
				}
				
				Spacer()
			} else {
				ScrollViewReader { proxy in
					List {
						if let sectionedNotes {
							let keys = sectionedNotes.map{$0.key}
							let values = sectionedNotes.map {$0.value}
							
							ForEach(keys.indices) { index in
								let notes = values[index]
								Section {
									ForEach(notes) { note in
										NoteItemView(note)
									}
									
								} header: {
									let date = keys[index].ISO8601Format()
									HStack {
										Capsule()
											.fill(Color(uiColor: .systemGray6))
											.frame(height: 1)
											.frame(maxWidth: .infinity)
										
										Text(date)
											.font(.caption)
											.foregroundStyle(.secondary)
											.padding(.horizontal, 8)
											.padding(.vertical, 4)
											.background {
												Capsule()
													.fill(Color(uiColor: .systemGray6).opacity(0.5))
											}
										
										Capsule()
											.fill(Color(uiColor: .systemGray6))
											.frame(height: 1)
											.frame(maxWidth: .infinity)
									}
								}
								.listRowSeparator(.hidden)
							}
						}
						
					}
					.scrollContentBackground(.hidden)
				}
			}
			
			TextField("Note", text: $noteText)
				.lineLimit(5)
				.textFieldStyle(.roundedBorder)
				.overlay(alignment: .trailing) {
					Text("@")
						.foregroundStyle(.secondary)
						.padding(.trailing)
				}
				.padding(.bottom)
				.padding(.horizontal)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

#Preview("With Notes") {
	TicketNotesListView(testChain)
}

#Preview("Empty List") {
	TicketNotesListView([])
}

let firstDate = Date()
let secondDate = Date()

let testChain: [ServiceTicketNoteModel] = [
	.init(
		id: 1,
		text: "Taylor,\nI got confirmation from Twilio they have our settings to allow short codes set correctly. I have a ticket for Duo to investigate on their side for sending, as Twilio's response said some will not send to a voip number.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: firstDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 2,
		text: "Taylor,\nSMS and teams connection are working. I still have a problem with short not showing up. I did see some google sms mfa show up but those came from a 10 digit number. I've reopened my ticket where I requested and was told short codes were enabled.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: firstDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 3,
		text: "Taylor,\nThe port completed this afternoon. I'm able to sms it and view in the logs on Twilio side. I have Nick helped as it wasn't parsing into the Teams channel correctly, but he did some testing previously to have a solution. I'm going to do a little more testing and improve appearance before making it available to the team.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: firstDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 4,
		text: "Port is still in progress. email states I should have it today 10 AM Pacific.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: "2023-11-15T14:48:00.000Z"
	),
	.init(
		id: 5,
		text: "Wonderful, thank you sir!",
		originalAuthor: "Taylor Toce",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 6,
		text: "Taylor,\nTwilio still isn't receiving messages for the MFA number, Nick said from his view it was showing the transfer still in progress. I went through the AUP and Terms of service to make sure we didn't have the exact same problem with them rejecting come up. I found where they do explicitly mention OTP and short codes. We have to request from support to allow short codes to send to the account, it is system wide setting support enables, and I have done so linking the kb where it said to make the request.\nNick and I are working on the workflows on the Twilio side to get any text messages into Teams using Webhooks. Once we have MFA working I'll open that up to the team and we will have addressed one of our bigger issues that would have been needed down the road.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 7,
		text: "Taylor,\nTwilio still isn't receiving messages for the MFA number, Nick said from his view it was showing the transfer still in progress. I went through the AUP and Terms of service to make sure we didn't have the exact same problem with them rejecting come up. I found where they do explicitly mention OTP and short codes. We have to request from support to allow short codes to send to the account, it is system wide setting support enables, and I have done so linking the kb where it said to make the request.\nNick and I are working on the workflows on the Twilio side to get any text messages into Teams using Webhooks. Once we have MFA working I'll open that up to the team and we will have addressed one of our bigger issues that would have been needed down the road.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 8,
		text: "Taylor,\nTwilio still isn't receiving messages for the MFA number, Nick said from his view it was showing the transfer still in progress. I went through the AUP and Terms of service to make sure we didn't have the exact same problem with them rejecting come up. I found where they do explicitly mention OTP and short codes. We have to request from support to allow short codes to send to the account, it is system wide setting support enables, and I have done so linking the kb where it said to make the request.\nNick and I are working on the workflows on the Twilio side to get any text messages into Teams using Webhooks. Once we have MFA working I'll open that up to the team and we will have addressed one of our bigger issues that would have been needed down the road.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 9,
		text: "Taylor,\nTwilio still isn't receiving messages for the MFA number, Nick said from his view it was showing the transfer still in progress. I went through the AUP and Terms of service to make sure we didn't have the exact same problem with them rejecting come up. I found where they do explicitly mention OTP and short codes. We have to request from support to allow short codes to send to the account, it is system wide setting support enables, and I have done so linking the kb where it said to make the request.\nNick and I are working on the workflows on the Twilio side to get any text messages into Teams using Webhooks. Once we have MFA working I'll open that up to the team and we will have addressed one of our bigger issues that would have been needed down the road.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: ""
	),
	.init(
		id: 10,
		text: "Taylor,\nTwilio still isn't receiving messages for the MFA number, Nick said from his view it was showing the transfer still in progress. I went through the AUP and Terms of service to make sure we didn't have the exact same problem with them rejecting come up. I found where they do explicitly mention OTP and short codes. We have to request from support to allow short codes to send to the account, it is system wide setting support enables, and I have done so linking the kb where it said to make the request.\nNick and I are working on the workflows on the Twilio side to get any text messages into Teams using Webhooks. Once we have MFA working I'll open that up to the team and we will have addressed one of our bigger issues that would have been needed down the road.\nBrian",
		originalAuthor: "Brian Trahan",
		timeStart: secondDate.ISO8601Format(),
		timeEnd: ""
	),
]
