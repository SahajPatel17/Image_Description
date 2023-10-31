import SwiftUI

struct ImageDetail: View {
    @Environment(\.dismiss) var dismiss
    let DataFromCamera: DataToImageDetail
    var body: some View {
        
        
        ZStack {
            Color.black
            
            VStack {
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.white))
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                }
                VStack {
                    Spacer()
                    Image(uiImage: DataFromCamera.image)
                        .resizable()
                        .frame(width:375, height: 450)
                    
                    Spacer().frame(height:25)
                    
                    Text(DataFromCamera.cityCountry)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .frame(alignment: .leading)
                        .padding(.bottom, 0.5)
                    
                    Text(DataFromCamera.DateTaken, format: .dateTime.day().month().year())
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .frame(alignment: .leading)
                        .padding(.bottom, 1)
                    
                    Text(DataFromCamera.textArray)
                        .multilineTextAlignment(.center)
                        .frame(width:325)
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                    Spacer()
                }
            }
        }
    }
}

