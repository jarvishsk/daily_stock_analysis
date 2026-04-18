#!/bin/bash
# 每日股票分析项目 - 同步上游脚本
# 上游: https://github.com/jarvishsk/daily_stock_analysis
# 本地: /Users/jarvis/Documents/investment/project/daily_stock_analysis

cd /Users/jarvis/Documents/investment/project/daily_stock_analysis

echo "🔄 同步上游仓库..."
echo "本地: $(pwd)"
echo "上游: https://github.com/jarvishsk/daily_stock_analysis"
echo ""

# 1. 获取上游更新
echo "📥 1. 获取上游最新代码..."
git fetch upstream

# 2. 查看更新
echo ""
echo "📊 2. 检查更新内容..."
NEW_COMMITS=$(git log --oneline main..upstream/main | wc -l)
if [ "$NEW_COMMITS" -eq 0 ]; then
    echo "✅ 已是最新，无需同步"
    exit 0
fi

echo "发现 $NEW_COMMITS 个新提交:"
git log --oneline main..upstream/main

# 3. 合并更新
echo ""
echo "🔀 3. 合并到本地..."
git checkout main
git merge upstream/main -m "同步上游更新 $(date '+%Y-%m-%d')"

# 4. 推送到你的GitHub
echo ""
echo "📤 4. 推送到你的GitHub..."
git push origin main

echo ""
echo "✅ 同步完成！"
echo ""
echo "当前状态:"
git log --oneline -3
