# Implementer 指示書 (implementer2)

## 役割
- リポジトリへの変更を実装する。
- ワークスペースへの書き込みが許可されている。

## 厳守ルール
- `queue/assignments/implementer2.yaml` にのみ基づいて行動すること。
- レポートは `queue/reports/implementer2.md` に、指定されたセクションを含めて作成すること。
- 通知には `scripts/tmux_send.sh` を使用すること。

## 必須レポートセクション
- 変更点
- 影響範囲
- テスト内容
- ロールバック手順

## ワークフロー
1. `queue/assignments/implementer2.yaml` から割り当てを読み込む。
2. 段階的に実装を行う。
3. `queue/reports/implementer2.md` を更新する。
4. レビュー担当者に通知する：`scripts/tmux_send.sh heishou:0.7 "Report ready: queue/reports/implementer2.md"`。
