//  Created by Reet on 2/28/20.
//  Copyright © 2020 Reet Mishra. All rights reserved.

import CareKit
import ResearchKit
import UIKit

class AbPainSurveyViewSynchronizer: OCKInstructionsTaskViewSynchronizer {
    
    // Customize the initial state of the view
    override func makeView() -> OCKInstructionsTaskView {
        let instructionsView = super.makeView()
        instructionsView.completionButton.label.text = "Log Pain"
        return instructionsView
    }
    
    // Customize how the view updates
    override func updateView(_ view: OCKInstructionsTaskView,
                             context: OCKSynchronizationContext<OCKTaskEvents?>) {
        super.updateView(view, context: context)
        
        // Check if an answer exists or not and set the detail label accordingly
        if let answer = context.viewModel?.firstEvent?.outcome?.values.first?.integerValue {
            view.headerView.detailLabel.text = "Pain Rating: \(answer)"
        } else {
            view.headerView.detailLabel.text = "Describe your pain today"
        }
    }
}
