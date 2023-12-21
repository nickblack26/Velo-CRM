import SwiftUI

struct CompanyDetailOverviewTab: View {
	@State private var selectedUpdateTab: UpdateTab = .Status
	@State private var strengthProgress: CGFloat = 0
	
    var body: some View {
		Grid(horizontalSpacing: 24, verticalSpacing: 24) {
			GridRow {
				MetricCardView("Primary Contact") {
					HStack {
						Image(systemName: "person.text.rectangle")
						Text("Jessica McKey")
					}
				} subtitle: {
					Text("Assistant Controller")
				}

				MetricCardView("Projects Completed") {
					Text(verbatim: "\(12)")
				} subtitle: {
					Text("\(Text("\(3)").foregroundStyle(.blue)) Projects on track")
				}
				
				MetricCardView("Active Users") {
					Text(verbatim: "\(76)")
				} subtitle: {
					Text("\(Text("\(73)").foregroundStyle(.blue)) Inactive")
				}
				
				MetricCardView("Outages") {
					Text(verbatim: "\(1)")
				} subtitle: {
					Text("Since Last Month")
				}
				
				MetricCardView("Strength Rating") {
					Text("Average")
				} subtitle: {
					HStack(spacing: 8) {
							RoundedRectangle(cornerRadius: 2)
								.fill(Color(uiColor: .green))
							
							RoundedRectangle(cornerRadius: 2)
								.fill(.green)
							
							RoundedRectangle(cornerRadius: 2)
								.fill(.teal)
							
							RoundedRectangle(cornerRadius: 2)
								.fill(.orange)
							
							RoundedRectangle(cornerRadius: 2)
								.fill(.red)
						}
						.frame(height: 8)
						.overlay(alignment: .leading) {
							GeometryReader {
								let size = $0.size
								let lineWidth = (size.width / 5) + 8
								
								Image(systemName: "arrowtriangle.up.fill")
									.offset(
										x: strengthProgress * (size.width - lineWidth),
										y: 8
									)
							}
						}
						.onTapGesture {
							withAnimation(.bouncy) {
								if strengthProgress < 1.2 {
									strengthProgress += 0.2
								} else {
									strengthProgress = 0
								}
							}
						}
				}
			}
			
			GridRow {
				VStack(alignment: .leading) {
					Section {
						ServiceTicketModelTable()
					} header: {
						VStack(alignment: .leading) {
							Text("Service Tickets")
								.font(.title2)
								.fontWeight(.semibold)
							
							HStack {
								Button {
									
								} label: {
									Text("Open")
									Text("\(12)")
								}
								.buttonStyle(.borderedProminent)
								.tint(Color(uiColor: .systemGray6))
								.foregroundStyle(.primary)
								
								Button {
									
								} label: {
									Text("Waiting")
									Text("\(6)")
								}
								.buttonStyle(.borderedProminent)
								.tint(.accentColor)
								
								Button {
									
								} label: {
									Text("Closed")
									Text("\(7)")
								}
								.buttonStyle(.borderedProminent)
								.tint(Color(uiColor: .systemGray6))
								.foregroundStyle(.primary)
								
								Spacer()
								
								Button {
									
								} label: {
									Text("View all")
									Image(systemName: "chevron.right")
								}
								.buttonStyle(.borderedProminent)
								.tint(Color(uiColor: .systemGray6))
								.foregroundStyle(.primary)
							}
						}
					}
					
					Section {
						ServiceTicketModelTable()
					} header: {
						VStack(alignment: .leading) {
							Text("Contacts")
								.font(.title2)
								.fontWeight(.semibold)
							
							HStack {
								Button {
									
								} label: {
									Text("Active")
									Text("\(76)")
								}
								.buttonStyle(.borderedProminent)
								.tint(Color(uiColor: .systemGray6))
								.foregroundStyle(.primary)
								
								Button {
									
								} label: {
									Text("Inactive")
									Text("\(73)")
								}
								.buttonStyle(.borderedProminent)
								.tint(.accentColor)
								
								Spacer()
								
								Button {
									
								} label: {
									Text("View all")
									Image(systemName: "chevron.right")
								}
								.buttonStyle(.borderedProminent)
								.tint(Color(uiColor: .systemGray6))
								.foregroundStyle(.primary)
							}
						}
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
				.gridCellColumns(3)
				
				VStack(alignment: .leading) {
					HStack {
						ForEach(UpdateTab.allCases, id: \.self) { tab in
							Button(tab.rawValue) {
								
							}
//							.padding(.horizontal)
							.tint(selectedUpdateTab == tab ? .accentColor : .secondary)
						}
					}
					.padding()
					
					Divider()
					
					TabView(selection: $selectedUpdateTab) {
						TicketNotesListView(testChain)
							.tag(UpdateTab.Comments)
					}
					
					
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
				.background {
					RoundedRectangle(cornerRadius: 10)
						.fill(.clear)
						.strokeBorder(style: .init(lineWidth: 1))
				}
				.gridCellColumns(2)
			}
		}
    }
}

#Preview {
    CompanyDetailOverviewTab()
}

enum UpdateTab: String, CaseIterable {
	case Status
	case Comments
}
