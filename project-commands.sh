#!/bin/bash

# FocusTimer プロジェクト用コマンドスクリプト
# 常に正しいディレクトリでコマンドを実行するためのヘルパースクリプト

# プロジェクトルートディレクトリ
PROJECT_ROOT="/Users/kazuki/Desktop/FocusTimer"

# 現在のディレクトリがプロジェクトルートかチェック
check_project_root() {
    if [ "$(pwd)" != "$PROJECT_ROOT" ]; then
        echo "⚠️  現在のディレクトリ: $(pwd)"
        echo "📁 プロジェクトルートに移動します: $PROJECT_ROOT"
        cd "$PROJECT_ROOT" || exit 1
    fi
}

# Git関連コマンド
git_status() {
    check_project_root
    echo "🔍 Git status を確認中..."
    git status
}

git_add_all() {
    check_project_root
    echo "📝 すべての変更をステージング中..."
    git add .
}

git_commit() {
    check_project_root
    if [ -z "$1" ]; then
        echo "❌ コミットメッセージを指定してください"
        echo "使用例: ./project-commands.sh commit \"メッセージ\""
        return 1
    fi
    echo "💾 コミット中: $1"
    git commit -m "$1"
}

git_push() {
    check_project_root
    echo "🚀 プッシュ中..."
    git push
}

# ビルド関連コマンド
build_project() {
    check_project_root
    echo "🔨 プロジェクトをビルド中..."
    cd "$PROJECT_ROOT/PomodoroMenuBar" || exit 1
    xcodebuild -project PomodoroMenuBar.xcodeproj -scheme PomodoroMenuBar -configuration Debug
}

run_app() {
    check_project_root
    echo "🚀 アプリを実行中..."
    open "$PROJECT_ROOT/PomodoroMenuBar/PomodoroMenuBar.xcodeproj"
}

# ヘルプ表示
show_help() {
    echo "📋 FocusTimer プロジェクト コマンド一覧:"
    echo ""
    echo "Git関連:"
    echo "  ./project-commands.sh status          - Git status を確認"
    echo "  ./project-commands.sh add             - すべての変更をステージング"
    echo "  ./project-commands.sh commit \"msg\"    - コミット"
    echo "  ./project-commands.sh push            - プッシュ"
    echo ""
    echo "ビルド関連:"
    echo "  ./project-commands.sh build           - プロジェクトをビルド"
    echo "  ./project-commands.sh run             - Xcodeでプロジェクトを開く"
    echo ""
    echo "その他:"
    echo "  ./project-commands.sh help            - このヘルプを表示"
}

# メイン処理
case "$1" in
    "status")
        git_status
        ;;
    "add")
        git_add_all
        ;;
    "commit")
        git_commit "$2"
        ;;
    "push")
        git_push
        ;;
    "build")
        build_project
        ;;
    "run")
        run_app
        ;;
    "help"|"")
        show_help
        ;;
    *)
        echo "❌ 不明なコマンド: $1"
        show_help
        ;;
esac