import Foundation
import PlaygroundSupport

public class WatchManager {
    public static let sharedInstance = WatchManager()
    var userWatch : WatchProtocol
    var colorList : [String] = ["red","orange","green","blue","pink","white"]
    var dialNumber : Int = 4
    
    private init() {
        userWatch = ClassicalWatch()
    }
    
    func setWatchComplication(complicationTitle:String){
        if complicationTitle == "DateComplication"{
            userWatch = DateWatch()
            
        }
        else if complicationTitle == "ChronographComplication" {
            userWatch = ChronographWatch()
            
        }
        else{
            userWatch = ClassicalWatch()
        }
    }
    
    
    func getWatchCaseImagesName()->String{
        let result : String
        if userWatch.caseType == .chronographCase{
            result = "Watch/Case/ChronographCase_"
        }
        else{
            result = "Watch/Case/ClassicCase_"
        }
        
        return result
    }
    
    func getBezelRingImagesName() -> String{
        return ("Watch/BezelRing/BezelRing_")
    }
    
    func getBezelNumbersImagesName()->String{
        return ("Watch/BezelNumbers/BezelNumbers_")
    }
    
    func getWatchDialImagesName()->String{
        return("Watch/DialBackground/DialBackground_")
    }
    
    func getWatchDialMarksImagesName()->String{
        switch userWatch.watchType {
        case .chronograph:
            return("Watch/DialMarks/DialMarksChrono_")
        case .classic:
            return("Watch/DialMarks/DialMarks_")
        case .date:
            return("Watch/DialMarks/DialMarksDate_")
        }
        
    }
    
    
    func getWatchHourHandImagesName()->String{
        return ("Watch/HourHand/HourHand_")
    }
    
    func getWatchMinuteHandImagesName()->String{
        return ("Watch/MinuteHand/MinuteHand_")
    }
    
    func getWatchSecondHandImagesName()->String{
        return ("Watch/SecondHand/SecondHand_")
    }
    
    
    func getChoiceImages(for title:String,at index:Int)->[String]{
        var leftImage = String()
        var middleImage = String()
        var rightImage = String()
        
        
        let leftIndex = index-1
        let rightIndex = index+1
        if title == getWatchDialImagesName(){
            if leftIndex >= 0 && leftIndex < dialNumber{
                leftImage = title + String(leftIndex)
            }
            if rightIndex < dialNumber{
                rightImage = title + String(rightIndex)
            }
            
            middleImage = title + String(index)
        }
        else{
            if leftIndex >= 0 && leftIndex < colorList.count{
                leftImage = title + colorList[leftIndex]
            }
            if rightIndex < colorList.count{
                rightImage = title + colorList[rightIndex]
            }
            
            middleImage = title + colorList[index]
        }
        
        return [leftImage,middleImage,rightImage]
        
    }
    
    public func getChronoHandsImagesName()->String{
        return "Watch/ChronoHands/ChronoHands_"
    }
    
    public func getChronographSubHandImageName(at index:Int)-> String{
        return "Watch/SubHand/SubHand_\(colorList[index])"
    }
    
}
