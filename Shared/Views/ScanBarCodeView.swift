//
//  ScanBarCodeView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI

struct ScanBarCodeView: View {
    @StateObject var barcode: BarcodeViewModel = BarcodeViewModel()
    @State var reward: RewardModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 50)
                Text("Scan and enjoy!")
                    .font(.Title())
                Spacer()
                Image(uiImage: UIImage(barcode: barcode.string) ?? UIImage())
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 80, height: 200)
                    .aspectRatio(contentMode: .fit)
                Text(barcode.string)
                    .font(.Body())
                    .offset(y: -30)
                Spacer()
                Text("Date created: \(formatDate(dateString: reward.createdAt))")
                    .font(.Body())
                Text("EXP: \(formatDate(dateString: reward.endAt))")
                    .font(.Body())
                    .padding(.bottom, 30)
                NavigationLink {
                    GetAppView()
                } label: {
                    VStack {
                        Text("Dismiss")
                            .font(.Bold(size: 20))
                            .padding(.bottom, -8)
                        Rectangle()
                            .frame(width: 78, height: 2)
                    }
                    .foregroundColor(.black)
                }
                Spacer()
                    .frame(height: 50)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            barcode.getBarcode(rewardID: reward.id)
        }
    }
}

struct ScanBarCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanBarCodeView(reward: RewardModel(
            id: 45,
            points: 6,
            totalPoints: 6,
            storeName: "Taperk's Kitchen",
            rewardDescription: "Free Normal Size Spaghetti",
            createdAt: "2023-06-24T21:11:47.283Z",
            endAt: "2023-07-01T03:38:11.000Z"
        ))
    }
}

extension UIImage {

    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

}

func formatDate(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")

    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let formattedDate = dateFormatter.string(from: date) + " " + TimeZone.current.abbreviation()!
        return formattedDate
    } else {
        print("Error parsing date string")
        return dateString
    }
}
