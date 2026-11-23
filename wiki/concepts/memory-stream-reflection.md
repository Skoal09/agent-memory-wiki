# 記憶流與反思機制（Memory Stream & Reflection）

- **類型**：核心概念頁（`concepts/`）
- **核心來源**：[Generative Agents (2023)](../papers/generative-agents-2023.md)
- **相關系統**：[Generative Agents](../entities/generative-agents.md) ｜ [概念：Agent Memory 認知分類架構](memory-taxonomy.md)

---

## 1. 為什麼「把聊天紀錄全部摘要」不夠用？

許多人直覺以為「記憶太長就請 AI 摘要成一段話」。但 [Generative Agents (2023)](../papers/generative-agents-2023.md) 指出：把所有經驗壓縮成籠統摘要，會讓模型回答變得空洞（例如把咖啡廳老闆描述成「常做清潔與合作」），反而弄丟了最關鍵的「正在籌備情人節派對」這件事 [Generative Agents 2023, Sec. 4.1]。因此需要把完整經歷存成 **Memory Stream**，再依情境精準撈取。

---

## 2. 檢索記憶的三把尺（Recency × Importance × Relevance）

Memory Stream 是一份隨時間增長的自然語言事件清單，每筆事件在被取用時會計算三個分數（經 `[0, 1]` min-max 正規化後以等權 `α = 1` 相加） [Generative Agents 2023, Sec. 4.1]：

1. **Recency（近期性）**：剛發生的事分數高，越久未存取則依指數衰減（衰減率 `0.995` / 模擬小時）。
2. **Importance（重要性）**：區分「刷牙吃早餐（`1–2` 分）」與「告白／分手／錄取通知（`8–10` 分）」，由 LLM 在記憶寫入當下評分。
3. **Relevance（相關性）**：與「當下被問到的問題」有多相關，透過文字向量（Embedding）的餘弦相似度計算。

---

## 3. Reflection（反思）：從「流水帳」進化成「洞察」

只有原始觀察還是不夠！如果只記下幾百條「Klaus 早上看書」、「Klaus 中午在圖書館」，AI 還是無法歸納出「Klaus 是個極度投入研究的人」，甚至在回答「想找誰聊天」時只挑出最常在走廊遇到卻沒深交的鄰居 Wolfgang [Generative Agents 2023, Sec. 4.2]。

因此，架構設計了週期性的 **Reflection（反思）** 流程 [Generative Agents 2023, Sec. 4.2]：
1. **觸發條件**：當新事件的重要性分數累加超過 `150`（實作中大約每天 `2–3` 次）。
2. **自我提問**：檢視最近 `100` 筆記憶，讓 LLM 列出最值得回答的 `3` 個高層次問題。
3. **檢索與歸納**：針對每個問題從 Memory Stream 撈出相關條目，萃取出 `5` 條附帶證據編號的抽象洞見。
4. **遞迴成樹**：反思結果本身也會被存回 Memory Stream，下次反思還可基於舊反思再往上提煉，形成「反思樹（Reflection Tree）」。

消融實驗證明：拿掉 Reflection 之後，Agent 回答可信度（TrueSkill `μ`）從完整版的 `29.89` 顯著下降至 `26.88` [Generative Agents 2023, Sec. 6.5.1]。
