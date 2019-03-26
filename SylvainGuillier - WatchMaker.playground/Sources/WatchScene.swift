import SpriteKit

public class WatchScene: SKScene{
    
    var leftChoiceNode: SKSpriteNode = SKSpriteNode()
    var rightChoiceNode:SKSpriteNode = SKSpriteNode()
    var middleChoiceNode:SKSpriteNode = SKSpriteNode()
    
    // Base watch nodes
    var watchCaseNode:  SKSpriteNode = SKSpriteNode()
    var watchBezelRingNode:  SKSpriteNode = SKSpriteNode()
    var watchBezelNumbersNode:  SKSpriteNode = SKSpriteNode()
    var watchDialNode:  SKSpriteNode = SKSpriteNode()
    var watchDialMarksNode:  SKSpriteNode = SKSpriteNode()
    var watchHourHandNode:  SKSpriteNode = SKSpriteNode()
    var watchMinuteHandNode:  SKSpriteNode = SKSpriteNode()
    var watchSecondHandNode: SKSpriteNode = SKSpriteNode()
    
    // Date optionnal node
    lazy var watchDateNode: SKLabelNode = SKLabelNode()
    
    // Chronograph optionnal nodes
    lazy var chronographSecondHandNode: SKSpriteNode = SKSpriteNode()
    lazy var chronographMinuteHandNode: SKSpriteNode = SKSpriteNode()
    lazy var chronographHourHandNode: SKSpriteNode = SKSpriteNode()
    
    var watchStep : WatchMakingSteps = WatchMakingSteps.caseColor
    
    var selectedItemIndex = 1{
        didSet{
            updateChoiceNodes()
        }
    }
    
    lazy var chronographTimeSaved = false
    
    var watchIsReadyForAnimation = false
    
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
    
    public override func sceneDidLoad() {
        scene?.scaleMode = .aspectFit
        scene?.backgroundColor = .clear
        scene?.size = CGSize(width: 736, height: 414)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        setupChoiceNode()
        choiceNodeAnimation()
    }
    
    // MARK: Setup
    func setupChoiceNode(){
        
        leftChoiceNode.size = CGSize(width: 196, height: 276)
        //        leftChoiceNode.position = CGPoint(x: -200 , y:0)
        leftChoiceNode.position = CGPoint(x: -400 , y:0)
        leftChoiceNode.setScale(0.7)
        
        rightChoiceNode.size = CGSize(width: 196, height: 276)
        //        rightChoiceNode.position = CGPoint(x: 200, y:0)
        rightChoiceNode.position = CGPoint(x: 400, y:0)
        rightChoiceNode.setScale(0.7)
        
        middleChoiceNode.size = CGSize(width: 196, height: 276)
        //        middleChoiceNode.position = CGPoint(x: 0, y:0)
        middleChoiceNode.position = CGPoint(x: 0, y:414)
        middleChoiceNode.zPosition = 10
        
        
        scene?.addChild(leftChoiceNode)
        scene?.addChild(rightChoiceNode)
        scene?.addChild(middleChoiceNode)
        
        updateChoiceNodes()
    }
    
