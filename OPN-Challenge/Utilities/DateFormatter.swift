import Foundation

public enum DateFormat: String {
    case HH_mm = "HH:mm"
    case HH_mm_ss_SSSS_Z = "HH:mm:ss.SSS'Z'"
}

public struct DateFormatComponent {
    public static let shareInstance = DateFormatComponent()
    
    public init() { }
    
    public func format(dateString: String, sourcePattern: DateFormat, destinationPattern: DateFormat, calendar: Calendar.Identifier = .buddhist) -> String {
        var formatedDate: String = ""
        if !dateString.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = sourcePattern.rawValue
            
            guard let dateFormat = dateFormatter.date(from: dateString) else {
                return formatedDate
            }
            
            dateFormatter.dateFormat = destinationPattern.rawValue
            formatedDate = dateFormatter.string(from: dateFormat).uppercased()
        }
        return formatedDate
    }
    
}
