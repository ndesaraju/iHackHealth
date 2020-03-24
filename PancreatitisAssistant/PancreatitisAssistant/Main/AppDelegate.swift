//
//  AppDelegate.swift
//  PancreatitisAssistant
//
//  Created by Reet Mishra on 3/3/20.
//  Copyright © 2020 iHackHealth. All rights reserved.
//

import UIKit
import CareKit
import Contacts
import ResearchKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    // Manages synchronization of a CoreData store
    lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
        let store = OCKStore(name: "MyAppStore")
        store.populateSampleData()
        let manager = OCKSynchronizedStoreManager(wrapping: store)
        return manager
    }()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            window.backgroundColor = UIColor.white
            let nav = UINavigationController()
            let mainView = HomeViewController()
            nav.viewControllers = [mainView]
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
        FirebaseApp.configure()
        
        /*
        let storyboard   = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        let login = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        //let care          = storyboard.instantiateViewController(withIdentifier: "CareViewController")
        let binder = storyboard.instantiateViewController(withIdentifier: "BinderViewController")
        //let symptom          = storyboard.instantiateViewController(withIdentifier: "SymptomViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        let symptom = SymptomTrackerViewController(storeManager: manager)

        
        // Override point for customization after application launch.
        //let tabBarController = UITabBarController()
        //tabBarController.viewControllers = [home, symptom, login, binder]

        //window!.rootViewController = tabBarController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            window.backgroundColor = UIColor.white
            //let nav = UINavigationController()
            //let mainView = tabBarController
            //nav.viewControllers = [mainView]
            let tabBarController = TabBarControllerViewController()
            tabBarController.viewControllers = [home, symptom, login, binder]
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }*/
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
    
    private extension OCKStore {

        // Adds tasks and contacts into the store
        func populateSampleData() {

            let thisMorning = Calendar.current.startOfDay(for: Date())
            let aFewDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: thisMorning)!
            let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: aFewDaysAgo)!
            let day = Calendar.current.date(byAdding: .hour, value: 0, to: aFewDaysAgo)!
            let bedtime = Calendar.current.date(byAdding: .hour, value: 18, to: aFewDaysAgo)!

            let schedule = OCKSchedule(composing: [
                OCKScheduleElement(start: bedtime, end: nil,
                                   interval: DateComponents(day: 1)),
            ])

            var melatonin = OCKTask(id: "melatonin", title: "Take Melatonin",
                                 carePlanID: nil, schedule: schedule)
            melatonin.instructions = "Take 25mg of melatonin before you go to bed."
            
            
            let schoolSchedule = OCKSchedule(composing: [OCKScheduleElement(start: Date(), end: nil, interval: DateComponents(day: 1), text: "Did you miss school?"),
                                                         OCKScheduleElement(start: Date(), end: nil, interval: DateComponents(day: 1), text: "Did you have to leave school early?"),
            OCKScheduleElement(start: Date(), end: nil, interval: DateComponents(day: 1), text: "Did you have to miss any activities?")])
            var school = OCKTask(id: "school", title: "Did you miss school today?", carePlanID: nil, schedule: schoolSchedule)
            school.impactsAdherence = false
            
            let enzymeSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 1))
            ])
            
            var enzyme = OCKTask(id: "enzyme", title: "Track Enzyme",
                                 carePlanID: nil, schedule: enzymeSchedule)
            enzyme.impactsAdherence = false
            enzyme.instructions = "Tap the button below everytime you take your enzymes (everytime you eat)."
            enzyme.tags = ["Breakfast", "Lunch", "Dinner", "Snack"]

            let nauseaSchedule = OCKSchedule(composing: [
                OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 1),
                                   text: "Anytime throughout the day", targetValues: [], duration: .allDay)
                ])

            var nausea = OCKTask(id: "nausea", title: "Track Nausea",
                                 carePlanID: nil, schedule: nauseaSchedule)
            nausea.impactsAdherence = false
            nausea.instructions = "Tap the button below anytime you experience nausea."
            
            
            let abdominalPainSchedule = OCKSchedule(composing: [
                OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 1),
                                   text: "Anytime throughout the day", targetValues: [], duration: .allDay)
            ])
            
            var abdominalPain = OCKTask(id: "ab_pain", title: "Track Abdominal Pain",
                                        carePlanID: nil, schedule: abdominalPainSchedule)
            abdominalPain.impactsAdherence = false;
            abdominalPain.instructions = "Tap the button below anytime you experience nausea on the specific region that it hurts."
            
            
            let scheduleBowel = OCKSchedule(composing: [
                OCKScheduleElement(start: day, end: nil,
                                   interval: DateComponents(day: 1),text: "Seperate hard nuts, hard to pass."),
            ])
            
            var bowellog = OCKTask(id: "bowellog", title: "Track Bowel Movement",
                                 carePlanID: nil, schedule: scheduleBowel)
            bowellog.instructions = "Track your bowel movements. Select the option that best matches your situation and indicate whether it is bloody or oily."
            bowellog.impactsAdherence = true

            self.addTasks([bowellog, nausea, abdominalPain, melatonin, enzyme, school], callbackQueue: .main, completion: nil)
            

            var contact1 = OCKContact(id: "jane", givenName: "Jane",
                                      familyName: "Daniels", carePlanID: nil)
            contact1.asset = "JaneDaniels"
            contact1.title = "Family Practice Doctor"
            contact1.role = "Dr. Daniels is a family practice doctor with 8 years of experience."
            contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "janedaniels@icloud.com")]
            contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(324) 555-7415")]
            contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(324) 555-7415")]

            contact1.address = {
                let address = OCKPostalAddress()
                address.street = "2598 Reposa Way"
                address.city = "San Francisco"
                address.state = "CA"
                address.postalCode = "94127"
                return address
            }()

            var contact2 = OCKContact(id: "matthew", givenName: "Matthew",
                                      familyName: "Reiff", carePlanID: nil)
            contact2.asset = "MatthewReiff"
            contact2.title = "Pancreatitis Physician"
            contact2.role = "Dr. Reiff is an Physician with 13 years of experience."
            contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(324) 555-7415")]
            contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(324) 555-7415")]
            contact2.address = {
                let address = OCKPostalAddress()
                address.street = "396 El Verano Way"
                address.city = "San Francisco"
                address.state = "CA"
                address.postalCode = "94127"
                return address
            }()

            addContacts([contact1, contact2])
        }
    }





