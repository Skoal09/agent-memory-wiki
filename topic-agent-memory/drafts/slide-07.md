# Slide 07：會自己長大的筆記本 — A-MEM 卡片盒記憶演化

- **對應卡片**：`card-05`
- **出處**：`wiki/papers/a-mem-2025.md`, `wiki/concepts/memory-evolution.md` `[A-MEM 2025, Sec. 3.1-3.3, Sec. 4.3, Sec. 4.4, Table 1, Table 3]`

---

### 為什麼記憶不能「寫完就凍結」？

- **卡片盒筆記法（Zettelkasten）**：每段互動自動產生含關鍵字、標籤與脈絡描述的原子卡片 [A-MEM 2025, Sec. 3.1]。
- **動態牽線＋舊記憶演化**：新卡片連上歷史近鄰後，會觸發 LLM **回頭更新舊卡片的描述與標籤**，讓知識網越用越有條理 [A-MEM 2025, Sec. 3.2, Sec. 3.3]。
- **實測成效**：在 LoCoMo（GPT-4o-mini/4o）較基線（約 16,900 tokens）省 85–93% Token；GPT-4o-mini 拿掉連結與演化後，Multi-Hop F1 從 27.02 跌至 9.65 [A-MEM 2025, Sec. 4.3, Sec. 4.4, Table 3]。
