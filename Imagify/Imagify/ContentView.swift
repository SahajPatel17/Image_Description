import SwiftUI


struct ContentView: View {
    @State private var showingSheet = false
    @StateObject var camera = CameraViewModel()
    @StateObject private var locationViewManager = locationViewModel()
    
    @State var speechText: String = " "
    @State var previousSpeechText: String = " "
    @StateObject var speechRecognizer = SpeechRecognizer()
    var timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    
    @EnvironmentObject var historyContent: History
    
    func buttonCameraCommand(){
        camera.CapturePhoto()
        let speechseconds = 1.25
        DispatchQueue.main.asyncAfter(deadline: .now() + speechseconds) {
            showingSheet.toggle()
            historyContent.push(item: DataToImageDetail(city: locationViewManager.city, country: locationViewManager.country, image: camera.capturedImage, text: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia"))
        }
    }
    func voiceCameraCommand(){
        speechRecognizer.stopTranscribing()
            
        speechText = speechRecognizer.transcript
            
        if (speechText.contains("assistant") || previousSpeechText.contains("assistant")) && (speechText.contains("picture")){
            buttonCameraCommand()
        }
            
        previousSpeechText = speechText
        speechText = ""
        speechRecognizer.flushTranscript()
        speechRecognizer.startTranscribing()
    }
    
    var body: some View {
        NavigationStack {
            Text("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .font(.system(size: 45))
                    .fontWeight(.medium)
            
            VStack {
            
                CameraPreview(camera: camera)
                
                Label("Picture Preview", systemImage:"barcode.viewfinder")
                    .font(.title)
                
                Button {
                    buttonCameraCommand()
                } label: {
                    Text("Capture")
                    .frame(width:200, height:100)
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .background(Color.ButtonBackground)
                    .cornerRadius(20)
                }
                .onReceive(timer){ time in
                    if (showingSheet == true){
                        speechRecognizer.stopTranscribing()
                            
                        speechText = speechRecognizer.transcript
                            
                        if (speechText.contains("home") || speechText.contains("Home")){
                            showingSheet.toggle()
                        }
                            
                        speechText = ""
                        speechRecognizer.flushTranscript()
                        speechRecognizer.startTranscribing()
                    } else {
                        voiceCameraCommand()
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    ImageDetail(DataFromCamera: DataToImageDetail(city: locationViewManager.city, country: locationViewManager.country, image: camera.capturedImage, text: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia"))
            
                }
            }
        }
        .environmentObject(historyContent)
        .onAppear(perform:{camera.Check(); speechRecognizer.resetTranscript(); speechRecognizer.startTranscribing()})
        .ignoresSafeArea()
        .padding()
    }
}


#Preview {
    ContentView()
}
