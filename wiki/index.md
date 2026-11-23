# Agent Memory 知識庫總覽（LLM Wiki Index）

> 主題：**Agent Memory（AI 代理的記憶機制）：如何治好聊天機器人的「金魚腦」？**  
> 收錄 6 篇代表性論文、核心概念與跨系統比較，協助讀者從生活化類比出發，建立對 AI 長期記憶機制的完整認識。

---

## 一、單篇論文摘要（`papers/` — 共 6 篇）

| 論文名稱 | 作者與年份 | 發表出處（Venue / 等級） | 核心貢獻 | Wiki 頁面 |
| :--- | :--- | :--- | :--- | :--- |
| **Generative Agents** | Park et al. (2023) | ACM UIST 2023 (CORE A*, CCF A) | 記憶流、三維檢索、反思樹 | [generative-agents-2023.md](papers/generative-agents-2023.md) |
| **CoALA** | Sumers et al. (2024) | TMLR 2024 (Featured + Survey) | 四大記憶分類、行動空間、決策循環 | [coala-2024.md](papers/coala-2024.md) |
| **LLM Agent Memory Survey** | Zhang et al. (2024) | ACM TOIS (CORE A*, CCF A, JCR Q1) | 文字 vs 參數記憶、寫入/管理/讀取 | [agent-memory-survey-2024.md](papers/agent-memory-survey-2024.md) |
| **HippoRAG** | Gutiérrez et al. (2024) | NeurIPS 2024 | 海馬迴索引、OpenIE 圖譜與 PPR 單步檢索 | [hipporag-2024.md](papers/hipporag-2024.md) |
| **A-MEM** | Xu et al. (2025) | NeurIPS 2025 | 卡片盒筆記法、動態連結與舊記憶演化 | [a-mem-2025.md](papers/a-mem-2025.md) |
| **Mem0** | Chhikara et al. (2025) | arXiv Preprint 2025 (生產系統代表) | 增量萃取更新（ADD/UPDATE/DELETE）、圖版本 Mem0^g | [mem0-2025.md](papers/mem0-2025.md) |

---

## 二、核心概念頁（`concepts/` — 共 5 頁）

- [Agent Memory 分類架構（認知視角 vs 實作視角）](concepts/memory-taxonomy.md) — 整合 CoALA 四模組與 ACM TOIS 來源／形式分類（含 `⚠️ 觀點差異`）。
- [記憶流與反思機制（Memory Stream & Reflection）](concepts/memory-stream-reflection.md) — 近期性、重要性、相關性檢索與高層次反思樹。
- [記憶的三階段生命週期（Writing × Management × Reading）](concepts/memory-operations-lifecycle.md) — 寫入過濾、管理合併／遺忘與低成本讀取。
- [圖結構與聯想式記憶（Knowledge Graph × Associative Recall）](concepts/graph-associative-memory.md) — HippoRAG 與 Mem0^g 路線比較（含 `⚠️ 觀點差異`）。
- [記憶動態演化機制（從被動紀錄到卡片盒式自我重組）](concepts/memory-evolution.md) — A-MEM 的連結生成與回溯更新。

---

## 三、代表系統與架構（`entities/` — 共 5 頁）

- [Generative Agents（Smallville 虛擬小鎮架構）](entities/generative-agents.md)
- [CoALA 框架（Cognitive Architectures for Language Agents）](entities/coala.md)
- [HippoRAG 架構（海馬迴索引與知識圖譜檢索）](entities/hipporag.md)
- [A-MEM 系統（Agentic Memory for LLM Agents）](entities/a-mem.md)
- [Mem0 與 Mem0^g 架構（生產級可擴展長記憶層）](entities/mem0.md)

---

## 四、跨文獻綜合比較與學習路線（`syntheses/` — 共 2 頁）

- [綜合比較：六大 Agent Memory 研究流派與設計權衡](syntheses/paradigm-and-tradeoff-comparison.md) — 六篇數據對照、基準與指標 `⚠️ 觀點差異`、實戰選型指南。
- [初學者學習路線圖：從零看懂 Agent Memory](syntheses/beginner-learning-path.md) — 專為初學者設計的五站教學故事線。
