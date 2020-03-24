//
//  
//
//
//  Created by Jennifer Zhou on 2/29/20.
//  Copyright © 2020 Jennifer Zhou. All rights reserved.
//

import CareKit
import ResearchKit
import UIKit
class BowelSurveyViewSynchronizer: OCKInstructionsTaskViewSynchronizer {
   
  // Customize the initial state of the view
  override func makeView() -> OCKInstructionsTaskView {
    let instructionsView = super.makeView()
    instructionsView.completionButton.label.text = "Log Bowel Movements"
    return instructionsView
  }
   
  // Customize how the view updates
  override func updateView(_ view: OCKInstructionsTaskView,
               context: OCKSynchronizationContext<OCKTaskEvents?>) {
    super.updateView(view, context: context)
    let formatter = DateFormatter()
    formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
    let hourString = formatter.string(from: Date()) // "12 AM"
     
    // Check if an answer exists or not and set the detail label accordingly
    if let answer = context.viewModel?.firstEvent?.outcome?.values.first?.integerValue {
      view.headerView.detailLabel.text = "Bowel movements logged at" + hourString
    } else {
      view.headerView.detailLabel.text = "Log your bowel movements"
    }
  }
}
