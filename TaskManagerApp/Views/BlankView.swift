//
//  BlankView.swift
//  TaskManagerApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

struct BlankView: View {
    var bgColor : Color
    var bgOpacity : Double
    var body: some View {
        VStack {
            Spacer()
        }.frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
            .background(bgColor)
            .opacity(bgOpacity)
            .blendMode(.overlay)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(bgColor: .blue, bgOpacity: 0.2)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea())
    }
}
