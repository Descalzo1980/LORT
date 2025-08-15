import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
                .onTapGesture {
                    leftTyping = false
                    rightTyping = false
                }
            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Text("Currency Exchange")
                    .font(.title)
                    .foregroundColor(.white)
                HStack {
                    CurrencyInputView(
                        amount: $leftAmount,
                        currency: $leftCurrency,
                        isTyping: $leftTyping
                        
                    ) {
                        showSelectCurrency.toggle()
                    }
                    
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    CurrencyInputView(
                        amount: $rightAmount,
                        currency: $rightCurrency,
                        isTyping: $rightTyping,
                        textAlignment: .trailing
                    ) {
                        showSelectCurrency.toggle()
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                Spacer()
                HStack() {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }
            }
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
    }
}

#Preview {
    ContentView()
}

struct CurrencyInputView: View {
    @Binding var amount: String
    @Binding var currency: Currency
    @FocusState.Binding var isTyping: Bool
    var textAlignment: TextAlignment = .leading
    var onTapCurrency: () -> Void

    
    var body: some View {
        VStack {
            HStack {
                Image(currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                Text(currency.name)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.bottom, -5)
            .onTapGesture {
                onTapCurrency()
            }
            
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .focused($isTyping)
                .multilineTextAlignment(textAlignment)
        }
    }
}

