import SwiftUI
import UserNotifications
import CoreLocation


class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options) { success, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("SUCCESS!!!")
                }
            }
    }
    
    func scheduleNotification(name: String) -> String {
        let content = UNMutableNotificationContent()
        content.title = "\(name) ждет общения! ⏰"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 38
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: calendarTrigger)
        UNUserNotificationCenter.current().add(request)
        return request.identifier
    }
    
    func cancelNotification() {
        
        // will cancel any upcoming notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // remove from notification-center
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
