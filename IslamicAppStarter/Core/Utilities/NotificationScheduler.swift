import Foundation
import UserNotifications

/// مسؤول عن جدولة إشعارات مواقيت الصلاة.
final class NotificationScheduler {
    /// يطلب صلاحية الإشعارات من المستخدم.
    func requestPermission() async throws {
        _ = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
    }

    /// جدولة إشعار لصلاة محددة.
    func schedulePrayerNotification(title: String, body: String, hour: Int, minute: Int, identifier: String) async throws {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        try await UNUserNotificationCenter.current().add(request)
    }
}
