import UIKit

// Allowed websites
enum Websites: String {
    case Google = "https://www.google.com"
    case Apple = "https://www.apple.com"
}

/// Gets the server datetime from the headers of an allowed website using URLSession
/// - Parameter url: an URL from allowed websites
/// - Throws: An error if ocurres
/// - Returns: An optional date if succeded
func getServerTime(url: Websites) async throws -> Date? {
    guard let url = URL(string: url.rawValue) else {
        throw URLError(.badURL)
    }
    let request = URLRequest(url: url)

    let (data, response) = try await URLSession.shared.data(for: request)
    if let httpResponse = response as? HTTPURLResponse,
       let contentType = httpResponse.allHeaderFields["Date"] as? String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        let serverTime = dateFormatter.date(from: contentType)
        return serverTime
    }
    return nil
}

/// Prints a date from a website
///
/// - Parameters:
///   - date: Date to print
///   - url: URL from websites
func printDateTime(date: Date, url: Websites) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "CET")
    let dateGet = dateFormatter.string(from: date)
    
    print("Formatted Time: \(dateGet) from: \(url.rawValue)")
}

Task {
    do {
        guard let googleDate = try await getServerTime(url: .Google) else { return }
        guard let appleDate = try await getServerTime(url: .Apple) else { return }
        printDateTime(date: googleDate, url: .Google)
        printDateTime(date: appleDate, url: .Apple)
    } catch {
        print(error)
    }
}
