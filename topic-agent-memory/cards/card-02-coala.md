# card-02：CoALA (2024) 證據卡

- **Wiki 來源**：`wiki/papers/coala-2024.md`, `wiki/entities/coala.md`
- **發表出處**：**Transactions on Machine Learning Research (TMLR, Feb 2024)**（*JMLR* 姊妹刊，雙盲審查；獲 **Featured Certification** 與 **Survey Certification**；`arXiv:2309.02427`）。
- **給初學者的一句話比喻**：把原本「無狀態（Stateless）」的 LLM 放進一個像人類大腦＋電腦作業架構的藍圖中，配上「書桌（工作記憶）、日記（情節）、百科（語義）與 SOP（程序記憶）」。
- **核心機制**：
  - **四大記憶模組** [CoALA 2024, Sec. 4.1]：
    - **Working Memory（工作記憶）**：跨多次 LLM 呼叫維護的符號變數與狀態中樞（不只是單次 Prompt）。
    - **Episodic Memory（情節記憶）**：過去決策循環的事件序列與歷史對話軌跡。
    - **Semantic Memory（語義記憶）**：關於世界與自身的事實、規則與抽象知識。
    - **Procedural Memory（程序記憶）**：包含隱式 LLM 權重與顯式 Agent 程式碼／技能庫（寫入修改風險最高）。
  - **行動空間與決策循環** [CoALA 2024, Sec. 4.2–4.6]：區分外部接地（Grounding）與內部記憶操作（`Retrieval` 讀取、`Reasoning` 推理、`Learning` 寫入）；依 `Propose → Evaluate → Select → Execute` 持續迴圈運作。
- **關鍵案例對照** [CoALA 2024, Sec. 5, Table 2]：SayCan（僅固定 `551` 個外部技能）、ReAct（無長記憶）、Voyager（可寫入長期程序技能庫）、Generative Agents（具長期情節與語義記憶）、ToT（無長記憶但具完整搜尋決策）。
- **安全邊界與研究缺口**：對高風險模組（如商品目錄語義記憶、程式碼程序記憶）應只開唯讀權限 [CoALA 2024, Sec. 6]；論文也點出**修改或刪除過時記憶（Unlearning）**幾乎尚無系統研究 [CoALA 2024, Sec. 4.5, Sec. 6]。