    func setupChronographHands(){
        let imageName = WatchManager.sharedInstance.getChronographSubHandImageName(at: selectedItemIndex)
        
        let chronographHandsList = [chronographSecondHandNode,chronographMinuteHandNode,chronographHourHandNode]
        
        for hand in chronographHandsList{
            hand.size = CGSize(width: 27, height: 39)
            hand.texture = SKTexture(imageNamed: imageName)
            hand.anchorPoint = CGPoint(x: 0.5, y: 0.35)
            scene?.addChild(hand)
        }
        
        chronographHourHandNode.position = CGPoint(x: -32, y: 7)
        chronographSecondHandNode.position = CGPoint(x: -6, y: -22)
        chronographMinuteHandNode.position = CGPoint(x: 20, y: 7)
        
    }
    
    
    func watchReady(){
        
        watchIsReadyForAnimation = true
        let zoomIn = SKAction.scale(by: 2, duration: 0.5)
        watchCaseNode.run(zoomIn)
        watchCaseNode.position = CGPoint(x: 6, y: -6)
        watchDialNode.run(zoomIn)
        watchDialMarksNode.run(zoomIn)
        watchHourHandNode.run(zoomIn)
        watchBezelRingNode.run(zoomIn)
        watchBezelNumbersNode.run(zoomIn)
        watchMinuteHandNode.run(zoomIn)
        watchSecondHandNode.run(zoomIn)
        
        if WatchManager.sharedInstance.userWatch.watchType == .chronograph{
            chronographSecondHandNode.run(zoomIn)
            chronographMinuteHandNode.run(zoomIn)
            chronographHourHandNode.run(zoomIn)
            
            chronographSecondHandNode.position = CGPoint(x: -6, y: -49)
            chronographMinuteHandNode.position = CGPoint(x: 47, y: 9)
            chronographHourHandNode.position = CGPoint(x: -58, y: 9)
        }
        else if WatchManager.sharedInstance.userWatch.watchType == .date{
            let fadeIn = SKAction.fadeIn(withDuration: 2.0)
            watchDateNode.run(fadeIn)
        }
        
    }
    
    func updateChoiceNodes(){
        switch watchStep {
        case .caseColor:
            let caseImagesFolder = WatchManager.sharedInstance.getWatchCaseImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: caseImagesFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
        case .bezel :
            let bezelImageFolder = WatchManager.sharedInstance.getBezelRingImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: bezelImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
        case .bezelNumbers :
            let bezelNumbersImageFolder = WatchManager.sharedInstance.getBezelNumbersImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: bezelNumbersImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
        case .dial :
            
            let dialImageFolder = WatchManager.sharedInstance.getWatchDialImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: dialImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
        case .dialMarks :
            let dialMarksImageFolder = WatchManager.sharedInstance.getWatchDialMarksImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: dialMarksImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
        case .chronoHands :
            let chronoHandsImageFolder = WatchManager.sharedInstance.getChronoHandsImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: chronoHandsImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
        case .hourHand:
            let hourHandImageFolder = WatchManager.sharedInstance.getWatchHourHandImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: hourHandImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
            
        case .minuteHand :
            let minuteHandImageFolder = WatchManager.sharedInstance.getWatchMinuteHandImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: minuteHandImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
            
        case .secondHand :
            let secondHandImageFolder = WatchManager.sharedInstance.getWatchSecondHandImagesName()
            let newChoices = WatchManager.sharedInstance.getChoiceImages(for: secondHandImageFolder, at: selectedItemIndex)
            updateChoiceNodeTextures(for: newChoices)
            
            
            
        case .ready :
            break
            
        }
    }
    
