import SwiftUI

struct RootView<Content: View>: View {
	@ViewBuilder var content: Content
	@State private var overlayWindow: UIWindow?
	
    var body: some View {
		content
			.onAppear {
				if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
					let window = PassthroughWindow(windowScene: windowScene)
					window.backgroundColor = .clear
					
					/// View controller
					let rootController = UIHostingController(rootView: ToastGroup())
					rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
					rootController.view.backgroundColor = .clear
					window.rootViewController = rootController
					
					window.isHidden = false
					window.isUserInteractionEnabled = true
					window.tag = 1009
					
					overlayWindow = window
				}
				
			}
    }
}

fileprivate class PassthroughWindow: UIWindow {
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		guard let view = super.hitTest(point, with: event) else { return nil }
		
		return rootViewController?.view == view ? nil : view
	}
}

struct ToastModel: Identifiable {
	let id: UUID = .init()
	var title: String
	var symbol: String?
	var tint: Color
	var isUserInteractionEnabled: Bool
	var timing: ToastTime = .medium
}

enum ToastTime: CGFloat {
	case short = 1.0
	case medium = 2.0
	case long = 3.5
}

@Observable
class Toast {
	static let shared = Toast()
	fileprivate var toasts: [ToastModel] = []
	
	func presentToast(title: String, symbol: String?, tint: Color = .primary, isUserInteractionEnabled: Bool = false, timing: ToastTime = .medium) {
		withAnimation(.snappy) {
			toasts.append(.init(title: title, symbol: symbol, tint: tint, isUserInteractionEnabled: isUserInteractionEnabled, timing: timing))
		}
	}
}

fileprivate struct ToastGroup: View {
	var model = Toast.shared
	var body: some View {
		GeometryReader {
			let size = $0.size
			let safeArea = $0.safeAreaInsets
			
			ZStack {
				ForEach(model.toasts) { toast in
					ToastView(size: size, item: toast)
						.scaleEffect(scale(toast))
						.offset(y: offsetY(toast))
						.zIndex(Double(model.toasts.firstIndex(where: { $0.id == toast.id }) ?? 0))
				}
			}
			.padding(.bottom, safeArea.top == .zero ? 16 : 8)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
		}
	}
	
	func offsetY(_ item: ToastModel) -> CGFloat {
		let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
		let totalCount = CGFloat(model.toasts.count) - 1
		return (totalCount - index) >= 2 ? -20 : ((totalCount - index) * -10)
	}
	
	func scale(_ item: ToastModel) -> CGFloat {
		let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
		let totalCount = CGFloat(model.toasts.count) - 1
		return 1.0 - ((totalCount - index) >= 2 ? -20 : ((totalCount - index) * 0.1))
	}
}

fileprivate struct ToastView: View {
	var size: CGSize
	var item: ToastModel
	@State private var delayTask: DispatchWorkItem?
	var body: some View {
		HStack(spacing: 8) {
			if let symbol = item.symbol {
				Image(systemName: symbol)
					.font(.title3)
			}
			
			Text(item.title)
		}
		.foregroundStyle(item.tint)
		.padding(.horizontal, 16)
		.padding(.vertical, 8)
		.background(
			.background
				.shadow(.drop(color: .primary.opacity(0.06), radius: 4, x: 5, y: 5))
				.shadow(.drop(color: .primary.opacity(0.06), radius: 8, x: -5, y: -5)),
			in: .capsule
		)
		.contentShape(Capsule())
		.gesture(
			DragGesture(minimumDistance: 0)
				.onEnded({ value in
					guard item.isUserInteractionEnabled else { return }
					let endY = value.translation.height
					let velocityY = value.velocity.height
					
					if (endY + velocityY) > 100 {
						removeToast()
					}
				})
		)
		.task {
			try? await Task.sleep(for: .seconds(item.timing.rawValue))
			
			removeToast()
		}
		.onAppear {
			guard delayTask == nil else { return }
			delayTask = .init(block: {
				removeToast()
			})
			
			if let delayTask {
				DispatchQueue.main.asyncAfter(deadline: .now() + item.timing.rawValue, execute: delayTask)
			}
		}
		.frame(maxWidth: size.width * 0.7)
		.transition(.offset(y: 150))
	}
	
	func removeToast() {
		if let delayTask {
			delayTask.cancel()
		}
		withAnimation(.snappy) {
			Toast.shared.toasts.removeAll { $0.id == item.id }
		}
	}
}
