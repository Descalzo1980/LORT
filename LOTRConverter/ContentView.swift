import SwiftUI

struct ContentView: View {
    @State var showExchangeInfo = false
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                //.aspectRatio(1/2, contentMode: .fit)
                    .frame(height: 200)
                Text("Currency Exchange")
                    .font(.title)
                    .foregroundColor(.white)
                //Spacer()
                HStack {
                    VStack {
                        HStack {
                            Image(.silverpiece)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            Text("Silver Piece")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Text("Text field")
                    }
                    
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    //.symbolEffect(.pulse)
                    
                    VStack {
                        HStack {
                            Text("Gold Piece")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(.goldpiece)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        Text("Text field")
                    }
                }
                Spacer()
                HStack() {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                        //                    print("showExchangeInfo value: \(showExchangeInfo)")
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }.border(.blue)
            }
            //.border(.blue)
        }
    }
}

#Preview {
    ContentView()
}
