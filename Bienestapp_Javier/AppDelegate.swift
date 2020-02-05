//
//  AppDelegate.swift
//  Bienestapp_Javier
//
//  Created by alumnos on 10/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Si recibimos una notificación la lanzamos para que aparezca aunque estemos en la app
        completionHandler([.alert, .badge, .sound])
    }

}

