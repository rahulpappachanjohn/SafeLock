//
//  SafeLockScreen.swift
//  SafeLock
//
//  Created by Joshua Wegener on 14/10/24.
//

import SwiftUI

struct SafeLockScreen: View {
    
    @State private var passwordChecker: [Bool] = [false, false, false]
    @State private var rotationAngle: CGFloat = 0.0
    @State private var startAngle: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 40.0) {
            HStack {
                Circle()
                    .fill(passwordChecker[0] ? Color.correctPasswordField : Color.wrongPasswordField)
                    .frame(width: 30.0, height: 30.0)
                Circle()
                    .fill(passwordChecker[1] ? Color.correctPasswordField : Color.wrongPasswordField)
                    .frame(width: 30.0, height: 30.0)
                Circle()
                    .fill(passwordChecker[2] ? Color.correctPasswordField : Color.wrongPasswordField)
                    .frame(width: 30.0, height: 30.0)
            }
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 320.0, height: 320.0)
                    .shadow(color: Color.black.opacity(0.5), radius: 1.0, x: 0.0, y: 0.0)
                Circle()
                    .stroke(lineWidth: 5.0)
                    .frame(width: 300.0, height: 300.0)
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 280.0, height: 280.0)
                        .overlay {
                            ForEach(0..<100) { index in
                                VStack {
                                    Text(index % 10 == 0 ? String(index) : "")
                                        .rotationEffect(.degrees(-Double(index) * 360.0 / 100.0))
                                    //MARK: - Indicator
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: index % 5 == 0 ? 3.0 : 2.0, height: index % 5 == 0 ? 10.0 : 6.0)
                                }
                                .frame(height: 20.0, alignment: .bottom)
                                .offset(y: 130.0)
                                .rotationEffect(.degrees(Double(index) * 360.0 / 100.0))
                            }
                        }
                }
                .rotationEffect(.degrees(rotationAngle))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Calculate angle based on drag position relative to the center of the view
                            let dragLocation = value.location
                            let center = CGPoint(x: 160, y: 160) // Center of the circle (since it's 320x320)
                            
                            let deltaX = dragLocation.x - center.x
                            let deltaY = dragLocation.y - center.y
                            
                            let angle = atan2(deltaY, deltaX) * 180 / .pi
                            
                            // If it's the first drag movement, set the starting angle
                            if startAngle == 0.0 {
                                startAngle = angle
                            }
                            
                            // Update the rotation angle by considering the difference in drag angle
                            let angleChange = angle - startAngle
                            rotationAngle += angleChange
                            startAngle = angle
                        }
                        .onEnded { _ in
                            // Reset the start angle after the drag ends
                            startAngle = 0.0
                        }
                )
                Button {
                    if passwordChecker[0] == false {
                        passwordChecker = [true, false, false]
                    } else if passwordChecker[1] == false {
                        passwordChecker = [true, true, false]
                    } else if passwordChecker[2] == false {
                        passwordChecker = [true, true, true]
                    } else if passwordChecker[0] == true && passwordChecker[1] == true && passwordChecker[2] == true {
                        passwordChecker = [false, false, false]
                    }
                } label: {
                    Circle()
                        .fill(Color.selectionIndiactor)
                        .frame(width: 150.0, height: 150.0)
                        .shadow(color: Color.gray, radius: 15.0, x: 0.0, y: 0.0)
                }
                .buttonStyle(.plain)
                //MARK: - Target
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 5.0, height: 10.0)
                    .offset(y: -150.0)
            }
            
        }
        .padding(.horizontal, 20.0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
