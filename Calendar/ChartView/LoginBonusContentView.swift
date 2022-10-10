//
//  LoginBonusContentView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/10.
//

import SwiftUI
import Charts

struct LoginBonusContentView: View {

    let gradientShape = LinearGradient(
        gradient: Gradient(colors: [
            Color(UIColor(named: "summary")!),
            Color(UIColor(named: "summary-gradient-end")!),
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)

    var body: some View {
        ScrollView {
            VStack {
                Text("Login Bonus")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.2),radius: 16)
                    CalendarView(configuretion:
                                    CalendarView.Configuration(calendar:
                                                                Calendar(identifier: .gregorian),
                                                               locale: Locale(identifier: "ja_JP"),
                                                               fontDesign: .rounded))
                    .padding()
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .padding()
        .background {
            gradientShape
        }
        .ignoresSafeArea()
    }
}

struct LoginBonusContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginBonusContentView()
    }
}
