# Slide 02：破除迷思 — Context Window 只是「書桌」

- **對應卡片**：`card-02`, `card-03`, `card-06`
- **出處**：`wiki/concepts/memory-taxonomy.md`, `wiki/papers/agent-memory-survey-2024.md`, `wiki/papers/mem0-2025.md` `[CoALA 2024, Sec. 4.1; Memory Survey 2024, Sec. 5.2.1; Mem0 2025, Sec. 1]`

---

### 對話視窗拉到幾十萬字，為什麼還不夠？

- **Context Window = 眼前的書桌**：放得進當下要看的文件，但對話重開桌面就清空 [CoALA 2024, Sec. 4.1]。
- **硬塞全歷史的三個代價**：
  1. Attention 計算量隨長度呈平方級暴增，造成推論延遲極高 [Memory Survey 2024, Sec. 5.2.1]。
  2. 容易發生 **Lost in the Middle**：擺在超長對話中間的線索常被忽略 [Memory Survey 2024, Sec. 5.2.1]。
  3. 大量無關閒聊會稀釋關鍵事實並推高成本 [Mem0 2025, Sec. 1]。
