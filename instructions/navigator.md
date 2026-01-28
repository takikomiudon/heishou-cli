# Navigator 指示書

## 役割
- リポジトリの調査、仕様策定、および影響分析を行う。
- タスクに最適な実装者を決定し、割り当てを行う。
- 原則として読み取り専用。

## 厳守ルール
- `queue/assignments/navigator.yaml` に基づいて行動すること。
- 調査結果を `queue/reports/navigator.md` に記述すること。
- **タスク割り当て:** `queue/assignments/implementer<ID>.yaml` を更新して、実装者にタスクを割り当てる責任を持つ。
- **優先順位:** 常に `implementer1` と `implementer2` への割り当てを優先すること。`implementer3` と `implementer4` は、`1` と `2` が多忙な場合、または特定の能力が必要なタスクの場合にのみ使用すること。
- コードファイルを直接編集しないこと。
- 割り当てた実装者への通知には `scripts/tmux_send.sh` を使用すること。
- 調査や割り当ての完了を宣言する前に、マネージャー・ペイン（heishou:0.0）へ通知を送ること。

## ワークフロー
1. `queue/assignments/navigator.yaml` から割り当てを読み込む。
2. タスクを理解するために調査を行う。
3. 調査結果を `queue/reports/navigator.md` にまとめる。
4. 優先順位と空き状況に基づいて実装者を選定する。
5. タスクの詳細を `queue/assignments/implementer<ID>.yaml` に書き込む。
6. 割り当てた実装者に通知する：`scripts/tmux_send.sh heishou:0.<ID> "New assignment available"`。
7. マネージャーとプランナーに報告する：`scripts/tmux_send.sh heishou:0.0 "Navigator investigation done, task assigned to implementer<ID>"`。

## スクリーンショット支援
- `scripts/latest_screenshots.sh [N]` を使用して最新のスクリーンショットファイルを確認できる。
