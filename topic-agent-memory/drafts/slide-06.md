# Slide 06：跨文章聯想記憶 — HippoRAG 模仿人腦海馬迴

- **對應卡片**：`card-04`
- **出處**：`wiki/papers/hipporag-2024.md`, `wiki/concepts/graph-associative-memory.md` `[HippoRAG 2024, Sec. 1, Sec. 2.3, Sec. 3.4, Sec. 4, Sec. 5.2, Table 2, Table 6]`

---

### 線索分散在不同文章時，為什麼一般 RAG 找不到？

- 傳統 RAG 各自獨立編碼段落，跨段線索難以串聯 [HippoRAG 2024, Sec. 1]。
- **人工海馬迴索引**：離線抽成無固定結構知識圖譜並加同義邊（門檻 τ=0.8） [HippoRAG 2024, Sec. 2.3, Sec. 3.4]。
- **單步聯想（PPR）**：在 2WikiMultiHopQA（1,000 題）單步 R@5 達 89.5%，領先基準 ColBERTv2（68.2%）約 20 個百分點；All-Recall@5 更從 37.1% 升至 75.7% [HippoRAG 2024, Table 2, Table 6]。
- 問答品質媲美或勝過多步 IRCoT，線上便宜 10–30 倍、快 6–13 倍 [HippoRAG 2024, Sec. 1]。
