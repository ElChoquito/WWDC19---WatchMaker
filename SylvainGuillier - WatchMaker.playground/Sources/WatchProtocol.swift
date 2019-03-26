import PlaygroundSupport

protocol WatchProtocol{
    var watchType: WatchType {get set}
    var caseType:WatchCaseType {get set}
}

enum WatchCaseType{
    case classicCase
    case chronographCase
}

enum WatchType{
    case classic
    case chronograph
    case date
}


