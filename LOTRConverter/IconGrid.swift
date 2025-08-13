
import SwiftUI

struct IconGrid: View {
    @State var currency: Currency
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(Currency.allCases) { item in
                CurrensyIcon(currencyImage: item.image, currencyName: item.name)
                    .shadow(color: currency == item ? .black : .clear, radius: 10)
                    .overlay {
                        if item == currency {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                            
                        }
                    }.onTapGesture{
                        self.currency = item
                        print("IconGrid Currency: \(self.currency)")
                    }
            }
        }
    }
}
    
    #Preview {
        IconGrid(currency: .silverPiece)
    }
