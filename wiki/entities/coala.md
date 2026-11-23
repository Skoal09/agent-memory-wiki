# CoALA 框架（Cognitive Architectures for Language Agents）

- **類型**：代表系統與架構頁（`entities/`）
- **出處論文**：[Cognitive Architectures for Language Agents (2024)](../papers/coala-2024.md)
- **發表場域**：TMLR 2024（Featured + Survey Certification）
- **相關頁面**：[概念：認知分類架構](../concepts/memory-taxonomy.md) ｜ [系統：Generative Agents](generative-agents.md)

---

## 框架定位

CoALA 並非單一軟體產品，而是一套協助工程師與研究者「拆解並設計語言代理（Language Agents）」的通用概念架構，把傳統符號 AI 認知架構（如 Soar）的模組化思想引進現代 LLM 應用 [CoALA 2024, Sec. 1, Sec. 4]。

## 設計一個 CoALA Agent 的實務步驟

論文第 6 節提供了一套清楚的設計指引（以個人化購物助理為例） [CoALA 2024, Sec. 6]：
1. **盤點所需記憶模組**：需要「語義記憶」存放商品目錄、「情節記憶」存放客戶歷史對話與購買紀錄、「工作記憶」追蹤當下對話狀態，以及「程序記憶」定義查詢函式。
2. **嚴格劃定內部寫入權限**：例如允許讀寫「情節記憶」以記錄新互動，但對商品目錄（語義記憶）與程式碼（程序記憶）只開放唯讀權限，避免 Agent 誤改庫存或寫壞自己的程式。
3. **選擇決策複雜度**：簡單通用任務可用單步循環（如 ReAct），高複雜度任務再引入多步評估與搜尋（如 Tree of Thoughts），並可把記憶總結延後到對話結束後再寫入。

## 對後續研究的影響

CoALA 成功把碎片化的 Agent 研究收斂為共通語言（Memory / Action Space / Decision Cycle），並明確指出「動態修改與遺忘過時記憶（Unlearning）」是下一代 Agent 系統必須補上的關鍵拼圖 [CoALA 2024, Sec. 4.5, Sec. 6]。
