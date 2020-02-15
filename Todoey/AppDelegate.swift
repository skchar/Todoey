//
//  AppDelegate.swift
//  Todoey
//
//  Created by Char Shu Kai on 13/2/2020.
//  Copyright © 2020 Char Shu Kai. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        do {
            _ = try Realm()
         }catch{
            print("Error initialising new realm  \(error)")
        }
        return true
    }

   

}

