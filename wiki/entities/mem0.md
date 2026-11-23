# Mem0 與 Mem0^g 架構（生產級可擴展長記憶層）

- **類型**：代表系統與架構頁（`entities/`）
- **出處論文**：[Mem0: Building Production-Ready AI Agents with Scalable Long-Term Memory (2025)](../papers/mem0-2025.md)
- **發表場域**：arXiv Preprint 2025
- **相關頁面**：[概念：記憶的三階段生命週期](../concepts/memory-operations-lifecycle.md) ｜ [概念：圖結構與聯想式記憶](../concepts/graph-associative-memory.md) ｜ [系統：A-MEM 系統](a-mem.md)

---

## 系統定位

Mem0 主打「可直接部署進線上產品」的高效率記憶中間層。不同於只管寫入不管汰舊的紀錄流，Mem0 透過精準的事實萃取與 Tool-call 增量更新（`ADD / UPDATE / DELETE / NOOP`），在保留核心用戶記憶的同時把延遲與 Token 帳單壓到極低 [Mem0 2025, Sec. 2.1, Sec. 4.3]。

## 兩個版本的分工比較

- **`Mem0`（向量＋自然語言事實庫）**：每次對話只攜帶約 `1,764` tokens 的精煉記憶，總 p95 延遲僅 `1.440` 秒，在單跳（Single-Hop `J=67.13`）與一般多跳（Multi-Hop `J=51.15`）問答上反應最快、準確率高 [Mem0 2025, Sec. 4.1, Table 1, Table 2]。
- **`Mem0^g`（整合 Neo4j 知識圖譜）**：除了自然語言事實外額外維護有向標籤圖譜，並以「標記失效而非直接刪除」處理衝突舊事實；整體分數最高（`J=68.44`），尤其在時間順序推理（Temporal `J=58.13`）領先所有基準，代價是記憶儲存空間與檢索延遲約為基礎版的 2–3 倍（總 p95 延遲 `2.590` 秒） [Mem0 2025, Sec. 2.2, Sec. 4.2, Sec. 4.5, Table 2]。
