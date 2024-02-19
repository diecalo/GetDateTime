import UIKit

// Allowed websites
enum Websites: String {
    case Google = "https://www.google.com"
    case Apple = "https://www.apple.com"
}

/// Gets the server datetime from the headers of an allowed website using URLSession
///
/// - Parameters:
///   - url: an URL from allowed websites
///   - completionHandler: An optional date if succeded
func getServerTime(url: Websites, completionHandler: @escaping (_ date: Date?) -> Void) {

    guard let url = URL(string: url.rawValue) else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        if let httpResponse = response as? HTTPURLResponse,
            let contentType = httpResponse.allHeaderFields["Date"] as? String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
            let serverTime = dateFormatter.date(from: contentType)
            completionHandler(serverTime)
        }
    }
    task.resume()
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

getServerTime(url: .Google) { (date) -> Void in
    guard let date else { return }

    printDateTime(date: date, url: .Google)
}

getServerTime(url: .Apple) { (date) -> Void in
    guard let date else { return }

    printDateTime(date: date, url: .Apple)
}
