# Slide 09：⚠️ 觀點差異 — 六大研究怎麼對照？數字能直接比嗎？

- **對應卡片**：`card-01`, `card-02`, `card-03`, `card-04`, `card-05`, `card-06`
- **出處**：`wiki/concepts/memory-taxonomy.md`, `wiki/syntheses/paradigm-and-tradeoff-comparison.md`, `wiki/concepts/graph-associative-memory.md` `[概念：分類架構 Sec. 4; 綜合比較 Sec. 2; Mem0 2025, Sec. 3.1-3.2, Sec. 4.1-4.2, Sec. 4.5, Table 1, Table 2]`

---

### 讀論文時最容易踩的三個比較陷阱

- **分類視角不同**：CoALA 按「認知功能（工作／情節／語義／程序）」分，ACM TOIS 綜述按「文字 vs 參數形式」與「操作循環」分 [CoALA 2024, Sec. 4.1; Memory Survey 2024, Sec. 5.2, Sec. 5.3]。
- **同測 LoCoMo 也不可直接比**：A-MEM 含 Adversarial（拒答無解題）並用 F1；Mem0 排除該題組並改採評分 J [A-MEM 2025, Sec. 4.1; Mem0 2025, Sec. 3.1-3.2]。
- **圖譜並非全面較優**：`Mem0^g` 單跳／多跳反輸純文字 `Mem0`，儲存與檢索延遲約 2–3 倍（總 p95 由 1.440 增至 2.590 秒） [Mem0 2025, Sec. 4.1, Sec. 4.5, Table 2]。
