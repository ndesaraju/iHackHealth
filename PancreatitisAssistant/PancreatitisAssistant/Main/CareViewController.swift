//
//  ViewController.swift
//  CareKitOCKSample
//
//  Created by Reet Mishra on 2/19/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit
import CareKit
import Foundation
import ResearchKit

class CareViewController: UIViewController {
    // Manages synchronization of a CoreData store
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarItem.title = "Care"
        tabBarItem.image = UIImage(systemName: "heart.fill")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        //let symptom = SymptomTrackerViewController(storeManager: manager)
        showSymptomViewController()
        //symptom.viewDidLoad()
        //present(SymptomTrackerViewController(storeManager: manager), animated: false)
        //addChild(SymptomTrackerViewController(storeManager: manager))
        //navigationController?.pushViewController(SymptomTrackerViewController(storeManager: manager), animated: true)
        /*
        let team = UIBarButtonItem(title: "Care Team", style: .plain, target: self,
                            action: #selector(presentContactsListViewController))
        let cal = UIBarButtonItem(title: "Function Calendar", style: .plain, target: self,
        action: #selector(presentCalendarViewController))
        navigationItem.rightBarButtonItems = [team, cal]
 */
    
    }
    
    @IBAction func showSymptomViewController() {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        let symptomVC = SymptomTrackerViewController(storeManager: manager)

        present(symptomVC, animated: true)
    }
    
 /*
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 */
    
    
/*
    @objc private func presentContactsListViewController() {
        let viewController = OCKContactsListViewController(storeManager: storeManager)
        viewController.title = "Care Team"
        viewController.isModalInPresentation = true
        viewController.navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Done", style: .plain, target: self,
                            action: #selector(dismissContactsListViewController))

        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func presentCalendarViewController( ){
           let query = OCKEventQuery(dateInterval: DateInterval(start: Date() - 100000000, end: Date() + 10000000))
           storeManager.store.fetchAnyEvents(taskID: "school", query: query, callbackQueue: .main, completion: { result in
               switch result {
               case .failure(let error): print("Error: \(error)")
               case .success(let events):
                   let nextViewController = CalendarViewController()
                   nextViewController.data = events
                   nextViewController.calenderView.storeManager = self.storeManager
                   self.present(nextViewController, animated:true, completion:nil)
               }
           })
    }
    
    @objc private func dismissContactsListViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    // This will be called each time the selected date changes.
    // Use this as an opportunity to rebuild the content shown to the user.

    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController,
                                          prepare listViewController: OCKListViewController, for date: Date) {

        let identifiers = ["melatonin", "nausea", "enzyme", "ab_pain", "bowellog", "school"]
        var query = OCKTaskQuery(for: date)
        query.ids = identifiers
        query.excludesTasksWithNoEvents = true

        storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { result in
            switch result {
            case .failure(let error): print("Error: \(error)")
            case .success(let tasks):

                // Add a non-CareKit view into the list
                let tipTitle = "Quote of the Day"
                let tipText = "Balance is not something you find, it's something you create. ~Jana Kingsford"

                // Only show the tip view on the current date
                if Calendar.current.isDate(date, inSameDayAs: Date()) {
                    let tipView = TipView()
                    tipView.headerView.titleLabel.text = tipTitle
                    tipView.headerView.detailLabel.text = tipText
                    tipView.imageView.image = UIImage(named: "Mountains")
                    listViewController.appendView(tipView, animated: false)
                }

                if let melatoninTask = tasks.first(where: { $0.id == "melatonin" }) {
                    let melatoninCard = OCKChecklistTaskViewController(task: melatoninTask, eventQuery: .init(for: date),
                                                                        storeManager: self.storeManager)
                    listViewController.appendViewController(melatoninCard, animated: false)
                }
                
                
                if let enzymeTask = tasks.first(where: { $0.id == "enzyme" }) {
                  
                    let enzymeGradientStart = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1) : #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1)
                     //   return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 109.0/256, green: 158.0/256, blue: 250.0/256, alpha: 1): #colorLiteral(red: 109.0/256, green: 158.0/256, blue: 250.0/256, alpha: 1)
                    }
                    let enzymeGradientEnd = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1) : #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1)
                    }
 
                    let melatoninGradientStart = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1) : #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1)
                    }
                    let melatoninGradientEnd = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1) : #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1)
                    }
                    
                    
                    let melatoninDataSeries = OCKDataSeriesConfiguration(
                        taskID: "melatonin",
                        legendTitle: "Melatonin",
                        gradientStartColor: melatoninGradientStart,
                        gradientEndColor: melatoninGradientEnd,
                        markerSize: 10,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)
                    
                    let enzymeDataSeries = OCKDataSeriesConfiguration(
                        taskID: "enzyme",
                        legendTitle: "Enzyme",
                        gradientStartColor: enzymeGradientStart,
                        gradientEndColor: enzymeGradientEnd,
                        markerSize: 10,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)
                    
                    let insightsCard = OCKCartesianChartViewController(plotType: .bar, selectedDate: date,
                                                                       configurations: [melatoninDataSeries, enzymeDataSeries],
                                                                       storeManager: self.storeManager)
                    insightsCard.chartView.headerView.titleLabel.text = "Melatonin & Enzyme Intake"
                    insightsCard.chartView.headerView.detailLabel.text = "This Week"
                    insightsCard.chartView.headerView.accessibilityLabel = "Enzyme & Melatonin Intake, This Week"
                    listViewController.appendViewController(insightsCard, animated: false)
                    
                    let enzymeCard = OCKButtonLogTaskViewController(task: enzymeTask, eventQuery: .init(for: date),
                                                                    storeManager: self.storeManager)
                    listViewController.appendViewController(enzymeCard, animated: false)
                }
                
                if let schoolTask = tasks.first(where: { $0.id == "school" }) {
                    let schoolCard = OCKChecklistTaskViewController(task: schoolTask, eventQuery: .init(for: date),
                                                                 storeManager: self.storeManager)
                    
                    listViewController.appendViewController(schoolCard, animated: false)
                }
                
                
                if let nauseaTask = tasks.first(where: { $0.id == "nausea" }) {
                    let nauseaCard = OCKButtonLogTaskViewController(task: nauseaTask, eventQuery: .init(for: date),
                                                                    storeManager: self.storeManager)
                    
                    listViewController.appendViewController(nauseaCard, animated: false)
                }
                
                // Create a card for the ab_pain task if there are events for it on this day.
                // Its OCKSchedule was defined to have daily events, so this task should be
                // found in `tasks` every day after the task start date.
                
               
                if let abpainTask = tasks.first(where: { $0.id == "ab_pain" }) {

                   
                    // dynamic gradient colors
                    
                    let abpainGradientStart = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1) : #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1)
                    }
                    let abpainGradientEnd = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1) : #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1)
                    }
                    
                    let nauseaGradientStart = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1) : #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1)
                    }
                    let nauseaGradientEnd = UIColor { traitCollection -> UIColor in
                        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1) : #colorLiteral(red: 0.9937962735, green: 0.7904322768, blue: 0.12937358, alpha: 1)
                    }
                                        
                    
                    // Create a plot comparing nausea to medication adherence.
                    let abPainDataSeries = OCKDataSeriesConfiguration(
                        taskID: "ab_pain",
                        legendTitle: "Abdominal Pain",
                        gradientStartColor: abpainGradientStart,
                        gradientEndColor: abpainGradientEnd,
                        markerSize: 10,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)
                    
                    let nauseaPainDataSeries = OCKDataSeriesConfiguration(
                        taskID: "nausea",
                        legendTitle: "Feeling Nauseas",
                        gradientStartColor: nauseaGradientStart,
                        gradientEndColor: nauseaGradientEnd,
                        markerSize: 10,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)

                    /*
                    let enzymeDataSeries = OCKDataSeriesConfiguration(
                        taskID: "enzyme",
                        legendTitle: "Enzymes Taken",
                        gradientStartColor: .systemGray2,
                        gradientEndColor: .systemGray,
                        markerSize: 10,
                        eventAggregator: OCKEventAggregator.countOutcomeValues)*/

                    
                    let insightsCard = OCKCartesianChartViewController(plotType: .bar, selectedDate: date,
                                                                       configurations: [abPainDataSeries, nauseaPainDataSeries],
                                                                       storeManager: self.storeManager)
                    insightsCard.chartView.headerView.titleLabel.text = "Abdominal Pain & Nausea"
                    insightsCard.chartView.headerView.detailLabel.text = "This Week"
                    insightsCard.chartView.headerView.accessibilityLabel = "Abdominal Pain & Nausea, This Week"
                    listViewController.appendViewController(insightsCard, animated: false)

                    let abPainCard = AbPainSurveyViewController(viewSynchronizer: AbPainSurveyViewSynchronizer(),taskID: "ab_pain", eventQuery: OCKEventQuery(for: Date()), storeManager: self.storeManager)
                    
                    
                    listViewController.appendViewController(abPainCard, animated: true)
                
                }
                
                if let bowellogTask = tasks.first(where: { $0.id == "bowellog" }) {
                    let bowellogCard = BowelSurveyViewController(viewSynchronizer: BowelSurveyViewSynchronizer(), task: bowellogTask, eventQuery: .init(for: date),
                                                                        storeManager: self.storeManager)
                    listViewController.appendViewController(bowellogCard, animated: false)
                }
            }
        }
    }
 */
}


