//
//  PomodoroMenuBarApp.swift
//  PomodoroMenuBar
//
//  メニューバーアプリのメインエントリーポイント
//

import SwiftUI
import AppKit

@main
struct PomodoroMenuBarApp: App {
    // AppDelegateを使用してメニューバーアイテムを管理
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // メニューバーアプリではWindowGroupは使用しない
        // 代わりにAppDelegateでNSStatusItemを管理
        Settings {
            EmptyView()
        }
    }
}

// AppDelegate: メニューバーアイテムの管理を担当
class AppDelegate: NSObject, NSApplicationDelegate {
    // メニューバーアイテム
    private var statusItem: NSStatusItem?
    // ポップオーバー（ドロップダウンメニューの代わり）
    private var popover: NSPopover?
    // アニメーション用のタイマー
    private var animationTimer: Timer?
    // アニメーション状態
    private var isAnimating = false
    private var animationScale: CGFloat = 1.0
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Dockアイコンを非表示にする
        NSApp.setActivationPolicy(.accessory)
        
        setupMenuBar()
    }
    
    // メニューバーアイテムのセットアップ
    private func setupMenuBar() {
        // ステータスバーにアイテムを作成
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // アイコンを設定（システムアイコンを使用）
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Pomodoro Timer")
            button.action = #selector(togglePopover)
            button.target = self
            
            // RunCat風アニメーションを開始
            startAnimation()
        }
        
        // ポップオーバーを作成
        setupPopover()
    }
    
    // ポップオーバーのセットアップ
    private func setupPopover() {
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 300, height: 200)
        popover?.behavior = .transient // クリック外で自動的に閉じる
        popover?.contentViewController = NSHostingController(rootView: MenuContentView())
    }
    
    // ポップオーバーの表示/非表示を切り替え
    @objc private func togglePopover() {
        guard let button = statusItem?.button else { return }
        
        if let popover = popover {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    // RunCat風アニメーションを開始
    private func startAnimation() {
        isAnimating = true
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.animateIcon()
        }
    }
    
    // アニメーションを停止
    private func stopAnimation() {
        isAnimating = false
        animationTimer?.invalidate()
        animationTimer = nil
        
        // アイコンを元のサイズに戻す
        if let button = statusItem?.button {
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.2
                button.layer?.transform = CATransform3DIdentity
            }
        }
    }
    
    // アイコンのアニメーション実行
    private func animateIcon() {
        guard let button = statusItem?.button, isAnimating else { return }
        
        // 上下に伸び縮みするアニメーション（0.8x ↔ 1.2x）
        let targetScale: CGFloat = animationScale == 1.0 ? 1.2 : 0.8
        animationScale = targetScale
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.25
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            let transform = CATransform3DMakeScale(1.0, targetScale, 1.0)
            button.layer?.transform = transform
        }
    }
    
    deinit {
        stopAnimation()
    }
}
