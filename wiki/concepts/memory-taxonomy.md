# Agent Memory 分類架構（認知視角 vs 實作視角）

- **類型**：核心概念頁（`concepts/`）
- **核心來源**：[CoALA (2024)](../papers/coala-2024.md) ｜ [LLM Agent Memory Survey (2024)](../papers/agent-memory-survey-2024.md)
- **相關連結**：[CoALA 框架](../entities/coala.md) ｜ [概念：記憶的三階段生命週期](memory-operations-lifecycle.md) ｜ [初學者學習路線圖](../syntheses/beginner-learning-path.md)

---

## 1. 為什麼 Context Window 不是「記憶」？

剛接觸 AI 的使用者常把對話視窗的字數上限（`Context Window`）誤認為 AI 的記憶力。然而，LLM 本質上是**無狀態（Stateless）**的，每次呼叫都是獨立運算；對話一重開就得從頭介紹自己 [CoALA 2024, Sec. 4.1]。更關鍵的是，就算把幾十萬字的歷史全部塞進單一超長 Prompt，除了推論速度變慢、Attention 計算呈平方倍暴增外，模型還容易忽略擺在對話中間的關鍵線索（位置偏誤 / Lost in the Middle），並隨著距離拉長而衰減檢索品質 [Memory Survey 2024, Sec. 5.2.1; Mem0 2025, Sec. 1]。

因此，學界提出了兩種截然不同但互補的記憶分類藍圖。

---

## 2. 視角一：CoALA 的「認知功能分類」（按記憶用途拆解）

[CoALA (2024)](../papers/coala-2024.md) 借鏡人類心理學與 Soar 認知架構，把記憶分成「短期中樞」與三種「長期模組」 [CoALA 2024, Sec. 4.1]：

| 記憶模組 | 人類生活類比 | AI Agent 中的核心用途 |
| :--- | :--- | :--- |
| **Working Memory（工作記憶）** | 眼前的「書桌桌面」 | 跨多次 LLM 呼叫保存當前目標、觀察與剛調閱的變數資料結構 [CoALA 2024, Sec. 4.1] |
| **Episodic Memory（情節記憶）** | 「私人日記本」 | 保存過去事件的時序紀錄、對話軌跡與任務案例 [CoALA 2024, Sec. 4.1] |
| **Semantic Memory（語義記憶）** | 「百科全書與筆記本」 | 保存關於世界與用戶的事實、知識與反思歸納出的抽象規則 [CoALA 2024, Sec. 4.1, Sec. 4.5] |
| **Procedural Memory（程序記憶）** | 「騎腳踏車的肌肉記憶＋SOP」 | 隱含於 LLM 權重之中，或顯式寫成 Agent 程式碼與技能庫（修改程式碼風險最高） [CoALA 2024, Sec. 4.1] |

---

## 3. 視角二：ACM TOIS 綜述的「工程來源與形式分類」

[LLM Agent Memory Survey (2024)](../papers/agent-memory-survey-2024.md) 則從系統設計角度切入，按「來源」與「儲存載體形式」分類 [Memory Survey 2024, Sec. 3.2–3.3, Sec. 5.1–5.2]：
- **依來源（Sources）**：區分為「單次任務內記憶（Inside-trial，狹義）」、「跨任務經驗記憶（Cross-trial）」與「外部知識（External Knowledge，如維基百科或 API）」。
- **依儲存形式（Forms）**：
  - **Textual Form（文字形式）**：包含完整歷史、近期快取、檢索型摘要、外部知識；**寫入快、人類可讀可除錯**，但受限於 Prompt 長度與讀取延遲 [Memory Survey 2024, Sec. 5.2.1, Sec. 5.2.3]。
  - **Parametric Form（參數形式）**：透過微調或知識編輯將記憶寫入模型權重；**讀取時不佔 Context**，但寫入極昂貴且有「災難性遺忘」風險 [Memory Survey 2024, Sec. 5.2.2, Sec. 5.2.3]。

---

## 4. ⚠️ 觀點差異：兩套分類法衝突嗎？該用哪一套？

- **分類出發點不同**：
  - **CoALA (2024)** 採「**心理與認知功能**」視角（問的是：這段記憶是事件、事實還是操作技能？），較適合設計具備自我推理與技能累積的自主型 Agent。
  - **ACM TOIS Survey (2024)** 採「**資料來源與儲存載體**」視角（問的是：資料存在文字庫還是模型參數裡？跨任務嗎？），較適合系統工程師評估讀寫延遲與可解釋性。
- **實務並陳結論**：兩者並非互斥而是正交切面——例如 [Generative Agents (2023)](../papers/generative-agents-2023.md) 在 CoALA 中屬於「情節＋語義記憶」，在 Survey 中則同時歸類為「文字形式（Textual）＋檢索取得（Retrieved）＋單一模擬脈絡（Inside-trial）」。
