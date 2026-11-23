# Slide 05：記憶的一生 — 寫入、整理／遺忘、讀取循環

- **對應卡片**：`card-03`, `card-06`
- **出處**：`wiki/papers/agent-memory-survey-2024.md`, `wiki/concepts/memory-operations-lifecycle.md` `[Memory Survey 2024, Sec. 5.2, Sec. 5.3]`

---

### ACM TOIS 綜述：好記憶不能只存不刪

- **兩種儲存載體**：**文字記憶**寫入快、人類讀得懂，但佔用 Context；**參數記憶**（微調/編輯）不佔 Context，卻寫入貴且怕災難性遺忘 [Memory Survey 2024, Sec. 5.2.3]。
- **三階段生命週期**：
  1. **Memory Writing（寫入）**：過濾「哈囉、謝謝」等雜訊，留下精簡事實 [Memory Survey 2024, Sec. 5.3.1]。
  2. **Memory Management（管理與遺忘）**：合併重複、提煉反思，並淘汰過時事實 [Memory Survey 2024, Sec. 5.3.2]。
  3. **Memory Reading（讀取）**：依當前問題只撈最關鍵記憶送入 LLM [Memory Survey 2024, Sec. 5.3.3]。
