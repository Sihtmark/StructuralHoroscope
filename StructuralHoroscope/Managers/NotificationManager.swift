import SwiftUI
import UserNotifications
import CoreLocation


class NotificationManager {
    
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
    
    func scheduleNotification(contact: ContactStruct, year: Int, month: Int, day: Int) {
        let content = UNMutableNotificationContent()
        content.title = "\(contact.name) ждет общения! ⏰"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 9
        dateComponents.minute = 15
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: contact.id.uuidString,
            content: content,
            trigger: calendarTrigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(id: UUID) {
        
        // will cancel any upcoming notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        
        // remove from notification-center
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id.uuidString])
    }
}
