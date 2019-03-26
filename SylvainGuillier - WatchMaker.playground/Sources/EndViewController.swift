import UIKit
import PlaygroundSupport


public class EndViewController: UIViewController{
    let playAgainButton = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1764705882, alpha: 1)
    }
    
    public override func loadView() {
        super.loadView()
        setupBackgroundImageView()
        setupButton()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.playAgainButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.playAgainButton.transform = CGAffineTransform.identity
                        }
        })
    }
    
    // MARK: Setup
    public func setupBackgroundImageView(){
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFit
        let backgroundImage = UIImage(named: "EndBackground")
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 736, height: 414)
        backgroundImageView.image = backgroundImage
        
        view.addSubview(backgroundImageView)
    }
    
    public func setupButton(){
        playAgainButton.frame = CGRect(x: 736/2-110, y: 324, width: 220, height: 45)
        playAgainButton.contentMode = .scaleAspectFit
        playAgainButton.setImage(UIImage(named: "PlayAgain"), for: .normal)
        playAgainButton.addTarget(self, action: #selector(playAgainButtonPressed), for: .touchUpInside)
        
        view.addSubview(playAgainButton)
    }
    
    // MARK: UIButton function
    @objc public func playAgainButtonPressed(sender:UIButton){
        present(HomeViewController(), animated: false, completion: nil)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
    }
}


