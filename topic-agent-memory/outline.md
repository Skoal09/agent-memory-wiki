# Node 3 產出：教學 HTML 簡報大綱（`outline.md`）

- **簡報標題**：治好 AI 的「金魚腦」— 一堂給入門者的 Agent Memory 必修課
- **頁數規劃**：12 頁（符合 8–15 頁規範，單頁限 240 字以內防溢出）
- **教學敘事結構**：痛點破題 → 認知地圖 → 運作流程 → 進階演化與產品實踐 → 觀點衝突辨析 → 實戰選型與流程揭密 → 互動測驗

## Slide 01：AI 的「金魚腦」困擾 — 為什麼每次開新對話都要自我介紹？
- **對應卡片**：`card-02`, `card-03`, `card-06`
- **Wiki 出處**：`wiki/concepts/memory-taxonomy.md`, `wiki/syntheses/beginner-learning-path.md`
- **頁面目標**：用生活化情境（昨天告訴 AI 吃素，今天開新對話卻推薦雞排）點出 LLM 預設「無狀態（Stateless）」的本質，提出本簡報的核心問題。

## Slide 02：破除迷思 — Context Window 是「書桌」，不是永久記憶
- **對應卡片**：`card-02`, `card-03`, `card-06`
- **Wiki 出處**：`wiki/concepts/memory-taxonomy.md`, `wiki/papers/agent-memory-survey-2024.md`
- **頁面目標**：以「書桌桌面 vs 檔案櫃」視覺比喻解釋為什麼把 Context Window 撐到 200K 仍不夠：成本暴增、延遲高，還會發生「Lost in the Middle」忘記中間內容。

## Slide 03：借鏡人類大腦 — CoALA 的四大記憶藍圖
- **對應卡片**：`card-02`
- **Wiki 出處**：`wiki/papers/coala-2024.md`, `wiki/entities/coala.md`, `wiki/concepts/memory-taxonomy.md`
- **頁面目標**：用四象限卡片講解 `Working`（書桌）、`Episodic`（日記）、`Semantic`（百科）與 `Procedural`（SOP 技能庫），並提醒修改程式碼與遺忘（Unlearning）的風險邊界。

## Slide 04：記憶如何從「流水帳」變「洞察」？Generative Agents 的反思樹
- **對應卡片**：`card-01`
- **Wiki 出處**：`wiki/papers/generative-agents-2023.md`, `wiki/concepts/memory-stream-reflection.md`, `wiki/entities/generative-agents.md`
- **頁面目標**：介紹 `Smallville` 25 人小鎮如何靠「近期性×重要性×相關性」撈記憶，並定期觸發「反思」把碎片升華成性格理解（附消融實驗 TrueSkill 數據）。

## Slide 05：記憶的一生 — 寫入、整理／遺忘、讀取的三階段循環
- **對應卡片**：`card-03`, `card-06`
- **Wiki 出處**：`wiki/papers/agent-memory-survey-2024.md`, `wiki/concepts/memory-operations-lifecycle.md`
- **頁面目標**：介紹 ACM TOIS 綜述拆解的 `Writing → Management → Reading` 生命週期，以及為什麼「文字記憶」與「參數記憶」各有優缺點、且「遺忘」不可或缺。

## Slide 06：跨文章聯想記憶 — HippoRAG 模仿人腦海馬迴索引
- **對應卡片**：`card-04`
- **Wiki 出處**：`wiki/papers/hipporag-2024.md`, `wiki/concepts/graph-associative-memory.md`, `wiki/entities/hipporag.md`
- **頁面目標**：解釋傳統 RAG 各自獨立切塊為何答不出跨文件問題，以及 HippoRAG 如何用 OpenIE 知識圖譜＋Personalized PageRank 實現單步聯想（附 `2Wiki` R@5 提升約 20% 與 10–30 倍成本優勢）。

## Slide 07：會自己長大的筆記本 — A-MEM 的卡片盒（Zettelkasten）記憶演化
- **對應卡片**：`card-05`
- **Wiki 出處**：`wiki/papers/a-mem-2025.md`, `wiki/concepts/memory-evolution.md`, `wiki/entities/a-mem.md`
- **頁面目標**：說明 A-MEM 如何擺脫寫死的 Schema，讓每則記憶自動寫卡片、動態牽線連結，並回頭改寫舊記憶描述（附 Token 節省 85–93% 與消融數據）。

## Slide 08：從論文走向產品 — Mem0 如何兼顧低延遲、省錢與除舊
- **對應卡片**：`card-06`
- **Wiki 出處**：`wiki/papers/mem0-2025.md`, `wiki/entities/mem0.md`
- **頁面目標**：展示 `Mem0` 如何用 Tool Call 執行 `ADD / UPDATE / DELETE / NOOP` 解決偏好衝突，把 Token 成本省下 >90%、p95 延遲降 91% 以上，並比較 `Mem0^g` 圖版本的時間推理強項。

## Slide 09：⚠️ 觀點差異 — 六大研究怎麼對照？為什麼數字不能直接比？
- **對應卡片**：`card-01`, `card-02`, `card-03`, `card-04`, `card-05`, `card-06`
- **Wiki 出處**：`wiki/syntheses/paradigm-and-tradeoff-comparison.md`, `wiki/concepts/graph-associative-memory.md`
- **頁面目標**：誠實呈現三大衝突／前提差異：(1) 分類法正交視角不同；(2) `A-MEM` 與 `Mem0` 同測 LoCoMo 卻在題組與指標上設定不同；(3) `Mem0^g` 圖譜在單跳/多跳反而不如純文字版。

## Slide 10：新手實戰指南 — 不同應用場景該配哪種 Agent Memory？
- **對應卡片**：`card-01`, `card-02`, `card-03`, `card-04`, `card-05`, `card-06`
- **Wiki 出處**：`wiki/syntheses/paradigm-and-tradeoff-comparison.md`, `wiki/syntheses/beginner-learning-path.md`
- **頁面目標**：用清楚的場景決策矩陣，讓初學者一看就懂「個人客服／知識庫問答／長期研究助手／虛擬角色」各自對應的記憶配置。

## Slide 11：幕後揭密 — 這份簡報怎麼用 LLM Wiki + Graph Workflow 做出來的？
- **對應卡片**：`card-01`, `card-02`, `card-03`, `card-04`, `card-05`, `card-06`
- **Wiki 出處**：`wiki/index.md`, `wiki/log.md`
- **頁面目標**：簡要展示本簡報的產製防線：`6 篇 raw/ → LLM Wiki → 平行證據卡 → 腳本與獨立審查 → deck.html`，呼應課程「先討論、把檢查寫進流程」。

## Slide 12：總結與互動隨堂小測驗（30 秒檢驗你懂了沒！）
- **對應卡片**：`card-01`, `card-02`, `card-03`, `card-04`, `card-05`, `card-06`
- **Wiki 出處**：`wiki/syntheses/beginner-learning-path.md`, `wiki/index.md`
- **頁面目標**：三句核心帶走重點＋3 題互動式即時點擊測驗，幫初學者立刻驗證概念吸收成效。
