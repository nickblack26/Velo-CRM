import SwiftUI

@main
struct Velo_CRMApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
	@State private var manager = VeloManager()
	
	init() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { status, error in
			print(status)
			print(error?.localizedDescription ?? "")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			RootView {
				ContentView()
					.overlay(alignment: .bottomTrailing) {
						CallWidget()
							.padding()
					}
			}
		}
		.environment(manager)		
	}
}
