# LLM Wiki 更新與檢查日誌（Log）

## 2026-11-23 — Batch 1 Ingest（試跑前 2 篇）
- **操作內容**：依據 `AGENTS.md` 漸進式寫入規範，先行 ingest 2 篇基礎論文：
  - `raw/generative-agents-2023.md` → `wiki/papers/generative-agents-2023.md`、`wiki/concepts/memory-stream-reflection.md`、`wiki/entities/generative-agents.md`
  - `raw/coala-2024.md` → `wiki/papers/coala-2024.md`、`wiki/concepts/memory-taxonomy.md`、`wiki/entities/coala.md`
- **健康檢查**：執行 `scripts/lint-wiki.ps1`，共檢查 8 個 Wiki 檔案（6 個內容頁），結果為 `PASS: 0 broken links, 0 orphans, all citation & naming rules satisfied.`。
- **版本存檔**：已完成首次 `git commit`（`12d8f52`）。

## 2026-11-23 — Batch 2 Ingest（補齊其餘 4 篇＋綜合比較與衝突標記）
- **操作內容**：批次 ingest 其餘 4 篇文獻並擴充跨篇概念與綜合比較：
  - 新增單篇摘要：`agent-memory-survey-2024.md`、`hipporag-2024.md`、`a-mem-2025.md`、`mem0-2025.md`
  - 新增／更新概念頁：擴充 `memory-taxonomy.md`（加入 `⚠️ 觀點差異`），新增 `memory-operations-lifecycle.md`、`graph-associative-memory.md`（加入 `⚠️ 觀點差異`）、`memory-evolution.md`
  - 新增代表系統頁：`hipporag.md`、`a-mem.md`、`mem0.md`
  - 新增跨篇綜合頁：`paradigm-and-tradeoff-comparison.md`（含 LoCoMo 基準 `⚠️ 觀點差異` 解析）、`beginner-learning-path.md`
  - 更新 `index.md` 全站分類總覽。
- **健康檢查**：執行 `scripts/lint-wiki.ps1 -RequireSynthesis`，檢查 20 個 Wiki 檔案（18 個內容頁，於 6 個檔案驗證 `⚠️ 觀點差異` 標記），結果為 `PASS: 0 broken links, 0 orphans, all citation & naming rules satisfied.`。
