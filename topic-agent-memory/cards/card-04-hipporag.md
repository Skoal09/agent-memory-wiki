# card-04：HippoRAG (2024) 證據卡

- **Wiki 來源**：`wiki/papers/hipporag-2024.md`, `wiki/entities/hipporag.md`
- **發表出處**：**NeurIPS 2024**（Advances in Neural Information Processing Systems 37；`arXiv:2405.14831`）。
- **給初學者的一句話比喻**：傳統向量搜尋把段落分開鎖在抽屜裡；HippoRAG 模仿人腦「海馬迴記憶索引」，把分散在多篇文章的名詞與關係連成一張聯想網，一步跳躍就能串起完整線索。
- **核心機制**：
  - **OpenIE 建圖（人工新皮質）**：離線用 LLM（`GPT-3.5-turbo-1106` 或 `Llama-3.1`）抽出「無固定 Schema」知識圖譜三元組；新增資料只需加邊，不必重算整棵摘要樹 [HippoRAG 2024, Sec. 2.2, Sec. 2.3, Sec. 6.1]。
  - **PHR 同義詞邊（海馬迴旁區）**：用 `Contriever` 或 `ColBERTv2` 找出相似度高於 `τ = 0.8` 的節點加上同義邊 [HippoRAG 2024, Sec. 2.3, Sec. 3.4]。
  - **PPR 單步圖搜尋＋節點專一性**：查詢時將問題實體乘上節點專一性 `s_i = |P_i|^{-1}` 降權常見詞，再跑 Personalized PageRank（damping `0.5`）一步擴散召回跨段落關聯 [HippoRAG 2024, Sec. 2.3, Sec. 3.4]。
- **關鍵實驗數據**（各驗證集抽 `1,000` 題多跳問答 [HippoRAG 2024, Sec. 3.1, Sec. 4, Sec. 5.2]）：
  - `2WikiMultiHopQA` 單步 `Recall@5`：`HippoRAG (Contriever)` 達 `89.5%`、`HippoRAG (ColBERTv2)` 達 `89.1%`，領先最強單步基準 `ColBERTv2`（`68.2%`）約 `20` 個百分點；結合 `IRCoT` 更達 `93.9%`（QA F1 `62.7%`）。
  - 嚴格全支持段落指標 `All-Recall@5` 在 `2WikiMultiHopQA` 從 `37.1%` 跳升至 `75.7%`（差距達 `38` 個百分點）。
  - `MuSiQue` 單步 `Recall@5` 達 `52.1%`（較基準 `49.2%` 高約 `3` 個百分點）。
  - **效率優勢**：與多步迭代 `IRCoT` 相比品質相當或更佳，但線上檢索**便宜 `10–30` 倍、速度快 `6–13` 倍**。
- **已知限制**：元件未經微調，主要錯誤來自長文件 NER 與 OpenIE 抽取一致性，極大規模圖譜擴展性待驗證 [HippoRAG 2024, Sec. 7]。
