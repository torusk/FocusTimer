//
//  MenuContentView.swift
//  PomodoroMenuBar
//
//  メニューバーアイコンをクリックした時に表示されるコンテンツビュー
//

import SwiftUI

struct MenuContentView: View {
    @State private var isTimerRunning = false
    @State private var currentTime = "25:00"
    @State private var currentSession = "作業時間"
    @State private var completedSessions = 0
    @State private var timeRemaining = 25 * 60 // 秒単位
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            // ヘッダー部分
            HStack {
                Image(systemName: isTimerRunning ? "timer.circle.fill" : "timer")
                    .font(.title2)
                    .foregroundColor(isTimerRunning ? .green : .orange)
                    .animation(.easeInOut(duration: 0.3), value: isTimerRunning)
                
                Text("Pomodoro Timer")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // 完了セッション数
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                    Text("\(completedSessions)")
                        .font(.caption)
                        .fontWeight(.medium)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            // タイマー表示部分
            VStack(spacing: 16) {
                // 現在のセッション種類
                Text(currentSession)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(currentSession == "作業時間" ? .orange : .blue)
                    .animation(.easeInOut(duration: 0.3), value: currentSession)
                
                // タイマー表示
                Text(currentTime)
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
                    .padding(.vertical, 8)
                
                // 進捗バー
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: currentSession == "作業時間" ? .orange : .blue))
                    .scaleEffect(y: 2)
                    .animation(.easeInOut(duration: 0.5), value: progress)
                
                // ステータスメッセージ
                Text(isTimerRunning ? "集中してください！" : "準備完了")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .animation(.easeInOut(duration: 0.3), value: isTimerRunning)
            }
            .padding(.horizontal)
            
            // アクションボタン
            VStack(spacing: 12) {
                // メインアクションボタン
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if isTimerRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                            .animation(.easeInOut(duration: 0.2), value: isTimerRunning)
                        Text(isTimerRunning ? "一時停止" : "開始")
                            .animation(.easeInOut(duration: 0.2), value: isTimerRunning)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(isTimerRunning ? Color.red : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                .buttonStyle(PlainButtonStyle())
                
                // セカンダリボタン群
                HStack(spacing: 12) {
                    // リセットボタン
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            resetTimer()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("リセット")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // セッション切り替えボタン
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            switchSession()
                        }
                    }) {
                        HStack {
                            Image(systemName: currentSession == "作業時間" ? "cup.and.saucer" : "laptopcomputer")
                            Text("切替")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(currentSession == "作業時間" ? Color.blue.opacity(0.8) : Color.orange.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // 終了ボタン
                Button(action: {
                    print("アプリ終了")
                    NSApplication.shared.terminate(nil)
                }) {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("終了")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.primary)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(width: 380, height: 420)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(12)
        .shadow(radius: 8)
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    // タイマー開始
    private func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                updateDisplay()
            } else {
                timerCompleted()
            }
        }
        print("タイマー開始: \(currentSession)")
    }
    
    // タイマー停止
    private func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        print("タイマー停止")
    }
    
    // タイマーリセット
    private func resetTimer() {
        stopTimer()
        if currentSession == "作業時間" {
            timeRemaining = 25 * 60
            currentTime = "25:00"
        } else {
            timeRemaining = 5 * 60
            currentTime = "05:00"
        }
        progress = 0.0
        print("タイマーリセット")
    }
    
    // セッション切り替え
    private func switchSession() {
        stopTimer()
        if currentSession == "作業時間" {
            currentSession = "休憩時間"
            timeRemaining = 5 * 60
            currentTime = "05:00"
        } else {
            currentSession = "作業時間"
            timeRemaining = 25 * 60
            currentTime = "25:00"
            completedSessions += 1
        }
        progress = 0.0
        print("セッション切り替え: \(currentSession)")
    }
    
    // 表示更新
    private func updateDisplay() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        currentTime = String(format: "%02d:%02d", minutes, seconds)
        
        // 進捗計算
        let totalTime = currentSession == "作業時間" ? 25 * 60 : 5 * 60
        progress = Double(totalTime - timeRemaining) / Double(totalTime)
    }
    
    // タイマー完了
    private func timerCompleted() {
        stopTimer()
        
        // 通知音を鳴らす
        NSSound.beep()
        
        // 自動的に次のセッションに切り替え
        if currentSession == "作業時間" {
            currentSession = "休憩時間"
            timeRemaining = 5 * 60
            currentTime = "05:00"
        } else {
            currentSession = "作業時間"
            timeRemaining = 25 * 60
            currentTime = "25:00"
            completedSessions += 1
        }
        progress = 0.0
        
        print("\(currentSession == "休憩時間" ? "作業" : "休憩")時間完了！次は\(currentSession)です。")
    }
}

// プレビュー用
struct MenuContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuContentView()
            .previewLayout(.sizeThatFits)
    }
}
