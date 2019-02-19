import UIKit

func getServerTime(completionHandler: @escaping (_ getResDate: Date?) -> Void) {
    
    guard let url = URL(string: "https://www.google.com") else { return }
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

getServerTime { (getResDate) -> Void in
    guard let date = getResDate else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "CET")
    let dateGet = dateFormatter.string(from: date)

    print("Formatted Time: \(dateGet)")
}

