import UIKit
import AudioToolbox
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblTotalCorrect: UILabel!
    @IBOutlet weak var lblCorrectIncorrect: UILabel!
    @IBOutlet weak var btnAnswer0: UIButton!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    var firstNumber = 0
    var secondNumber = 0
    var answer = 0
    var correctIncorrect = ""
    var buttonRandom = 0
    var totalCorrect = 0
    var incorrectAnswer1 = 0
    var incorrectAnswer2 = 0
    var incorrectAnswer3 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        randomizeTheNumbers()
        printButtonText()
        printStats()
        lblCorrectIncorrect.text = "\(NSLocalizedString("CORRECT_INCORRECT", comment: "Correct / Incorrect"))"
    }
    func buttonPresedSoundPlay() {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnAnswer0ACTION(_ sender: UIButton) {
        if buttonRandom == 0 {
            button0Correct()
        }else if buttonRandom != 0 {
            incorrectAnswer()
        }
        randomizeTheNumbers()
        printButtonText()
    }
    @IBAction func btnAnswer1ACTION(_ sender: UIButton) {
        if buttonRandom == 1 {
            button1Correct()
        }else if buttonRandom != 1 {
            incorrectAnswer()
        }
        randomizeTheNumbers()
        printButtonText()
    }
    @IBAction func btnAnswer2ACTION(_ sender: UIButton) {
        if buttonRandom == 2 {
            button2Correct()
        }else if buttonRandom != 2 {
            incorrectAnswer()
        }
        randomizeTheNumbers()
        printButtonText()
    }
    @IBAction func btnAnswer3ACTION(_ sender: UIButton) {
        if buttonRandom == 3 {
            button3Correct()
        }else if buttonRandom != 3 {
            incorrectAnswer()
        }
        randomizeTheNumbers()
        printButtonText()
    }
    @IBAction func btnResetACTION(_ sender: UIButton) {
        resetButton()
        buttonPresedSoundPlay()
    }
    func randomizeTheNumbers(){
        firstNumber = Int(arc4random_uniform(9))
        secondNumber = Int(arc4random_uniform(9))
        answer = firstNumber + secondNumber
        buttonRandom = Int(arc4random_uniform(4))
        incorrectAnswer1 = Int(arc4random_uniform(15))
        incorrectAnswer2 = Int(arc4random_uniform(9))
        incorrectAnswer3 = Int(arc4random_uniform(7))
        checkTheRandom()
        printTheQuestion()
    }
    func checkTheRandom(){
        if answer == incorrectAnswer1 || answer == incorrectAnswer2 || incorrectAnswer1 == incorrectAnswer2  || answer == incorrectAnswer3 {
            incorrectAnswer1 = Int(arc4random_uniform(15))
            incorrectAnswer2 = Int(arc4random_uniform(9))
            incorrectAnswer3 = Int(arc4random_uniform(7))
            if answer == incorrectAnswer1 || answer == incorrectAnswer2 || answer == incorrectAnswer3 {
                incorrectAnswer1 = 20
                incorrectAnswer2 = 25
                incorrectAnswer3 = 19
            }
        }
    }
    func printTheQuestion(){
        lblQuestion.text = "\(firstNumber) + \(secondNumber) = ?"
    }
    func printButtonText(){
        if buttonRandom == 0 {
            btnAnswer0.setTitle("\(answer)", for: .normal)
            btnAnswer1.setTitle("\(incorrectAnswer1)", for: .normal)
            btnAnswer2.setTitle("\(incorrectAnswer2)", for: .normal)
            btnAnswer3.setTitle("\(incorrectAnswer3)", for: .normal)
        }
        if buttonRandom == 1 {
            btnAnswer1.setTitle("\(answer)", for: .normal)
            btnAnswer0.setTitle("\(incorrectAnswer1)", for: .normal)
            btnAnswer2.setTitle("\(incorrectAnswer3)", for: .normal)
            btnAnswer3.setTitle("\(incorrectAnswer2)", for: .normal)
        }
        if buttonRandom == 2 {
            btnAnswer2.setTitle("\(answer)", for: .normal)
            btnAnswer1.setTitle("\(incorrectAnswer3)", for: .normal)
            btnAnswer0.setTitle("\(incorrectAnswer1)", for: .normal)
            btnAnswer3.setTitle("\(incorrectAnswer2)", for: .normal)
        }
        if buttonRandom == 3 {
            btnAnswer3.setTitle("\(answer)", for: .normal)
            btnAnswer1.setTitle("\(incorrectAnswer2)", for: .normal)
            btnAnswer2.setTitle("\(incorrectAnswer1)", for: .normal)
            btnAnswer0.setTitle("\(incorrectAnswer3)", for: .normal)
        }
    }
    func incorrectAnswer(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        UIView.animate(withDuration: 0.8, animations: {
            self.view.backgroundColor = UIColor.red
            UIView.animate(withDuration: 0.8, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
        }, completion: nil)
        correctIncorrect = "\(NSLocalizedString("INCORRECT", comment: "Incorrect"))"
        totalCorrect = totalCorrect - 1
        saveBestScore()
        printStats()
    }
    func button0Correct(){
        correctLogic()
    }
    func button1Correct(){
        correctLogic()
    }
    func button2Correct(){
        correctLogic()
    }
    func button3Correct(){
        correctLogic()
    }
    func correctLogic(){
        UIView.animate(withDuration: 0.8, animations: {
            self.view.backgroundColor = UIColor.green
            UIView.animate(withDuration: 0.8, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
        }, completion: nil)
        totalCorrect = totalCorrect + 1
        saveBestScore()
        correctIncorrect = "\(NSLocalizedString("CORRECT", comment: "Correct"))"
        printStats()
    }
    func saveBestScore(){
        if totalCorrect > 0 {
            UserDefaults.standard.setValue(totalCorrect, forKey: "totalCorrect")
            UserDefaults.standard.synchronize()
        }
    }
    func printStats(){
        totalCorrect = UserDefaults.standard.integer(forKey: "totalCorrect")
        lblTotalCorrect.text = NSLocalizedString("SCORE", comment: "Score") + ": \(totalCorrect)"
        lblCorrectIncorrect.text = "\(correctIncorrect)"
    }
    func resetButton(){
        totalCorrect = 0
        UserDefaults.standard.removeObject(forKey: "totalCorrect")
        lblTotalCorrect.text = NSLocalizedString("SCORE", comment: "Score") + ": \(totalCorrect)"
        lblCorrectIncorrect.text = "\(NSLocalizedString("CORRECT_INCORRECT", comment: "Correct / Incorrect"))"
        randomizeTheNumbers()
    }
}
