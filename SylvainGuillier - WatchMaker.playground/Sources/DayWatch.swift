import PlaygroundSupport

struct DateWatch:WatchProtocol{
    var watchType: WatchType = WatchType.date
    var caseType:WatchCaseType = WatchCaseType.classicCase
}
