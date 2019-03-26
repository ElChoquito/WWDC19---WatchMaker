import AVFoundation

public class MusicManager {
    public static let sharedInstance = MusicManager()
    var player: AVAudioPlayer?
    
    private init() { }
    
    public func setup() {
        let url = Bundle.main.url(forResource: "Theme", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
    
            player.volume = 0.20
            player.prepareToPlay()
            player.play()
            
        } catch let sessionError {
            print(sessionError)
        }
    }
    
    public func play() {
        player?.play()
    }
    
    public func stop() {
        player?.stop()
        player?.currentTime = 0
        player?.prepareToPlay()
    }
}
