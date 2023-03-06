//
//  ViewController.swift
//  BullsEye
//
//  Created by Aisha Nurgaliyeva on 01.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var targetValue = 0
    var currentValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
      super.viewDidLoad()
      resetRound()
        
      let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
      slider.setThumbImage(thumbImageNormal, for: .normal)
      let thumbImageHighlighted = UIImage(
        named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)
      let trackLeftImage = UIImage(named: "SliderTrackLeft")!
      let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
      let trackRightImage = UIImage(named: "SliderTrackRight")!
      let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound() {
      round += 1
      targetValue = Int.random(in: 1...100)
      currentValue = 50
      slider.value = Float(currentValue)
      updateLabels()
    }
    func updateLabels() {
      targetLabel.text = String(targetValue)
      scoreLabel.text = String(score)
      roundLabel.text = String(round)
    }

    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    
    @IBAction func showAlert() {
      let difference = abs(targetValue - currentValue)
      var points = 100 - difference
        
      let title: String
          if difference == 0 {
            title = "Perfect!"
            points += 100
          } else if difference < 5 {
            title = "You almost had it!"
              if difference == 1{
                  points += 50
              }
          } else if difference < 10 {
            title = "Pretty good!"
          } else {
            title = "Not even close..."
          }
        score += points
        
      let message = "The current value is: \(currentValue)" +
                    "\nYou scored \(points) points"
        
      let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
      let action = UIAlertAction(
          title: "OK",
          style: .default,
          handler: { _ in
            self.startNewRound()
          })
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
        }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
      currentValue = lroundf(slider.value)
    }
    
    @IBAction func resetRound() {
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
    }
}

