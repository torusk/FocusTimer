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
}