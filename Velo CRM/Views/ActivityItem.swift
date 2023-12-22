import SwiftUI

struct ActivityItem: View {
    var body: some View {
        HStack(alignment: .top) {
            Avatar(image: tempUrl, fallback: "Nicholas Black", size: .large)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("at 6:34 PM")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text("You")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                CallActivityCard()
            }
        }
    }
}

#Preview {
    ActivityItem()
}
