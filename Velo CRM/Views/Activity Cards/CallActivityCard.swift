import SwiftUI
import TwilioVoice

enum CallStatus: String {
    case completed
    case incoming
    case inProgress
    case missed
    case ended
    
    var icon: String {
        switch self {
        case .completed:
            "phone.arrow.down.left.fill"
        case .incoming:
            "phone.fill"
        case .inProgress:
            "phone.badge.waveform.fill"
        case .missed:
            "phone.arrow.down.left.fill"
        case .ended:
            "phone.arrow.down.left.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .completed:
            .mutedGreen
        case .incoming:
            .mutedBlue
        case .inProgress:
            .mutedGreen
        case .missed:
            .mutedRed
        case .ended:
            Color(uiColor: .systemGray5)
        }
    }
}

enum CallType: String {
    case incoming
    case inProgress
    case missed
    case ended
}


struct CallActivityCard: View {
    var callStatus: CallStatus = .completed
    
    var body: some View {
        Grid(alignment: .leading, verticalSpacing: 16) {
            GridRow(alignment: .top) {
                Button {
                    
                } label: {
                    Image(systemName: callStatus.icon)
                }
                .buttonStyle(.bordered)
                .tint(callStatus.color)
                .clipShape(Circle())
                .gridCellColumns(1)
                .gridCellUnsizedAxes(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Call ended")
                        .fontWeight(.semibold)
                    Text("Closed")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .gridCellColumns(2)
                .gridCellUnsizedAxes(.horizontal)
                
                Button {} label: {
                    Image(systemName: "ellipsis")
                }
                .gridCellColumns(1)
                .gridCellUnsizedAxes(.horizontal)
            }
            .padding([.horizontal, .top])
            
            GridRow {
                WaveForm()
                    .gridCellColumns(4)
            }
            .padding(.horizontal)
            
            Divider()
            
            GridRow {
                Text("Subject")
                
                Button("Teeth cleaning") {
                    
                }
                .buttonStyle(.bordered)
                .tint(callStatus.color)
                .fontWeight(.semibold)
                .font(.caption)
                .gridCellColumns(2)
            }
            .padding(.horizontal)
            
            GridRow {
                Text("Reason")
                
                Text("Visit Confirmation")
                    .gridCellColumns(2)
            }
            .padding([.horizontal, .bottom])
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .strokeBorder(callStatus.color, lineWidth: callStatus == .completed ? 2 : 1)
        }
    }
}

#Preview("Call Activity") {
    CallActivityCard()
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6).ignoresSafeArea())
    
}

import DSWaveformImageViews

struct WaveForm: View {
    var body: some View {
        HStack {
            Button {} label: {
                Image(systemName: "play.fill")
            }
            
            HStack(spacing: 2) {
                ForEach(0..<50, id: \.self) { _ in
                    let number = Int.random(in: 5..<25)
                    Capsule()
                        .frame(height: CGFloat(number))
                }
            }
            
            Text("00:11")
                .font(.subheadline)
            
            Button {} label: {
                Image(systemName: "ellipsis")
            }
        }
        .foregroundStyle(.secondary)
        .padding(4)
        .padding(.horizontal, 4)
        .background(Color(uiColor: .systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview("Waveform") {
    WaveForm()
}
