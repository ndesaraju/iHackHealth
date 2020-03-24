//
//  SymptomTrackerViewController.swift
//  PancreatitisAssistant
//
//  Created by Reet Mishra on 3/4/20.
//  Copyright © 2020 iHackHealth. All rights reserved.
//

import Foundation
import CareKit
import UIKit
import ResearchKit

class SymptomTrackerViewController: OCKDailyPageViewController {
    
    /*
    override init(storeManager: OCKSynchronizedStoreManager, adherenceAggregator: OCKAdherenceAggregator = .compareTargetValues) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        super.init(storeManager: manager)
    }
    */
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        window?.tintColor = UIColor(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        self.view.tintColor = UIColor(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        //navigationController?.delegate = self.delegate as! UINavigationControllerDelegate
        tabBarItem.title = "Care"
        tabBarItem.image = UIImage(systemName: "heart.fill")
        let team = UIBarButtonItem(title: "Care Team", style: .plain, target: self,
                            action: #selector(presentContactsListViewController))
        //let font = UIFont.systemFont(ofSize: 12)
      //  team.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 10)!], for: .normal)
        let cal = UIBarButtonItem(title: "Function Calendar", style: .plain, target: self,
        action: #selector(presentCalendarViewController))
        //let topview = UIView(frame: CGRect(x:0,y:0,width:400,height:10))
        //self.view.addSubview(topview)
        //self.view.bringSubviewToFront(topview)
        //let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 400, height: 0.5))
        //navBar.tintColor = UIColor(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
       // self.view.addSubview(navBar)
        //let navitem = UINavigationItem()
        navigationItem.rightBarButtonItems = [team, cal]
        //navigationController?.navigationBar.setItems(navigationController?.navigationBar.items, animated: true)
        //navitem.leftBarButtonItems = [team, cal]
       // navBar.setItems([navitem], animated: true)
        
    }
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
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                        //   return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 109.0/256, green: 158.0/256, blue: 250.0/256, alpha: 1): #colorLiteral(red: 109.0/256, green: 158.0/256, blue: 250.0/256, alpha: 1)
                       }
                       let enzymeGradientEnd = UIColor { traitCollection -> UIColor in
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                       }
    
                       let melatoninGradientStart = UIColor { traitCollection -> UIColor in
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                       }
                       let melatoninGradientEnd = UIColor { traitCollection -> UIColor in
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
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
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                       }
                       let abpainGradientEnd = UIColor { traitCollection -> UIColor in
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                       }
                       
                       let nauseaGradientStart = UIColor { traitCollection -> UIColor in
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                       }
                       let nauseaGradientEnd = UIColor { traitCollection -> UIColor in
                           return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
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
}