    func setWatchDate(){
        watchDateNode.fontName = "SFProDisplayBold"
        watchDateNode.position = CGPoint(x: 74, y: 4)
        watchDateNode.horizontalAlignmentMode = .center
        watchDateNode.verticalAlignmentMode = .center
        watchDateNode.fontSize = 22
        watchDateNode.alpha = 0.0
        
        scene?.addChild(watchDateNode)
    }
    
    
    func nextStep(){
        switch watchStep {
            
        case .caseColor:
            copyNodeFor(node: watchCaseNode)
            watchStep = .bezel
            updateChoiceNodeFrame(imageWidth: 171, imageHeight: 171, middleViewXPosition: -6, middleViewYPostion: 5)
            
        case .bezel :
            copyNodeFor(node: watchBezelRingNode)
            watchStep = .bezelNumbers
            updateChoiceNodeFrame(imageWidth: 166, imageHeight: 166, middleViewXPosition: -6, middleViewYPostion: 5)
            
        case .bezelNumbers :
            copyNodeFor(node: watchBezelNumbersNode)
            watchStep = .dial
            updateChoiceNodeFrame(imageWidth: 109, imageHeight: 108, middleViewXPosition: -6, middleViewYPostion: 5)
            
        case .dial :
            copyNodeFor(node: watchDialNode)
            watchStep = .dialMarks
            updateChoiceNodeFrame(imageWidth: 130, imageHeight: 130, middleViewXPosition: -6, middleViewYPostion: 5)
            
            
        case .dialMarks :
            copyNodeFor(node: watchDialMarksNode)
            
            switch WatchManager.sharedInstance.userWatch.watchType{
                
            case .chronograph:
                updateChoiceNodeFrame(imageWidth: 78, imageHeight: 66, middleViewXPosition: -6, middleViewYPostion: -12,anchorPointX: 0.5,anchorPointY: 0.35)
                watchStep = .chronoHands
                
            case .classic:
                updateChoiceNodeFrame(imageWidth: 30, imageHeight: 58, middleViewXPosition: -6, middleViewYPostion: 3,anchorPointX:0.5 ,anchorPointY:0.32)
                watchStep = .hourHand
                
            case .date:
                updateChoiceNodeFrame(imageWidth: 30, imageHeight: 58, middleViewXPosition: -6, middleViewYPostion: 3,anchorPointX:0.5 ,anchorPointY:0.32)
                setWatchDate()
                watchStep = .hourHand
            }
            
            
        case .chronoHands:
            setupChronographHands()
            updateChoiceNodeFrame(imageWidth: 30, imageHeight: 58, middleViewXPosition: -6, middleViewYPostion: 3,anchorPointX:0.5 ,anchorPointY:0.32)
            watchStep = .hourHand
            
        case .hourHand:
            copyNodeFor(node: watchHourHandNode)
            updateChoiceNodeFrame(imageWidth: 26, imageHeight: 77, middleViewXPosition: -6, middleViewYPostion: 4)
            watchStep = .minuteHand
            
            
        case .minuteHand :
            copyNodeFor(node: watchMinuteHandNode)
            watchStep = .secondHand
            updateChoiceNodeFrame(imageWidth: 26, imageHeight: 77, middleViewXPosition: -6, middleViewYPostion: 4)
            
        case .secondHand :
            copyNodeFor(node: watchSecondHandNode)
            
            removeChoiceNodesFromParent()
            watchIsReadyForAnimation = true
            watchReady()
            watchStep = .ready
            
        case .ready :
            removeAllChildren()
            
        }
        selectedItemIndex = 1
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if watchIsReadyForAnimation{
            let date = Date()
            let calendar = Calendar.current
            let hour = CGFloat(calendar.component(.hour, from: date))
            let minute = CGFloat(calendar.component(.minute, from: date))
            let second = CGFloat(calendar.component(.second, from: date))
            let nanosecond = CGFloat(calendar.component(.nanosecond, from: date))
            
            let watchType = WatchManager.sharedInstance.userWatch.watchType
            
            if watchType == .chronograph{
                
                var watch =  WatchManager.sharedInstance.userWatch as! ChronographWatch
                
                if watch.chronographIsInWork{
                    if !chronographTimeSaved{
                        chronographTimeSaved = true
                        watch.setTimeChronographStarted(second: Float(second), minute: Float(minute), hour: Float(hour))
                        
                        WatchManager.sharedInstance.userWatch = watch
                        
                    }
                    // The second hand is use as a chronograph second hand. Substraction in order to define a new starting point for the chronograph hands.
                    watchSecondHandNode.zRotation = -1 * degreesToRadians(((second + nanosecond/pow(10,9))-CGFloat(watch.secondChronographStarted))*6)
                    
                    chronographMinuteHandNode.zRotation = -1 * degreesToRadians( (minute-CGFloat(watch.minuteChronographStarted))/60  - (second - CGFloat(watch.secondChronographStarted))/60)
                    
                    
                    chronographHourHandNode.zRotation = -1 * degreesToRadians( (hour - CGFloat(watch.hourChronographStarted))/30 + (minute - CGFloat(watch.minuteChronographStarted))/2)
                    
                }
                    
                else{
                    chronographTimeSaved = false
                    watchSecondHandNode.zRotation = 0
                    
                    chronographMinuteHandNode.zRotation = 0
                    
                    chronographHourHandNode.zRotation = 0
                    
                }
                
                // The chronograph second hand is use as normal second hand
                chronographSecondHandNode.zRotation = -1 * degreesToRadians((second + nanosecond/pow(10,9))*6)
                
            }
            else{
                watchSecondHandNode.zRotation = -1 * degreesToRadians((second + nanosecond/pow(10,9))*6)
            }
            
            watchMinuteHandNode.zRotation = -1 * degreesToRadians((minute+(second/60))*6)
            watchHourHandNode.zRotation = -1 * degreesToRadians(hour*30 + minute/2)
            
            if watchType == .date{
                watchDateNode.text = String(calendar.component(.day, from: date))
            }
        }
    }
    
