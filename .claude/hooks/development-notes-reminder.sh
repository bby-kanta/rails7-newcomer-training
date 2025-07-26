#!/bin/bash

# CLAUDE.mdのDevelopment Notesから教訓を抽出するスクリプト

# スクリプトのディレクトリから相対パスでプロジェクトルートに移動
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CLAUDE_MD_PATH="$PROJECT_ROOT/CLAUDE.md"

# CLAUDE.mdからDevelopment Notesセクションの内容を抽出
# - で始まる行を教訓として取得（### Rspec Notesの前まで）
LESSONS=()
IN_DEV_NOTES=false
while IFS= read -r line; do
    if [[ "$line" == "## Development Notes" ]]; then
        IN_DEV_NOTES=true
        continue
    elif [[ "$line" =~ ^### ]]; then
        IN_DEV_NOTES=false
    elif [[ "$IN_DEV_NOTES" == true ]]; then
        # - で始まる行から教訓を抽出（インデントされた子要素は除外）
        if [[ "$line" =~ ^-\ (.+) ]] && [[ ! "$line" =~ ^[[:space:]]+- ]]; then
            lesson="${line#- }"  # "- "を削除
            LESSONS+=("$lesson")
        fi
    fi
done < "$CLAUDE_MD_PATH"

# 最後の出力を確認
LAST_OUTPUT=$(cat)

# DEVELOPMENT_NOTES_DISPLAYED というキーワードがあるかチェック
if echo "$LAST_OUTPUT" | grep -q "DEVELOPMENT_NOTES_DISPLAYED"; then
    echo "$LAST_OUTPUT"
    exit 0
fi

# 配列の長さを取得
TOTAL_LESSONS=${#LESSONS[@]}

# 教訓が見つからない場合のエラーハンドリング
if [ $TOTAL_LESSONS -eq 0 ]; then
    echo "Error: CLAUDE.mdからDevelopment Notesを抽出できませんでした。"
    echo "$LAST_OUTPUT"
    exit 0
fi

# macOS互換のランダム選択（重複なし）
SELECTED_INDICES=()
while [ ${#SELECTED_INDICES[@]} -lt 5 ] && [ ${#SELECTED_INDICES[@]} -lt $TOTAL_LESSONS ]; do
    # ランダムなインデックスを生成
    RANDOM_INDEX=$((RANDOM % TOTAL_LESSONS))
    
    # 既に選択されていないか確認
    ALREADY_SELECTED=false
    for idx in "${SELECTED_INDICES[@]}"; do
        if [ "$idx" = "$RANDOM_INDEX" ]; then
            ALREADY_SELECTED=true
            break
        fi
    done
    
    # 選択されていなければ追加
    if [ "$ALREADY_SELECTED" = false ]; then
        SELECTED_INDICES+=($RANDOM_INDEX)
    fi
done

# 教訓を出力
echo "=== 🎯 今回のDevelopment Notes教訓 (ランダム5件) ==="
echo ""

for i in "${!SELECTED_INDICES[@]}"; do
    index=${SELECTED_INDICES[$i]}
    echo "$((i+1)). ${LESSONS[$index]}"
    echo ""
done

echo "これらの教訓を踏まえて、コードの実装や修正を行ってください。上記の原則すべて守れていると思ったときのみ「完全に理解した」とだけ発言し、実装を始めよ。"

# Claudeに教訓を読ませるためにblockする
echo '{
  "decision": "block"
}'