# Slide 08：走向真實產品 — Mem0 如何兼顧省錢、低延遲與除舊

- **對應卡片**：`card-06`
- **出處**：`wiki/papers/mem0-2025.md`, `wiki/entities/mem0.md` `[Mem0 2025, Abstract, Sec. 2.1, Sec. 2.2, Sec. 4.1, Sec. 4.3-4.5, Table 1, Table 2]`

---

### 線上產品怎麼省錢又快速？

- **`Mem0`**：從摘要與近 10 句抽事實，經 Tool Call 執行 `ADD / UPDATE / DELETE / NOOP` [Mem0 2025, Sec. 2.1]。
- **LOCOMO**：`Full-Context` 需 26,031 tokens、17.117 秒（LLM-as-a-Judge J=72.90%）；Mem0 僅 1,764 tokens（省 >90%）、p95 為 1.440 秒（降 >91%） [Mem0 2025, Table 2]。
- **圖版 `Mem0^g`**：Neo4j 標記衝突舊關係失效；總 J=68.44%（Mem0 66.88%，勝 OpenAI 52.90%），時間 J=58.13 [Mem0 2025, Sec. 2.2, Table 1]。
