# A Survey on the Memory Mechanism of Large Language Model based Agents

- **類型**：單篇論文摘要（`papers/`）
- **作者**：Zeyu Zhang, Xiaohe Bo, Chen Ma, Rui Li, Xu Chen, Quanyu Dai, Jieming Zhu, Zhenhua Dong, Ji-Rong Wen（中國人民大學、華為諾亞方舟實驗室）
- **發表出處**：**ACM Transactions on Information Systems (TOIS)**（CORE A*、CCF A 類、JCR Q1 頂級期刊）
- **原始檔案**：[raw/agent-memory-survey-2024.md](../../raw/agent-memory-survey-2024.md)（`arXiv:2404.13501`）
- **相關連結**：[概念：Agent Memory 認知分類架構](../concepts/memory-taxonomy.md) ｜ [概念：記憶的三階段生命週期](../concepts/memory-operations-lifecycle.md) ｜ [綜合比較：六大研究流派與權衡](../syntheses/paradigm-and-tradeoff-comparison.md)

---

## 1. 這篇綜述要解決什麼問題？

過去關於 LLM Agent 記憶的研究分散在各篇論文中，缺乏統一的定義與比較框架 [Memory Survey 2024, Sec. 1]。這篇發表於 ACM TOIS 的綜述首次從「**記憶是什麼（What）、為什麼需要（Why）、如何實作與評估（How）**」三大面向系統化梳理整個領域 [Memory Survey 2024, Sec. 1, Sec. 3–6]。

## 2. 狹義 vs 廣義的 Agent Memory 定義

- **狹義定義（Inside-trial）**：只保留單一任務回合（Trial）內先前的行動與觀察軌跡，任務結束就清空 [Memory Survey 2024, Sec. 3.2, Sec. 3.4]。
- **廣義定義（Cross-trial + External）**：同時整合三種來源：（1）同一回合內的互動歷史、（2）跨回合累積的成功與失敗經驗、（3）外部知識庫（如 Wikipedia 或專業資料庫） [Memory Survey 2024, Sec. 3.3, Sec. 5.1]。

## 3. 記憶實作的三大支柱（Sources × Forms × Operations）

### (1) 記憶形式（Memory Forms）的兩種路線 [Memory Survey 2024, Sec. 5.2]
- **Textual Form（文字形式）**：以自然語言或結構化資料保存，包含四種做法：完整歷史拼接（Complete）、只留近期（Recent）、檢索取用（Retrieved）與外部工具知識（External）。優點是**寫入快、可解釋性高**，但受限於 Prompt 長度與推論延遲，且長上下文會受「Lost in the Middle」位置偏誤影響 [Memory Survey 2024, Sec. 5.2.1, Sec. 5.2.3]。
- **Parametric Form（參數形式）**：透過微調（Fine-tuning）或知識編輯（Memory Editing）把知識寫進模型權重。優點是**讀取時不佔 Context 長度**，但寫入成本高且有過擬合與「災難性遺忘（Catastrophic Forgetting）」風險 [Memory Survey 2024, Sec. 5.2.2, Sec. 5.2.3]。

### (2) 三大記憶操作循環（Memory Operations） [Memory Survey 2024, Sec. 3.4, Sec. 5.3]
論文將記憶運作寫成統一公式 `a_{t+1} = LLM{ R( P(M_{t-1}, W({a_t, o_t})), c_{t+1} ) }`，拆解為：
1. **Memory Writing（寫入 `W`）**：過濾冗長雜訊，把原始互動轉換為精簡摘要或結構化關係。
2. **Memory Management（管理 `P`）**：進行反思（Reflection）提煉抽象規則、合併冗餘條目（Merging），並**遺忘（Forgetting）**過時或不重要內容。
3. **Memory Reading（讀取 `R`）**：依當前任務需求檢索關鍵記憶送入 LLM。

## 4. 如何評估一個記憶模組？ [Memory Survey 2024, Sec. 6]

- **直接評估（Direct Evaluation）**：主觀評估（人工判斷連貫性 Coherence 與合理性 Rationality）＋客觀評估（答案正確率 Correctness、參考記憶檢索 F1、執行時間與 GPU 記憶體消耗）。
- **間接評估（Indirect Evaluation）**：透過多輪對話一致性、跨來源問答（Multi-source QA）等下游任務表現檢驗記憶效益。
