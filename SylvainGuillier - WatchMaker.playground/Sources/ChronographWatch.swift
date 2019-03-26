import PlaygroundSupport

struct ChronographWatch:WatchProtocol{
    var watchType: WatchType = WatchType.chronograph
    var caseType:WatchCaseType = WatchCaseType.chronographCase
    
    var secondChronographStarted: Float = 0
    var minuteChronographStarted: Float = 0
    var hourChronographStarted: Float = 0
    var chronographIsInWork = false
    
    mutating func setTimeChronographStarted(second:Float,minute:Float,hour:Float){
        secondChronographStarted = second
        minuteChronographStarted = minute
        hourChronographStarted = hour
    }
    
    mutating func changeChronographState(){
        chronographIsInWork = !chronographIsInWork
    }
    
    mutating func resetChronograph(){
        secondChronographStarted = 0
        minuteChronographStarted = 0
        hourChronographStarted = 0
    }
}
