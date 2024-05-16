import Foundation
import Xscriber

@Observable
final class RootViewModel {
    var isAvailable = false
    var transcriber: AudioTranscriber
    var error: Error?
    
    init() {
        do {
            transcriber = try AudioFileTranscriber()
        } catch {
            print("Error initializing AudioTranscriber: \(error.localizedDescription)")
            guard let transcriber = try? DoNothingAudioTranscriber() else {
                fatalError("Unable to initialize AudioTranscriber")
            }
            
            self.transcriber = transcriber
        }
    }
    
    func transcribeAudio() {
        print("Transcribe button tapped")
        
        guard let fileURL = Bundle.main.url(forResource: "01", withExtension: "aif") else {
            print("  unable to determine file URL")
            return
        }
        
        print("file URL: \(fileURL.path())")
        do {
            try transcriber.transcribe(fileURL: fileURL)
        } catch {
            self.error = error
        }
    }
}
