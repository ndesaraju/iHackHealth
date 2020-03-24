//  Created by Reet on 2/28/20.
//  Copyright © 2020 Reet Mishra. All rights reserved.
import CareKit
import UIKit
import ResearchKit

// 1. Subclass a task view controller to customize the control flow and present a ResearchKit survey!
class AbPainSurveyViewController: OCKInstructionsTaskViewController, ORKTaskViewControllerDelegate {
        
    // 2. This method is called when the use taps the button!
    override func taskView(_ taskView: UIView & OCKTaskDisplayable, didCompleteEvent isComplete: Bool, at indexPath: IndexPath, sender: Any?) {
        
        // 2a. If the task was uncompleted, fall back on the super class's default behavior or deleting the outcome.
        if !isComplete {
            super.taskView(taskView, didCompleteEvent: isComplete, at: indexPath, sender: sender)
            return
        }
        
        var steps = [ORKStep] ()
        
        //TODO: add instructions step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Instructions"
        instructionStep.text = "Please answer the following questions about the type of pain you feel today."
        steps += [instructionStep]
        
        //TODO: add description question
        let painSymptomsAnswerFormat = ORKTextAnswerFormat(maximumLength: 100)
        painSymptomsAnswerFormat.multipleLines = true
        let painSymptomsQuestionStepTitle = "Describe the pain you feel today and any symptoms you may be experiencing."
        let painSymptomsQuestionStep = ORKQuestionStep(identifier: "QuestionStep_AF", title: painSymptomsQuestionStepTitle, answer: painSymptomsAnswerFormat)
        steps += [painSymptomsQuestionStep]
        
        //TODO: add slider question
        let painSymptomsScaleAnswerFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1)
        let painSymptomsScaleStepTitle = "Rate your general pain level from a scale of 1 - 10 with 1 meaning no pain and 10 meaning excruiatingly unbearable pain."
        let painSymptomsScaleStep = ORKQuestionStep(identifier: "QuestionStep_SF", title: painSymptomsScaleStepTitle, answer: painSymptomsScaleAnswerFormat)
        steps += [painSymptomsScaleStep]
        
        //TODO: rating abdominal intstruction step
        let instructionStep_abpain = ORKInstructionStep(identifier: "IntroStep2")
        instructionStep_abpain.title = "Rating Abdominal Pain"
        instructionStep_abpain.text = "Please rate your abdominal pain in the following questions."
        instructionStep_abpain.image = UIImage(named: "ab_quadrants.png")
        steps += [instructionStep_abpain]
              
        //TODO: adding abRegion question item
        let abRegionChoices = [
            ORKTextChoice(text: "A. Upper Right Region", value: "Upper Left" as NSString),
            ORKTextChoice(text: "B. Upper Left Region", value: "Upper Right" as NSString),
            ORKTextChoice(text: "C. Lower Right Region", value: "Lower Left" as NSString),
            ORKTextChoice(text: "D. Lower Left Region", value: "Lower Right" as NSString)
        ]
        let abRegionAnswerFormat = ORKTextChoiceAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: abRegionChoices)
        let AbRegionItem = ORKFormItem(identifier: "ab_region", text: "Which abdominal region hurts the most?" + " (Choices are based on picture in previous page)", answerFormat: abRegionAnswerFormat)
        
        //TODO: add emoji question item
        let date = Date()
        let calendar = Calendar.current
        let hr = calendar.component(.hour, from: date)
        var time_of_day = "today"
        if(hr < 12) {
            time_of_day = "morning"
        } else if(hr < 17) {
            time_of_day = "afternoon"
        } else {
            time_of_day = "evening"
        }
        
        let painSymptomsEmojiQuestionStepTitle = "What is your abdominal pain level like this " + time_of_day + "?"
        let emojiTuples = [
            (UIImage(named: "0")!, "0: No pain"),
            (UIImage(named: "2")!, "2: Mild"),
            (UIImage(named: "4")!, "4: Tolerable"),
            (UIImage(named: "6")!, "6: Distressing"),
            (UIImage(named: "8")!, "8: Intense"),
            (UIImage(named: "10")!, "10: Excruciating")
        ]
        let imageChoices : [ORKImageChoice] = emojiTuples.map {
            return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSString)
        }
        let painSymptomsEmojiAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: imageChoices)
   
        let painEmojiItem = ORKFormItem(identifier: "PainEmoji", text: painSymptomsEmojiQuestionStepTitle, answerFormat: painSymptomsEmojiAnswerFormat)
        
        let formStep = ORKFormStep(identifier: "form step", title: "Rating Abdominal Pain", text: nil)
        formStep.formItems = [AbRegionItem, painEmojiItem]
        steps += [formStep]
        
        
        //TODO: add alleviating factors question
        let alleviatingFTitle = "Did you take any of the following medicines to alleviate your pain today?"
        let alleviatingFChoices = [
            ORKTextChoice(text: "Ibuprofen", value: "ibuprofen" as NSString),
            ORKTextChoice(text: "Acetaminophen", value: "acetaminophen" as NSString),
            ORKTextChoice(text: "Opioids", value: "opioids" as NSString),
            ORKTextChoice(text: "None of the Above", value: "None of the Above" as NSString)
        ]
        let alleviatingFAnswerFormat = ORKTextChoiceAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: alleviatingFChoices)
        let alleviatingFStep = ORKQuestionStep(identifier: "alleviatingF", title: alleviatingFTitle, answer: alleviatingFAnswerFormat)
        steps += [alleviatingFStep]
        
        //TODO: add summary step
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Today's Pain Evaluation"
        summaryStep.text = "Keep it up, you got this!"
        steps += [summaryStep]
        
        let surveyTask = ORKOrderedTask(identifier: "pain_survey_task", steps: steps)
        
       // let surveyTask = ORKOrderedTask(identifier: "survey", steps: [painStep])
        let surveyViewController = ORKTaskViewController(task: surveyTask, taskRun: nil)
 
        surveyViewController.delegate = self

        present(surveyViewController, animated: true, completion: nil)
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
        let survey = taskViewController.result.results!.first(where: { $0.identifier == "QuestionStep_SF" }) as! ORKStepResult
        let painResult = survey.results!.first as! ORKScaleQuestionResult
        let answer = Int(truncating: painResult.scaleAnswer!)
        
        // 4b. Save the result into CareKit's store
        controller.appendOutcomeValue(withType: answer, at: IndexPath(item: 0, section: 0), completion: nil)
    }
}
