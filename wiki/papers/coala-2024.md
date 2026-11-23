# Cognitive Architectures for Language Agents (CoALA)

- **類型**：單篇論文摘要（`papers/`）
- **作者**：Theodore R. Sumers, Shunyu Yao, Karthik Narasimhan, Thomas L. Griffiths（Princeton University）
- **發表出處**：**Transactions on Machine Learning Research (TMLR, Feb 2024)**（經典頂刊 *JMLR* 姊妹刊，採 OpenReview 雙盲審查；該篇獲 **Featured Certification** 與 **Survey Certification** 雙認證）
- **原始檔案**：[raw/coala-2024.md](../../raw/coala-2024.md)（`arXiv:2309.02427`）
- **相關連結**：[概念：Agent Memory 認知分類架構](../concepts/memory-taxonomy.md) ｜ [系統：CoALA 框架](../entities/coala.md) ｜ [論文：Generative Agents (2023)](generative-agents-2023.md)

---

## 1. 這篇論文要解決什麼問題？

早期的 Language Agent 研究各自發明術語（如 tool use、grounding、reflection），缺乏統一的藍圖來比較不同系統（例如 ReAct、SayCan、Voyager、Generative Agents） [CoALA 2024, Sec. 1]。CoALA 借鏡人類認知科學與傳統符號 AI 認知架構（如 Soar 與 ACT-R），把「無狀態（Stateless）」的 LLM 重新定位為整個認知系統中的核心推理元件，建立標準化語言 [CoALA 2024, Sec. 1, Sec. 2.3, Sec. 4.1]。

## 2. CoALA 三大核心維度

### (1) 模組化記憶系統（Memory Modules）
CoALA 明確區分「短期工作記憶」與三大「長期記憶」 [CoALA 2024, Sec. 4.1]：
- **Working Memory（工作記憶）**：跨多次 LLM 呼叫持續維護的符號變數與狀態資料結構，存放目前感知輸入、活躍目標與從長期記憶檢索出的知識，作為各模組溝通的中樞（不只是單次 Prompt Context）。
- **Episodic Memory（情節記憶）**：記錄過去決策循環的事件序列與歷史軌跡（例如 [Generative Agents](generative-agents-2023.md) 的事件清單或過往任務軌跡）。
- **Semantic Memory（語義記憶）**：儲存關於世界與自身的事實與抽象知識（例如外部維基知識庫，或從失敗經驗反思出的新規則）。
- **Procedural Memory（程序記憶）**：包含「隱式知識（LLM 模型權重）」與「顯式知識（Agent 程式碼與可執行技能，例如執行檢索、推理、外部工具的程式流程）」。

### (2) 結構化行動空間（Action Space）
行動分成「對外」與「對內」兩大類 [CoALA 2024, Sec. 4, Sec. 4.2–4.5]：
- **External Actions — Grounding（接地行動）**：與物理環境、人類對話或數位環境（API、網頁、程式執行）互動並取得觀察回饋。
- **Internal Actions（內部記憶操作）**：
  - `Retrieval`：從長期記憶讀取資料進入工作記憶。
  - `Reasoning`：用 LLM 讀寫工作記憶，整理現況或進行模擬推理。
  - `Learning`：將新經驗、知識或技能程式碼寫回長期記憶（但修改程序記憶風險最高，容易引入 Bug 或偏離設計者意圖）。

### (3) 決策循環（Decision-Making Cycle）
像程式的 `main()` 主迴圈一樣持續運作：在**規劃階段（Planning）**透過檢索與推理提出候選行動（Proposal）、評估價值（Evaluation）、選出最佳選項（Selection），進入**執行階段（Execution）**執行接地或學習行動，取得新觀察後進入下一輪循環 [CoALA 2024, Sec. 4.6, Fig. 4B]。

## 3. 用 CoALA 盤點代表性 Agent 與關鍵洞見

在論文 Table 2 中，作者以統一規格對比多個經典 Agent [CoALA 2024, Sec. 5, Table 2]：
- **SayCan**：只具固定程序記憶（`551` 個外部技能），無學習/檢索。
- **ReAct**：結合內部推理與數位接地，但無長期情節/語義記憶。
- **Voyager**：擁有可寫入的長期「程序記憶（技能庫）」，會將成功寫出的 Minecraft 程式碼技能存起來重複使用。
- **Generative Agents**：具備長期「情節記憶（觀察）」與「語義記憶（反思）」，能進行提案式規劃。
- **Tree of Thoughts (ToT)**：無長期記憶，但具備完整的 `propose → evaluate → select` 搜尋決策。

## 4. 論文點出的未來缺口（與遺忘議題）

作者特別提醒：現有研究大多只關注「往記憶裡新增內容」，對於**修改或刪除過時記憶（Unlearning）**幾乎還沒有系統性研究 [CoALA 2024, Sec. 4.5, Sec. 6]；同時也需透過「可控性（Controllability）」界定外部環境（如公開 Wikipedia）與內部語義記憶（Agent 自己可控的離線知識庫）的邊界 [CoALA 2024, Sec. 7]。
