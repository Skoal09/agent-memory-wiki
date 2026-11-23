# 記憶的三階段生命週期（Writing × Management × Reading）

- **類型**：核心概念頁（`concepts/`）
- **核心來源**：[LLM Agent Memory Survey (2024)](../papers/agent-memory-survey-2024.md) ｜ [Mem0 (2025)](../papers/mem0-2025.md)
- **相關系統**：[Mem0 架構](../entities/mem0.md) ｜ [Generative Agents](../entities/generative-agents.md) ｜ [概念：記憶動態演化機制](memory-evolution.md)

---

## 1. 不只是「存起來再搜尋」：記憶是個動態循環

如果把聊天紀錄原封不動全部存進向量資料庫，很快就會被「今天天氣不錯」、「好喔謝謝」等廢話淹沒。因此 [LLM Agent Memory Survey (2024)](../papers/agent-memory-survey-2024.md) 把記憶模組拆成三個環環相扣的操作流程：`a_{t+1} = LLM{ R( P(M_{t-1}, W({a_t, o_t})), c_{t+1} ) }` [Memory Survey 2024, Sec. 3.4, Sec. 5.3]：

---

## 2. 三階段拆解與生產級實作對照

| 階段 | 解決的問題 | 經典代表做法 | 生產系統 `Mem0` 的實作細節 |
| :--- | :--- | :--- | :--- |
| **1. Memory Writing (`W`)**<br>寫入與過濾 | 原始對話冗長又吵雜，哪些值得記？ | `MemoChat` 分段摘出主題當索引；`TiM` 抽成實體關係 [Memory Survey 2024, Sec. 5.3.1] | 結合全域摘要 `S` 與最近 `m=10` 句對話，從新訊息對中精準萃取候選事實 `Ω` [Mem0 2025, Sec. 2.1] |
| **2. Memory Management (`P`)**<br>整理、合併與遺忘 | 記憶越來越多、舊資訊過時或彼此衝突怎麼辦？ | 反思（Reflection）、合併冗餘（Merging）、遺忘（Forgetting） [Memory Survey 2024, Sec. 5.3.2] | 撈出最相近的 `s=10` 條舊記憶，透過 Tool Call 執行 `ADD`、`UPDATE`、`DELETE` 或 `NOOP`；圖版本 `Mem0^g` 則標記舊關係為失效 [Mem0 2025, Sec. 2.1, Sec. 2.2] |
| **3. Memory Reading (`R`)**<br>讀取與檢索 | 回覆下一句話時，如何只拿真正需要的記憶？ | 向量相似度（如 FAISS）或結合 Recency/Importance 排序 [Memory Survey 2024, Sec. 5.3.3] | 平均只撈約 `1,764` tokens 進 Prompt，相較 Full-Context 的 `26,031` tokens 省下超過 `90%` Token 成本 [Mem0 2025, Abstract, Table 2] |

---

## 3. 為什麼「遺忘與刪除」其實跟「記住」一樣重要？

[CoALA (2024)](../papers/coala-2024.md) 曾指出早期系統普遍忽略刪除過時記憶（Unlearning） [CoALA 2024, Sec. 4.5]。若使用者以前住台北、後來搬到高雄，沒有「管理／淘汰」機制的系統就會在檢索時同時撈出矛盾事實。像 [Mem0 (2025)](../papers/mem0-2025.md) 主動執行 `UPDATE / DELETE`（或在圖譜標記失效以保留時間先後），正是讓 AI 記憶能跨數月不崩壞的關鍵 [Mem0 2025, Sec. 2.1, Sec. 2.2]。
