# card-03：LLM Agent Memory Survey (2024) 證據卡

- **Wiki 來源**：`wiki/papers/agent-memory-survey-2024.md`
- **發表出處**：**ACM Transactions on Information Systems (TOIS)**（CORE A*、CCF A 類、JCR Q1 頂級期刊；`arXiv:2404.13501`）。
- **給初學者的一句話比喻**：把 AI 記憶拆成「存在哪種筆記本（文字 vs 模型權重）」與「寫入、整理／遺忘、讀取」三道日常檔案管理流程。
- **核心分類與機制**：
  - **狹義 vs 廣義定義** [Memory Survey 2024, Sec. 3.2–3.3]：狹義僅限單次任務內（Inside-trial）；廣義整合跨回合經驗（Cross-trial）與外部知識庫（External Knowledge）。
  - **Textual Form（文字形式）vs Parametric Form（參數形式）** [Memory Survey 2024, Sec. 5.2]：
    - 文字形式（完整、近期、檢索、外部）：**寫入快、可解釋性高**，但受限於 Prompt 長度與「Lost in the Middle」位置偏誤。
    - 參數形式（微調 Fine-tuning、知識編輯）：**讀取時不佔 Context**，但寫入昂貴且有「災難性遺忘（Catastrophic Forgetting）」風險。
  - **三階段記憶操作循環** `a_{t+1} = LLM{ R( P(M_{t-1}, W({a_t, o_t})), c_{t+1} ) }` [Memory Survey 2024, Sec. 3.4, Sec. 5.3]：**Memory Writing (`W`)** 過濾雜訊寫入精簡事實；**Memory Management (`P`)** 反思、合併冗餘並「遺忘」過時條目；**Memory Reading (`R`)** 檢索所需記憶。
- **評估方式**：直接評估（主觀連貫性/合理性＋客觀正確率、檢索 F1、耗時與 GPU 記憶體）與間接評估（長對話、多來源問答） [Memory Survey 2024, Sec. 6]。
