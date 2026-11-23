# 初學者學習路線圖：從零看懂 Agent Memory

- **類型**：跨文獻綜合比較頁（`syntheses/`）
- **核心目標**：將 6 篇頂刊／頂會與系統論文串聯成一條「非資工系也聽得懂」的 5 站教學故事線，作為後續 HTML 簡報大綱的核心骨幹。
- **相關連結**：[認知與工程分類架構](../concepts/memory-taxonomy.md) ｜ [記憶的三階段生命週期](../concepts/memory-operations-lifecycle.md) ｜ [圖結構與聯想式記憶](../concepts/graph-associative-memory.md) ｜ [記憶動態演化機制](../concepts/memory-evolution.md) ｜ [六大研究流派與權衡](paradigm-and-tradeoff-comparison.md)

---

## 五站理解 Agent Memory

1. **第一站：破除迷思（為什麼 AI 會有金魚腦？）**
   - `Context Window` 只是眼前的書桌大小，不是永久記憶；硬塞超長對話不但貴且慢，還會造成位置偏誤（Lost in the Middle） [Memory Survey 2024, Sec. 5.2.1; Mem0 2025, Sec. 1]。
2. **第二站：記憶的種類（該把資料放哪裡？）**
   - 依 [CoALA (2024)](../papers/coala-2024.md) 拆出工作記憶、情節記憶、語義記憶與程序記憶；並透過 [Memory Survey (2024)](../papers/agent-memory-survey-2024.md) 了解「文字記憶（好改好查）」與「參數記憶（難更新）」的取捨。
3. **第三站：記憶怎麼運作？（寫入、整理／遺忘、讀取）**
   - 從 [Generative Agents (2023)](../papers/generative-agents-2023.md) 的三維檢索＋「定期反思」，進階到 Survey 的「寫入 → 管理/遺忘 → 讀取」生命週期，理解「忘掉舊偏好」同樣關鍵 [Memory Survey 2024, Sec. 5.3; Mem0 2025, Sec. 2.1]。
4. **第四站：如何越記越聰明？（圖譜聯想與卡片盒演化）**
   - [HippoRAG (2024)](../papers/hipporag-2024.md) 模仿人腦海馬迴把分散知識連成圖；[A-MEM (2025)](../papers/a-mem-2025.md) 模仿卡片盒筆記法，讓新經驗回頭升級舊記憶。
5. **第五站：上線做產品的現實考量（省錢、低延遲與流派差異）**
   - [Mem0 (2025)](../papers/mem0-2025.md) 用動態萃取把 Token 砍掉超過 90%；同時理解各流派基準與指標的 `⚠️ 觀點差異`，依應用場景選配最適架構 [paradigm-and-tradeoff-comparison.md](paradigm-and-tradeoff-comparison.md)。