    func degreesToRadians(_ number:CGFloat) -> CGFloat{
        return number * .pi/180
    }
    
    func removeChoiceNodesFromParent(){
        leftChoiceNode.removeFromParent()
        middleChoiceNode.removeFromParent()
        rightChoiceNode.removeFromParent()
    }
    
    func copyNodeFor(node:SKSpriteNode){
        
        node.size = middleChoiceNode.size
        node.position = middleChoiceNode.position
        node.anchorPoint = middleChoiceNode.anchorPoint
        let texture = middleChoiceNode.texture
        node.texture = texture
        self.addChild(node)
    }
    
    
    
    func updateChoiceNodeFrame(imageWidth:Double,imageHeight:Double,middleViewXPosition:Double,middleViewYPostion:Double,anchorPointX:Double?=nil,anchorPointY:Double?=nil){
        
        leftChoiceNode.size = CGSize(width: imageWidth, height: imageHeight)
        
        middleChoiceNode.position = CGPoint(x: middleViewXPosition, y: middleViewYPostion)
        middleChoiceNode.size = CGSize(width: imageWidth, height: imageHeight)
        
        rightChoiceNode.size = CGSize(width: imageWidth, height: imageHeight)
        
        if anchorPointX != nil && anchorPointY != nil{
            middleChoiceNode.anchorPoint = CGPoint(x: anchorPointX!, y: anchorPointY!)
            leftChoiceNode.anchorPoint = CGPoint(x: anchorPointX!, y: anchorPointY!)
            rightChoiceNode.anchorPoint = CGPoint(x: anchorPointX!, y: anchorPointY!)
        }
    }
    
    func updateChoiceNodeTextures(for choices:[String]){
        
        let leftImageName = choices[0]
        let middleImageName = choices[1]
        let rightImageName = choices[2]
        
        if !leftImageName.isEmpty{
            leftChoiceNode.isHidden = false
            leftChoiceNode.texture = SKTexture(imageNamed: leftImageName)
        }
        else{
            leftChoiceNode.isHidden = true
        }
        
        if !middleImageName.isEmpty{
            middleChoiceNode.isHidden = false
            middleChoiceNode.texture = SKTexture(imageNamed: middleImageName)
        }
        else{
            middleChoiceNode.isHidden = true
        }
        
        if !rightImageName.isEmpty{
            rightChoiceNode.isHidden = false
            rightChoiceNode.texture = SKTexture(imageNamed: rightImageName)
        }
        else{
            rightChoiceNode.isHidden = true
        }
    }
    
    func choiceNodeAnimation(){
        let middleMove = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.75)
        middleChoiceNode.run(middleMove)
        let leftMove = SKAction.move(to: CGPoint(x: -200, y: 0), duration: 0.75)
        leftChoiceNode.run(leftMove)
        let rightMove = SKAction.move(to: CGPoint(x: 200, y: 0), duration: 0.75)
        rightChoiceNode.run(rightMove)
    }
    
}

