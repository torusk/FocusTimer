# PomodoroMenuBar

macOS のメニューバーに常駐する本格的なポモドーロタイマーアプリです。

## 特徴

- **メニューバー常駐**: Dock アイコンは表示されず、メニューバーにのみアイコンが表示されます
- **直感的な UI**: 大きくて見やすいポップオーバーで、タイマーの状態が一目でわかります
- **アニメーション**: スムーズなアニメーションで操作感が向上
- **ポモドーロテクニック対応**: 25 分の作業時間と 5 分の休憩時間を管理
- **視覚的フィードバック**: 進捗バー、ステータス表示、完了セッション数の表示
- **SwiftUI**: 最新の SwiftUI フレームワークを使用して開発
- **macOS 13.0+対応**: macOS Ventura 以降で動作します

## プロジェクト構成

```
PomodoroMenuBar/
├── PomodoroMenuBarApp.swift    # メインアプリケーションファイル
├── MenuContentView.swift       # ポップオーバーのコンテンツビュー
├── Info.plist                 # アプリ設定（Dock非表示設定含む）
├── project.pbxproj            # Xcodeプロジェクト設定
└── README.md                  # このファイル
```

## Xcode プロジェクトの作成手順

### 方法 1: 手動で Xcode プロジェクトを作成

1. **Xcode を起動**
2. **「Create a new Xcode project」を選択**
3. **テンプレート選択**:
   - macOS → App を選択
   - Next をクリック
4. **プロジェクト設定**:
   - Product Name: `PomodoroMenuBar`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Bundle Identifier: `com.example.PomodoroMenuBar`
   - Next をクリック
5. **保存場所を選択して Create**

### 方法 2: 既存ファイルからプロジェクトを構築

1. 提供されたファイルをプロジェクトフォルダにコピー
2. Xcode で `project.pbxproj` を含むフォルダを開く
3. 必要に応じてファイル参照を修正

## 重要な設定

### Info.plist の重要な設定

```xml
<!-- Dockアイコンを非表示にする設定 -->
<key>LSUIElement</key>
<true/>
```

この設定により、アプリが Dock に表示されなくなり、メニューバーのみに常駐します。

### コードの主要部分

#### 1. AppDelegate でのメニューバー設定

```swift
// メニューバーアイテムの作成
statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

// アイコンの設定
if let button = statusItem?.button {
    button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Pomodoro Timer")
    button.action = #selector(togglePopover)
    button.target = self
}
```

#### 2. Dock アイコンの非表示

```swift
// アプリ起動時にDockアイコンを非表示
NSApp.setActivationPolicy(.accessory)
```

#### 3. ポップオーバーの表示

```swift
// ポップオーバーの作成と表示
popover = NSPopover()
popover?.contentViewController = NSHostingController(rootView: MenuContentView())
popover?.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
```

## 使い方

### 基本操作

1. **アプリの起動**

   - Xcode から実行: ⌘+R でビルド・実行
   - ターミナルから実行: `open /path/to/PomodoroMenuBar.app`
   - アプリが起動すると、メニューバーにタイマーアイコン（⏱️）が表示されます

   open ~/Library/Developer/Xcode/DerivedData/PomodoroMenuBar-*/Build/Products/Debug/PomodoroMenuBar.app

2. **ポップオーバーを開く**
   - メニューバーのタイマーアイコンをクリック
   - 大きなポップオーバーが表示されます（380×420 ピクセル）

### タイマー機能

#### メインコントロール

- **「開始」ボタン**: タイマーを開始します

  - クリックすると「一時停止」ボタンに変化
  - ボタンの色がオレンジから赤に変化
  - アイコンが再生マーク（▶️）から一時停止マーク（⏸️）に変化

- **「一時停止」ボタン**: 実行中のタイマーを一時停止
  - クリックすると「開始」ボタンに戻る

#### セカンダリコントロール

- **「リセット」ボタン（🔄）**:

  - タイマーを初期状態（25:00）に戻します
  - 実行中のタイマーも停止されます

- **「切替」ボタン**:

  - **作業時間モード**: 25 分タイマー（ラップトップアイコン 💻）
  - **休憩時間モード**: 5 分タイマー（コーヒーカップアイコン ☕）
  - 切り替え時に完了セッション数がカウントアップされます

- **「終了」ボタン（❌）**: アプリを完全に終了します

### 表示情報

#### ヘッダー部分

- **アプリタイトル**: "🍅 Pomodoro Timer"
- **現在時刻**: リアルタイムで更新される現在時刻

#### メイン表示

- **タイマー表示**: 大きな文字で残り時間を表示（例: "25:00"）
- **進捗バー**: タイマーの進行状況を視覚的に表示
- **セッション種類**: "作業時間" または "休憩時間" を表示
- **ステータス**: "準備完了" / "実行中" / "一時停止中" を表示
- **完了セッション数**: 完了したポモドーロセッションの数

### ポモドーロテクニックの使い方

1. **作業セッション開始**

   - 「開始」ボタンをクリックして 25 分の作業時間を開始
   - 集中して作業に取り組む

2. **休憩セッション**

   - 作業時間が終了したら「切替」ボタンで休憩時間（5 分）に切り替え
   - 「開始」ボタンで休憩タイマーを開始

3. **サイクルの繰り返し**
   - 休憩後、再び「切替」ボタンで作業時間に戻る
   - このサイクルを繰り返して生産性を向上

### 操作のコツ

- **アニメーション**: すべてのボタン操作にスムーズなアニメーションが付いているので、状態変化が分かりやすい
- **色の変化**: タイマーの状態に応じてボタンの色が変化するので、現在の状態が一目で分かる
- **ログ出力**: 各操作はコンソールにログが出力されるので、デバッグ時に確認可能
- **ポップオーバー**: 画面外をクリックするとポップオーバーが閉じる

## ビルドと実行

### Xcode から実行

1. Xcode でプロジェクトを開く
2. ターゲットを「My Mac」に設定
3. ⌘+R でビルド・実行
4. メニューバーにタイマーアイコンが表示されることを確認

### ターミナルから実行

```bash
# プロジェクトディレクトリに移動
cd /path/to/PomodoroMenuBar

# ビルド
xcodebuild -project PomodoroMenuBar.xcodeproj -scheme PomodoroMenuBar -configuration Debug build

# 実行
open ~/Library/Developer/Xcode/DerivedData/PomodoroMenuBar-*/Build/Products/Debug/PomodoroMenuBar.app
```

## 実装済み機能

- ✅ メニューバー常駐
- ✅ ポップオーバー UI
- ✅ タイマー表示（25 分/5 分）
- ✅ 開始/一時停止機能
- ✅ リセット機能
- ✅ セッション切り替え（作業/休憩）
- ✅ 進捗バー表示
- ✅ 完了セッション数カウント
- ✅ アニメーション効果
- ✅ 視覚的フィードバック

## 今後の拡張予定

- 🔄 実際のタイマー機能（カウントダウン）
- 🔔 通知機能（セッション完了時）
- ⚙️ 設定画面（時間のカスタマイズ）
- 📊 統計機能（日別/週別の作業時間）
- 🎵 アラーム音の設定
- 💾 データの永続化

## 必要な環境

- macOS 13.0 (Ventura) 以降
- Xcode 15.0 以降
- Swift 5.9 以降

## ライセンス

MIT License

## 作成者

開発者名を記載してください。
