import UIKit
import PlaygroundSupport


public class HomeViewController: UIViewController{
    
    let leftComplication = UIButton()
    let middleComplication = UIButton()
    let rightComplication = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
        Speaker.sharedInstance.speak(string: "Please choose a complication.")
    }
    
    public override func loadView() {
        super.loadView()
        setupBackgroundImageView()
        setupButton()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Animation
        UIView.animate(withDuration: 1.5, animations: {
            self.leftComplication.alpha = 1.0
            self.rightComplication.alpha = 1.0
            self.middleComplication.alpha = 1.0
        })
        
    }
    
    // MARK: Setup
    public func setupBackgroundImageView(){
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFit
        let backgroundImage = UIImage(named: "HomeBackground")
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 736, height: 414)
        backgroundImageView.image = backgroundImage
        view.addSubview(backgroundImageView)
    }
    
    public func setupButton(){
        // Complication buttons
        leftComplication.frame = CGRect(x: 75, y: 190, width: 190, height: 32)
        leftComplication.contentMode = .scaleAspectFit
        let leftImageName = "ChronographComplication"
        leftComplication.setTitle(leftImageName, for: .normal)
        leftComplication.setImage(UIImage(named: leftImageName), for: .normal)
        leftComplication.alpha = 0
        leftComplication.addTarget(self, action: #selector(complicationSelected(_:)), for: .touchUpInside)
        
        middleComplication.frame = CGRect(x: 295, y: 190, width: 140, height: 32)
        middleComplication.contentMode = .scaleAspectFit
        let middleImageName = "ClassicalComplication"
        middleComplication.setTitle(middleImageName, for: .normal)
        middleComplication.setImage(UIImage(named: middleImageName), for: .normal)
        middleComplication.alpha = 0
        middleComplication.addTarget(self, action: #selector(complicationSelected(_:)), for: .touchUpInside)
        
        rightComplication.frame = CGRect(x: 515, y: 190, width: 70, height: 32)
        rightComplication.contentMode = .scaleAspectFit
        let rightImageName = "DateComplication"
        rightComplication.setTitle(rightImageName, for: .normal)
        rightComplication.setImage(UIImage(named: rightImageName), for: .normal)
        rightComplication.alpha = 0
        rightComplication.addTarget(self, action: #selector(complicationSelected(_:)), for: .touchUpInside)
        
        view.addSubview(leftComplication)
        view.addSubview(rightComplication)
        view.addSubview(middleComplication)
        
    }
    
    // MARK: UIButton function
    @objc public func complicationSelected(_ sender:UIButton){
        if let complicationTitle = sender.title(for: .normal){
            WatchManager.sharedInstance.setWatchComplication(complicationTitle: complicationTitle)
            present(WatchMakerViewController(), animated: false, completion: nil)
        }
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
    }
}

