import SwiftUI
import Xscriber

struct ContentView: View {
    @State private var viewModel = RootViewModel()

    var body: some View {
        VStack {
            Button(action: viewModel.transcribeAudio) {
                Label("Transcribe", systemImage: "waveform")
            }
            .disabled(transcriber.isTranscribing)
            
            if transcriber.isSpeechAvailable {
                Text("recognition status: \(transcriber.recognizerStatus)")
            }
    
            Group {
                if transcriber.isTranscribing {
                    Text("transcribing…")
                        .font(.title2)
                } else if let text = transcriber.transcriptionText {
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                }
            }
            .frame(maxWidth: 300)
            .padding(.top, 30)
        }
        .padding()
        .onAppear {
            transcriber.requestPermission()
        }
    }
    
    private var status: Recognizer.Status {
        transcriber.recognizerStatus
    }
    
    private var transcriber: AudioTranscriber {
        viewModel.transcriber
    }
}

#Preview {
    ContentView()
}
