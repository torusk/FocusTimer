# FocusTimer プロジェクト設定ガイド

## 問題の解決

このプロジェクトでは、Git コマンドやビルドコマンドが間違ったディレクトリで実行される問題を解決するため、以下のファイルを作成しました：

## 作成されたファイル

### 1. `.project-root`

プロジェクトルートディレクトリを明示するマーカーファイル

### 2. `project-commands.sh`

常に正しいディレクトリでコマンドを実行するヘルパースクリプト

### 3. `.zshrc_additions`

シェルエイリアスの設定（手動で ~/.zshrc に追加が必要）

## 使用方法

### 基本的な使い方

```bash
# プロジェクトルートで実行
./project-commands.sh help    # ヘルプを表示
./project-commands.sh status  # Git status
./project-commands.sh build   # プロジェクトをビルド
```

### エイリアスの設定（推奨）

1. `.zshrc_additions` の内容を `~/.zshrc` に追加：

```bash
cat /Users/kazuki/Desktop/FocusTimer/.zshrc_additions >> ~/.zshrc
source ~/.zshrc
```

2. エイリアスを使用：

```bash
ft-status      # Git status を確認
ft-add         # すべての変更をステージング
ft-commit "メッセージ"  # コミット
ft-push        # プッシュ
ft-build       # ビルド
ft-run         # Xcodeでプロジェクトを開く
focustimer     # プロジェクトルートに移動
```

## 利点

- ✅ どのディレクトリからでも正しいプロジェクトルートでコマンドが実行される
- ✅ Git コマンドが常に正しいリポジトリで実行される
- ✅ ビルドコマンドが正しいプロジェクトファイルを参照する
- ✅ 簡単なエイリアスでよく使うコマンドを実行できる

## トラブルシューティング

### スクリプトが実行できない場合

```bash
chmod +x /Users/kazuki/Desktop/FocusTimer/project-commands.sh
```

### エイリアスが効かない場合

```bash
source ~/.zshrc
```

### プロジェクトルートに移動したい場合

```bash
cd /Users/kazuki/Desktop/FocusTimer
# または（エイリアス設定後）
focustimer
```
