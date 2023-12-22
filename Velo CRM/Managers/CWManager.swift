import Foundation
import Observation

enum Endpoint {
	case tickets
	case ticket(Int)
	
	var url: String {
		switch self {
			case .tickets:
				"/service/tickets"
			case .ticket(let int):
				"/service/tickets\(int)"
		}
	}
}

enum Method: String {
	case get = "GET"
	case post = "POST"
}

@Observable
final class CWManager {
	private var baseUrl = "https://manage.velomethod.com/v4_6_release/apis/3.0/"
	private var request = URLRequest(url: .init(string: "https://manage.velomethod.com/v4_6_release/apis/3.0/")!,timeoutInterval: Double.infinity)
	
	init() {
		request.addValue("900822ef-aa1c-4f08-aae6-f070919b56fa", forHTTPHeaderField: "clientId")
		request.addValue("Basic dmVsbytyS3F3bmg5SWpoMTZwa2k2Ok9ndnphMTNlZUVWVUExZ1M=", forHTTPHeaderField: "Authorization")
	}
	
//	func makeRequest<T>(_ endpoint: Endpoint) async throws -> [T] where T : Decodable {
//		request.httpMethod = "GET"
//		request.url = .init(string: "\(baseUrl)\(endpoint.url)")
//		
//		do {
//			let (data, response) = try await URLSession.shared.data(for: request)
//			
//			guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
//			let decodedResult: [T] = try JSONDecoder().decode(endpoint.type, from: data) as! [T]
//			
//			return decodedResult
//		} catch {
//			print(error)
//		}
//		
//		return []
//	}
//	
//	private func initalize() {
//		URLSession.shared.dataTask(with: <#T##URLRequest#>)
//		let task = URLSession.shared.dataTask(with: request) { data, response, error in
//			guard let data = data else {
//				print(String(describing: error))
//				return
//			}
//			print(String(data: data, encoding: .utf8)!)
//		}
//	}
}
