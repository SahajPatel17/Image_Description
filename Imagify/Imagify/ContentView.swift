import SwiftUI


struct ContentView: View {
    @State private var showingSheet = false
    @StateObject var camera = CameraViewModel()
    @StateObject private var locationViewManager = locationViewModel()
    
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            Text("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .font(.system(size: 45))
            
                    .fontWeight(.medium)
            
            VStack {
            
                CameraPreview(camera: camera)
                    .onReceive(timer){ time in
                        speechRecognizer.stopTranscribing()
                        
                        
                        
                        speechRecognizer.resetTranscript()
                        speechRecognizer.startTranscribing()
                    }
                
                Label("Picture Preview", systemImage:"barcode.viewfinder")
                    .font(.title)
                
                Button {
                    camera.CapturePhoto()
                    let seconds = 2.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                        showingSheet.toggle()
                    }
                } label: {
                    Text("Capture")
                    .frame(width:200, height:100)
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .background(Color.ButtonBackground)
                    .cornerRadius(20)
                }
                .sheet(isPresented: $showingSheet) {
                    ImageDetail(DataFromCamera: DataToImageDetail(city: locationViewManager.city, country: locationViewManager.country, image: camera.capturedImage, text: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia"))
                    
                }
            }
        }
        .onAppear(perform:{camera.Check(); speechRecognizer.resetTranscript(); speechRecognizer.startTranscribing()})
        .ignoresSafeArea()
        .padding()
    }
}


#Preview {
    ContentView()
}
