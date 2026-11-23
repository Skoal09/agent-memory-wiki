# Node 1 產出：Wiki 檢索清單（`sources.md`）

- **目標主題**：Agent Memory（AI 代理的記憶機制）：如何治好聊天機器人的「金魚腦」？
- **目標讀者**：有稍微接觸過 AI（用過聊天機器人），但未深入研究底層技術的同學與一般用戶。
- **檢索來源**：僅讀取 `wiki/index.md` 及其指向之已驗證 Wiki 檔案。

## 一、納入簡報的論文摘要頁（6/6 篇，符合 ≥ 5 篇要求）
1. `wiki/papers/generative-agents-2023.md` — 解答「記憶流與三維檢索＋反思機制如何解決角色失憶」
2. `wiki/papers/coala-2024.md` — 解答「記憶有哪些種類、為何 Context Window 不是記憶」
3. `wiki/papers/agent-memory-survey-2024.md` — 解答「記憶的三階段操作循環（寫入／管理／讀取）與文字 vs 參數權衡」
4. `wiki/papers/hipporag-2024.md` — 解答「分散在不同文章的線索如何透過知識圖譜一步聯想」
5. `wiki/papers/a-mem-2025.md` — 解答「AI 記憶如何像卡片盒筆記法一樣自我連結與演化」
6. `wiki/papers/mem0-2025.md` — 解答「真實產品如何降低延遲、省下 Token 並刪除過時記憶」

## 二、納入支撐的概念、實體與綜合頁面
- 概念頁：
  - `wiki/concepts/memory-taxonomy.md`（CoALA 與 ACM TOIS 雙視角分類＋`⚠️ 觀點差異`）
  - `wiki/concepts/memory-stream-reflection.md`（Memory Stream 三維分數與反思樹）
  - `wiki/concepts/memory-operations-lifecycle.md`（Writing × Management × Reading）
  - `wiki/concepts/graph-associative-memory.md`（HippoRAG 與 Mem0^g 圖譜權衡＋`⚠️ 觀點差異`）
  - `wiki/concepts/memory-evolution.md`（Zettelkasten 連結與回溯更新）
- 系統實體頁：
  - `wiki/entities/generative-agents.md`
  - `wiki/entities/coala.md`
  - `wiki/entities/hipporag.md`
  - `wiki/entities/a-mem.md`
  - `wiki/entities/mem0.md`
- 綜合比較與路線頁：
  - `wiki/syntheses/paradigm-and-tradeoff-comparison.md`（六篇橫向對照＋基準不可直接跨篇比對之 `⚠️ 觀點差異`）
  - `wiki/syntheses/beginner-learning-path.md`（五站教學順序設計）
