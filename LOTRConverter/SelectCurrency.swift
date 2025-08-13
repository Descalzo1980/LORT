
import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @State var currency: Currency
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack {
                Text("Select the currency you are starting with: \(Currency.copperPenny.rawValue)")
                    .fontWeight(.bold)
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                    ForEach(Currency.allCases) { item in
                        CurrensyIcon(currencyImage: item.image, currencyName: item.name)
                            .shadow(color: currency == currency ? .black : .clear, radius: 10)
                            .overlay {
                                if item == currency {
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(lineWidth: 3)
                                        .opacity(0.5)
                                    
                                }
                            }.onTapGesture{
                                self.currency = item
                            }
                    }
                }
                
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(currency: .silverPiece)
}
