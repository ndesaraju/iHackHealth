//
//  BowelSurveyViewController.swift
//  bowelUpdated
//
//  Created by Jennifer Zhou on 2/29/20.
//  Copyright © 2020 Jennifer Zhou. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit

class BowelSurveyViewController: OCKInstructionsTaskViewController, ORKTaskViewControllerDelegate {
        
    // 2. This method is called when the use taps the button!
    override func taskView(_ taskView: UIView & OCKTaskDisplayable, didCompleteEvent isComplete: Bool, at indexPath: IndexPath, sender: Any?) {
        
        // 2a. If the task was uncompleted, fall back on the super class's default behavior or deleting the outcome.
        if !isComplete {
            super.taskView(taskView, didCompleteEvent: isComplete, at: indexPath, sender: sender)
            return
        }
        
        var steps = [ORKStep] ()
        // 2b. If the user attemped to mark the task complete, display a ResearchKit survey.
        let bowelTracking = "Choose the picuture that best matches your situation. Click for a description."
        let emojiTuples = [
          (UIImage(named: "type 1")!, "Seperate hard nuts, hard to pass."),
          (UIImage(named: "type 2")!, "Sausage-shaped but lumpy."),
          (UIImage(named: "type 3")!, "Sausage-like but with cracks."),
          (UIImage(named: "type 4")!, "Sausage/snake-like, smooth and soft."),
          (UIImage(named: "type 5")!, "Soft blob with clear-cut edges."),
          (UIImage(named: "type 6")!, "Fluffy pieces with ragged edges."),
          (UIImage(named: "type 7")!, "Watery, no solid pieces. Entirely liquid.")
        ]
   
        let imageChoices : [ORKImageChoice] = emojiTuples.map {
          return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSString)
        }
        let bowelAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: imageChoices, style: .singleChoice, vertical: true)
        
        let bowelQuestionstep = ORKQuestionStep(identifier: "QuestionStep_IF", title: bowelTracking, answer: bowelAnswerFormat)
        steps += [bowelQuestionstep]
        
        
        let bowelsp = "Choose all that apply to your situation."
        let bowelChoices = [
            ORKTextChoice(text: "Bloody", value: "Bloody" as NSString),
            ORKTextChoice(text: "Oily", value: "Oily" as NSString),
            ORKTextChoice(text: "None of the Above", value: "None of the Above" as NSString)
        ]
        let bowelspAnswerFormat = ORKTextChoiceAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: bowelChoices)
        let bowelspQuestionstep = ORKQuestionStep(identifier: "QuestionStep_SP", title: bowelsp, answer: bowelspAnswerFormat)
        steps += [bowelspQuestionstep]
        
        let BowelTask = ORKOrderedTask(identifier: "bowel survey task", steps: steps)
        let BowelSurveyViewController = ORKTaskViewController(task: BowelTask, taskRun: nil)
        BowelSurveyViewController.delegate = self
        present(BowelSurveyViewController, animated: true, completion: nil)
        
        
    }
    
    // 3. This method will be called when the user completes the survey.
    // Extract the result and save it to CareKit's store!
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
        guard reason == .completed else {
            taskView.completionButton.isSelected = false
            return
        }
        
        // 4a. Retrieve the result from the ResearchKit survey
        let results = taskViewController.result.results
        print(results)
        let survey = results!.first(where: { $0.identifier == "QuestionStep_SP" }) as! ORKStepResult
        
        let painResult = survey.results!.first as! ORKChoiceQuestionResult
        
        var answer = painResult.choiceAnswers![0]
        for a in painResult.choiceAnswers!{
            if (a != nil) {
                answer = a
            }
        }
        print(answer.description)
        // 4b. Save the result into CareKit's store
        controller.appendOutcomeValue(withType: answer.description, at: IndexPath(item: 0, section: 0), completion: nil)
    }
}
