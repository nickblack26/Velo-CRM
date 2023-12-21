//
//  TicketDetail.swift
//  Velo CRM
//
//  Created by Nick Black on 11/10/23.
//

import SwiftUI

struct TicketDetail: View {
	var ticket: Ticket
	
    var body: some View {
		Form {
			Text(ticket.summary ?? "")
		}
		.navigationTitle(ticket.summary ?? "")
    }
}

#Preview {
	TicketDetail(ticket: .init())
}
