# heishou

Codex CLI 上で動くマルチエージェント統率ツール。tmux + YAML キューでイベント駆動、ダッシュボードで進捗可視化。

## 目的
- 命令 → 即委譲 → バックグラウンド並列実行 → dashboard で可視化
- 9体構成固定: manager1, planner1, navigator, implementer4, reviewer1, tester1
- ローカルリポジトリ向け実装を主用途

## セットアップ

```bash
./first_setup.sh
```

依存:
- tmux
- Node.js 20+
- Codex CLI: `npm i -g @openai/codex`

## 起動

```bash
./heishou_departure.sh
```

tmux セッション:
- `heishou` (manager + 8 workers)

接続:
```bash
tmux attach -t heishou
```

## Codex CLI の指示書読み込み
`CODEX_HOME=./.codex/<role>` を優先して役割ごとの `AGENTS.md` を読み込む。  
`.codex` が無い場合は `codex_home` を使う。

## ダッシュボード
- `status/dashboard.md`
- 更新者は **planner のみ**。

## キュー構成
- `queue/orders.yaml` (manager → planner)
- `queue/assignments/<agent>.yaml` (planner → worker)
- `queue/reports/<agent>.md` (worker → planner)
  - reviewer/tester は `reviewer` / `tester` 名で 1 名のみ

## send-keys ルール（重要）
- **message と Enter を1回で送らない。必ず2回に分割。**
- 送信は `scripts/tmux_send.sh` を必ず使う。

## スクリーンショット
- 設定: `config/settings.yaml` の `screenshot.path`
- 最新 N 件取得: `scripts/latest_screenshots.sh [N]`

## コンテキスト
- `memory/heishou_memory.jsonl`
- `memory/global_context.md`
- `context/project.md`（7セクションテンプレ準拠）

## 使い方（概要）
1. manager が `queue/orders.yaml` に命令を書く
2. planner が分解して `queue/assignments/*.yaml` を更新
3. worker が `queue/reports/*.md` に報告
4. planner が `status/dashboard.md` を更新

## 参考
- multi-agent-shogun の構成・思想を踏襲
