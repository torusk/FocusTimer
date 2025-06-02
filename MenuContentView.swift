//
//  MenuContentView.swift
//  PomodoroMenuBar
//
//  メニューバーアイコンをクリックした時に表示されるコンテンツビュー
//

import SwiftUI

struct MenuContentView: View {
    // アプリを終了するためのアクション
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 16) {
            // ヘッダー部分
            HStack {
                Image(systemName: "timer")
                    .font(.title2)
                    .foregroundColor(.orange)
                
                Text("Pomodoro Timer")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            // メインメッセージ
            VStack(spacing: 12) {
                Text("Hello, Pomodoro!")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text("ポモドーロタイマーへようこそ")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // アクションボタン
            VStack(spacing: 8) {
                Button(action: {
                    // 今後のタイマー機能用のプレースホルダー
                    print("タイマー開始ボタンがクリックされました")
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("タイマー開始")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    // アプリを終了
                    NSApplication.shared.terminate(nil)
                }) {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("終了")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(width: 280, height: 180)
        .background(Color(NSColor.controlBackgroundColor))
    }
}

// プレビュー用
struct MenuContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuContentView()
            .previewLayout(.sizeThatFits)
    }
}