//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## AKAUPeakLimiter
//: ### Exploring the powerful effect of repeating sounds after varying length delay times and feedback amounts
import XCPlayground
import AudioKit

//: Change the source to "mic" to process your voice
let source = "player"

//: This is set-up, the next thing to change is in the next section:
let audiokit = AKManager.sharedInstance
let mic = AKMicrophone()
let bundle = NSBundle.mainBundle()
let file = bundle.pathForResource("PianoBassDrumLoop", ofType: "wav")
let player = AKAudioPlayer(file!)
player.looping = true
let playerWindow: AKAudioPlayerWindow
let peakLimiter: AKAUPeakLimiter

switch source {
case "mic":
    peakLimiter = AKAUPeakLimiter(mic)
default:
    peakLimiter = AKAUPeakLimiter(player)
    playerWindow = AKAudioPlayerWindow(player)
}
//: Set the parameters of the Peak Limiter here
peakLimiter.attackTime = 0.001 // seconds
peakLimiter.decayTime  = 0.01  // seconds
peakLimiter.preGain    = 10 // dB (-40 to 40)

var peakLimiterWindow  = AKAUPeakLimiterWindow(peakLimiter)

audiokit.audioOutput = peakLimiter
audiokit.start()

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
