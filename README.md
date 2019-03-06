# GetDateTime playground concept 

Get the DateTime from Google or Apple website headers

Here are the allowed websites:

    enum Websites: String {
        case Google = "https://www.google.com"
        case Apple = "https://www.apple.com"
    }

Calling this method, you have the date object if communication succeded. This method uses URLSession. 

    getServerTime(url: .Google) { (getResDate) -> Void in
        guard let date = getResDate else { return }

        printDateTime(date: date, url: .Google)
    }

    getServerTime(url: .Apple) { (getResDate) -> Void in
        guard let date = getResDate else { return }

        printDateTime(date: date, url: .Apple)
    }

And the output calling printDateTime func prints the date formated to CET timezone: 

    Formatted Time: 06-03-2019 13:45:29 from: https://www.google.com
    Formatted Time: 06-03-2019 13:45:29 from: https://www.apple.com
