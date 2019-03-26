import UIKit
import  SpriteKit
import PlaygroundSupport

//import AVFoundation


public class WatchMakerViewController: UIViewController{
    
    let headerImageView:UIImageView = UIImageView()
    
    let leftButton :UIButton = UIButton()
    let rightButton : UIButton = UIButton()
    let nextButton:UIButton = UIButton()
    
    let leftComplication:UIButton = UIButton()
    let middleComplication:UIButton = UIButton()
    let rightComplication:UIButton = UIButton()
    
    var watchSKView: SKView = SKView()
    var scene : WatchScene = WatchScene()
    
    var selectedImage :String = String()
    var selectedItemIndex = 1
    
    var watchStep = WatchMakingSteps.caseColor
    
    enum WatchMakingSteps {
        case caseColor
        case bezel
        case bezelNumbers
        case dial
        case dialMarks
        case chronoHands
        case hourHand
        case minuteHand
        case secondHand
        case ready
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        Speaker.sharedInstance.speak(string: "First we need to select a case.")
        
    }
    
    public override func loadView() {
        super.loadView()
        setupWatchScene()
        setupHeaderImage()
        setupButtons()
    }
    
    // MARK: Setup
    
    public func setupHeaderImage(){
        headerImageView.frame = CGRect(x: 736/2 - 439/2, y: 0, width: 439, height: 90)
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.image = UIImage(named: "HeaderTitle/HeaderCase")
        view.addSubview(headerImageView)
    }
    
    public func setupButtons(){
        // Selection buttons
        leftButton.frame = CGRect(x: 10, y: 340/2, width: 59, height: 72)
        leftButton.contentMode = .scaleAspectFit
        leftButton.setImage(UIImage(named: "Left"), for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)
        
        rightButton.frame = CGRect(x: 736-59-10, y: 340/2, width: 59, height: 72)
        rightButton.contentMode = .scaleAspectFit
        rightButton.setImage(UIImage(named: "Right"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
        
        // Next button
        
        nextButton.frame = CGRect(x: 736*0.5 - 125*0.5, y: 358, width: 125, height: 45)
        nextButton.contentMode = .scaleAspectFit
        nextButton.setImage(UIImage(named: "Next"), for: .normal)
        nextButton.addTarget(self, action: #selector(nextWatchMakingStep), for: .touchUpInside)
        
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(nextButton)
        
    }
    
    public func setupWatchScene(){
        watchSKView.frame = CGRect(x: 0, y: 0, width: 736, height: 414)
        watchSKView.backgroundColor = .clear
        scene = WatchScene()
        scene.backgroundColor = .clear
        watchSKView.preferredFramesPerSecond = 60
        watchSKView.presentScene(scene)
        view.addSubview(watchSKView)
    }
    
    public func setupChronographButtons(){
        let chronographButton = UIButton()
        chronographButton.frame = CGRect(x: 0, y: 340/2, width: 225, height: 200)
        chronographButton.contentMode = .scaleAspectFit
        chronographButton.setImage(UIImage(named: "PlayIcon"), for: .normal)
        chronographButton.setImage(UIImage(named: "StopIcon"), for: .selected)
        chronographButton.addTarget(self, action: #selector(chronographButtonPressed(sender:)), for: .touchUpInside)
        view.addSubview(chronographButton)
    }
    
    // MARK: UIButton functions
    @objc public func chronographButtonPressed(sender:UIButton){
        sender.isSelected = !sender.isSelected
        var watch = WatchManager.sharedInstance.userWatch as! ChronographWatch
        watch.resetChronograph()
        watch.changeChronographState()
        WatchManager.sharedInstance.userWatch = watch
    }
    
    @objc public func leftButtonPressed(){
        if selectedItemIndex > 0{
            selectedItemIndex -= 1
            scene.selectedItemIndex = self.selectedItemIndex
        }
        
    }
    
    @objc public func rightButtonPressed(){
        let limit : Int
        if watchStep == .dial{
            limit = WatchManager.sharedInstance.dialNumber-1
        }
        else{
            limit = WatchManager.sharedInstance.colorList.count-1
        }
        if selectedItemIndex < limit{
            selectedItemIndex += 1
            scene.selectedItemIndex = self.selectedItemIndex
        }
        
    }
    
    @objc public func nextWatchMakingStep(){
        Speaker.sharedInstance.stop()
        switch watchStep {
            
        case .caseColor:
            watchStep = .bezel
            Speaker.sharedInstance.speak(string: "Now we need a bezel.")
            headerImageView.image = UIImage(named: "HeaderTitle/HeaderBezel")
            
        case .bezel :
            watchStep = .bezelNumbers
            Speaker.sharedInstance.speak(string: "Select numbers color.")
            
        case .bezelNumbers :
            watchStep = .dial
            headerImageView.image = UIImage(named: "HeaderTitle/HeaderDial")
            Speaker.sharedInstance.speak(string: "Choose a WWDC dial.")
            
        case .dial :
            watchStep = .dialMarks
            Speaker.sharedInstance.speak(string: "Complete your dial.")
            
        case .dialMarks :
            Speaker.sharedInstance.randomSpeak()
            if WatchManager.sharedInstance.userWatch.watchType == .chronograph{
                Speaker.sharedInstance.speak(string: "Select your cronograph hands...")
                watchStep = .chronoHands
            }
            else{
                Speaker.sharedInstance.speak(string: "Select your hour hand...")
                watchStep = .hourHand
            }
            headerImageView.image = UIImage(named: "HeaderTitle/HeaderHands")
            
        case .chronoHands:
            watchStep = .hourHand
            Speaker.sharedInstance.speak(string: "... hour hand...")
            
        case .hourHand:
            watchStep = .minuteHand
            Speaker.sharedInstance.speak(string: "...minute hand...")
            
        case .minuteHand :
            watchStep = .secondHand
            Speaker.sharedInstance.speak(string: "...and second hand.")
            
        case .secondHand :
            watchStep = .ready
            headerImageView.image = UIImage(named: "HeaderTitle/HeaderReady")
            Speaker.sharedInstance.speak(string: "Let's see how it looks !")
            Speaker.sharedInstance.randomSpeak()
            nextButtonSlideAnimation()
            removeLeftRightButton()
            
            if WatchManager.sharedInstance.userWatch.watchType == .chronograph{
                setupChronographButtons()
            }
            
        case .ready :
            Speaker.sharedInstance.speak(string: "Well, I think you're ready for the WWDC, see you there !")
            present(EndViewController(), animated: false, completion: nil)
        }
        selectedItemIndex = 1
        scene.nextStep()
        
    }
    
    public func removeComplicationButtonFromView(){
        leftComplication.removeFromSuperview()
        rightComplication.removeFromSuperview()
        middleComplication.removeFromSuperview()
    }
    
    public func removeLeftRightButton(){
        leftButton.removeFromSuperview()
        rightButton.removeFromSuperview()
    }
    
    // MARK: Animation
    public func nextButtonSlideAnimation(){
        UIView.animate(withDuration: 1, animations: {
            self.nextButton.frame = CGRect(x: 736 - 130, y: 358, width: 125, height: 45)
        })
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
        
    }
    
}





