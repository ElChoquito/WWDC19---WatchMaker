import  AVFoundation

public class Speaker{
    public static let sharedInstance = Speaker()
    let speaker : AVSpeechSynthesizer
    var wordsList : [String]
    
    private init() {
        speaker = AVSpeechSynthesizer()
        wordsList = ["Nice one !","Perfect match !","Love it !","You have taste !","Gorgeous !","I think you made the right choice !","It's beautiful !","Wonderful !"]
    }
    
    public func speak(string: String){
        let speechUtterance = AVSpeechUtterance(string: string)
        speaker.speak(speechUtterance)
    }
    
    public func randomSpeak(){
        if !wordsList.isEmpty{
            let randomNumber = Int.random(in: 0 ..< wordsList.count)
            speak(string: wordsList[randomNumber])
            wordsList.remove(at: randomNumber)
        }
    }
    
    public func stop(){
        speaker.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
}

