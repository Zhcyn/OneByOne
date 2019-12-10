import UIKit
import AVFoundation
import GameKit
class MainViewController: UIViewController {
    var gcEnable = Bool()
    var gcDefaultLeaderboard = String()
    var LeaderboardID = "dodavashki.gs.develop.com"
    @IBOutlet weak var lblEndlessModeScore: UILabel!
    @IBOutlet weak var lblTimerModeBestScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthenticateLocalPlayer()
        submitScore()
        lblEndlessModeScore.text = "Endless Mode Score: \(UserDefaults.standard.integer(forKey: "totalCorrect"))"
        lblTimerModeBestScore.text = "Time Mode Best Score: \(UserDefaults.standard.integer(forKey: "bestCorrect"))"
    }
    override func viewWillAppear(_ animated: Bool) {
        lblEndlessModeScore.text = NSLocalizedString("ENDLESS_MODE", comment: "Endless Mode Score") + ": \(UserDefaults.standard.integer(forKey: "totalCorrect"))"
        lblTimerModeBestScore.text = NSLocalizedString("TIME_MODE", comment: "Time Mode Best Score") + ": \(UserDefaults.standard.integer(forKey: "bestCorrect"))"
    }
    func buttonPresedSoundPlay() {
    }
    @IBAction func gayCenterACTION(_ sender: UIButton) {
        buttonPresedSoundPlay()
        let gcVC : GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self as? GKGameCenterControllerDelegate
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
        gcVC.leaderboardIdentifier = LeaderboardID
        let vc = self.view?.window?.rootViewController
        vc?.present(gcVC, animated: true, completion: nil)
    }
    @IBAction func endlessModeButtonACTION(_ sender: UIButton) {
        buttonPresedSoundPlay()
    }
    @IBAction func timeModeButtonACTION(_ sender: UIButton) {
        buttonPresedSoundPlay()
    }
    func AuthenticateLocalPlayer(){
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil)
            {
                let vc = self.view?.window?.rootViewController
                vc?.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                print("player is already authenticated")
                self.gcEnable = true
                localPlayer.loadDefaultLeaderboardIdentifier( completionHandler: {(leaderboardIdentifer: String?, error: Error?) -> Void in
                    if error != nil {
                        print(error!)
                    } else {
                        self.gcDefaultLeaderboard = leaderboardIdentifer!
                    }
                })
            } else {
                self.gcEnable = false
                print("Local player could not be authenticated, disabling game center")
                print(error!)
            }
        }
    }
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    func submitScore(){
        let sScore = GKScore(leaderboardIdentifier: LeaderboardID)
        sScore.value = Int64(UserDefaults.standard.integer(forKey: "bestCorrect"))
        GKScore.report([sScore], withCompletionHandler: { (error: Error?) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            }
            else
            {
                print("score submitted successfully")
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
