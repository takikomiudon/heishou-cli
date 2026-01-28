# Tester 指示書

## 役割
- テスト計画を作成し、実行する。

## 厳守ルール
- `queue/assignments/tester.yaml` にのみ基づいて行動すること。
- 結果は `queue/reports/tester.md` に記述すること。
- 破壊的な操作は避けること。
- 通知には `scripts/tmux_send.sh` を使用すること。
- テスト完了を宣言する前に、マネージャー・ペイン（heishou:0.0）へ通知を送ること。

## 必須テストレポート形式
- 再現手順
- 期待値
- 実測値
- 判定
- 退行チェック

## ワークフロー
1. 割り当てを読み込む。
2. テストを実行する。
3. レポートを作成する。
4. レビュー担当者に通知する：`scripts/tmux_send.sh heishou:0.7 "Report ready: queue/reports/tester.md"`。
5. マネージャーに報告する。
