# FocusTimer プロジェクト設定ガイド

## プロジェクト概要

- **プロジェクト名**: FocusTimer (旧: PomodoroMenuBar)
- **プラットフォーム**: macOS
- **開発言語**: Swift
- **UI フレームワーク**: SwiftUI
- **アプリタイプ**: メニューバーアプリケーション

## ディレクトリ構造

```
/Users/kazuki/Desktop/FocusTimer/
├── .gitignore                    # Git除外ファイル設定
├── README.md                     # プロジェクト説明
├── SETUP.md                      # このファイル（設定ガイド）
├── Info.plist                    # アプリケーション情報
├── MenuContentView.swift         # メニュー表示用SwiftUIビュー
├── PomodoroMenuBarApp.swift      # メインアプリケーションファイル
├── project.pbxproj              # Xcodeプロジェクト設定
└── PomodoroMenuBar/             # Xcodeプロジェクトディレクトリ
    ├── PomodoroMenuBar/         # メインソースコード
    ├── PomodoroMenuBar.xcodeproj/  # Xcodeプロジェクトファイル
    ├── PomodoroMenuBarTests/    # ユニットテスト
    └── PomodoroMenuBarUITests/  # UIテスト
```

## 開発環境設定

### 必要なソフトウェア

- **Xcode**: 最新版推奨
- **macOS**: 対応バージョン確認が必要
- **Git**: バージョン管理用

### MCP サーバー設定

設定ファイル場所: `~/.config/mcp/settings.json`

```json
{
  "mcpServers": {
    "mcp.config.usrlocalmcp.xcode": {
      "command": "uvx",
      "args": ["mcp-xcode"],
      "env": {
        "PROJECTS_BASE_DIR": "/Users/kazuki/Desktop"
      }
    }
  }
}
```

**重要**: `PROJECTS_BASE_DIR`を Desktop 全体に設定することで、複数のプロジェクトに対応可能

## プロジェクト設定詳細

### Bundle Identifier

- 現在: `com.example.PomodoroMenuBar`（要変更）
- 推奨: `com.yourname.FocusTimer`

### 開発チーム設定

- Xcode で「Signing & Capabilities」タブを開く
- 適切な開発チームを選択
- 必要に応じて Provisioning Profile を設定

### ビルド設定

- **Deployment Target**: macOS 11.0 以上推奨
- **Architecture**: Apple Silicon (arm64) + Intel (x86_64)

## Git 設定

### .gitignore 設定済み項目

- Xcode ビルド成果物
- DerivedData
- UserInterfaceState.xcuserstate
- .DS_Store
- その他一時ファイル

### 推奨 Git ワークフロー

```bash
# 初回設定
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main

# 日常的な作業
git add .
git commit -m "機能追加: 説明"
git push
```

## トラブルシューティング

### よくある問題と解決法

#### 1. ビルドエラー

- **症状**: プロジェクトがビルドできない
- **解決法**:
  - Xcode を再起動
  - Product → Clean Build Folder
  - DerivedData を削除

#### 2. 署名エラー

- **症状**: Code signing error
- **解決法**:
  - Bundle Identifier を一意のものに変更
  - 開発チームを正しく設定
  - Provisioning Profile を確認

#### 3. MCP 接続エラー

- **症状**: MCP サーバーに接続できない
- **解決法**:
  - 設定ファイルのパスを確認
  - 環境変数が正しく設定されているか確認
  - MCP サーバーを再起動

## 新しい開発者向けセットアップ手順

### 1. プロジェクトクローン

```bash
git clone <repository-url>
cd FocusTimer
```

### 2. Xcode 設定

1. `PomodoroMenuBar/PomodoroMenuBar.xcodeproj`を開く
2. Bundle Identifier を変更
3. 開発チームを設定
4. ビルドして動作確認

### 3. MCP 設定（オプション）

1. `~/.config/mcp/settings.json`を編集
2. `PROJECTS_BASE_DIR`を適切なパスに設定
3. MCP サーバーを再起動

## 機能一覧

### 現在実装済み

- メニューバーアプリケーションの基本構造
- SwiftUI ベースの UI

### 今後の実装予定

- ポモドーロタイマー機能
- 通知機能
- 設定画面
- 統計表示

## 参考情報

### 有用なリンク

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [macOS App Development](https://developer.apple.com/macos/)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode/)

### コーディング規約

- Swift 標準のコーディングスタイルに従う
- 関数名、変数名は英語で記述
- コメントは日本語でも可

---

**最終更新**: 2024 年 12 月
**作成者**: Kazuki
**バージョン**: 1.0
