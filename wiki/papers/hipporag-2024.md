# HippoRAG: Neurobiologically Inspired Long-Term Memory for Large Language Models

- **類型**：單篇論文摘要（`papers/`）
- **作者**：Bernal Jiménez Gutiérrez, Yiheng Shu, Yu Gu, Michihiro Yasunaga, Yu Su（Ohio State University）
- **發表出處**：**NeurIPS 2024**（Advances in Neural Information Processing Systems 37）
- **原始檔案**：[raw/hipporag-2024.md](../../raw/hipporag-2024.md)（`arXiv:2405.14831`）
- **相關連結**：[概念：圖結構與聯想式記憶](../concepts/graph-associative-memory.md) ｜ [系統：HippoRAG 架構](../entities/hipporag.md) ｜ [綜合比較：六大研究流派與權衡](../syntheses/paradigm-and-tradeoff-comparison.md)

---

## 1. 這篇論文要解決什麼問題？

傳統 RAG（Retrieval-Augmented Generation）雖然能幫靜態 LLM 補充外部資料，但它把每段文章**各自獨立編碼（Encoded in isolation）** [HippoRAG 2024, Sec. 1, Fig. 1]。只要兩個線索分散在不同段落（例如 A 文件寫「Prof. Thomas 在 Stanford 任教」、B 文件寫「Thomas 專研阿茲海默症神經科學」），一般向量搜尋就很難把它們串在一起；若改用 IRCoT 這類反覆多步查詢，又會非常慢且昂貴 [HippoRAG 2024, Sec. 1, Sec. 5.3]。

## 2. 靈感來源與核心架構：人工「海馬迴索引」

論文借鏡神經科學的**海馬迴記憶索引理論（Hippocampal Memory Indexing Theory）**，用三個模組對應人腦分工，兼顧模式分離（Pattern Separation）與模式補全（Pattern Completion） [HippoRAG 2024, Sec. 2.1, Sec. 2.2]：
1. **離線建立索引（Offline Indexing）** [HippoRAG 2024, Sec. 2.2, Sec. 2.3]：
   - **人工新皮質（LLM + OpenIE）**：利用指令微調 LLM（如 `GPT-3.5-turbo-1106` 或 `Llama-3.1`）從文章抽取「無固定結構（Schemaless）」知識圖譜三元組，建立名詞片語節點 `N` 與關係邊 `E`。
   - **人工海馬迴旁區（Parahippocampal Regions, PHR）**：用檢索編碼器（如 `Contriever` 或 `ColBERTv2`）計算節點向量相似度，超過門檻 `τ = 0.8` 就加上同義詞邊 `E'`。
2. **線上單步聯想檢索（Online Retrieval）** [HippoRAG 2024, Sec. 2.3, Sec. 3.4]：
   - 先由 LLM 從問題抽取出查詢實體（Query Nodes），並乘上具神經生物學意義的**節點專一性（Node Specificity `s_i = |P_i|^{-1}`）**（類似局部版 IDF，降低高頻泛用詞的干擾）。
   - 在整個知識圖譜上執行 **Personalized PageRank (PPR)**（damping factor `0.5`），讓機率沿著圖譜邊緣「一步擴散」到跨段落的關聯節點，再映射回原始文章排序。

## 3. 實驗數據與關鍵表現

在每個驗證集抽取 `1,000` 題的多跳問答基準測試中 [HippoRAG 2024, Sec. 3.1, Sec. 4, Sec. 5.2]：
- **單步檢索準確率（Recall@5）** [HippoRAG 2024, Sec. 4, Table 2]：
  - 在 `2WikiMultiHopQA` 上，`HippoRAG (Contriever)` 達到 `89.5%`、`HippoRAG (ColBERTv2)` 達到 `89.1%`，比最強單步基準 `ColBERTv2`（`68.2%`）高出約 `20` 個百分點；在 `MuSiQue` 上亦高出約 `3` 個百分點（`52.1%` vs `49.2%`）。
  - 在「必須找齊全部支持段落」的 `All-Recall@5` 指標上，`2WikiMultiHopQA` 從 `37.1%` 大幅跳升至 `75.7%`（差距達 `38` 個百分點） [HippoRAG 2024, Sec. 5.2, Table 6]。
- **與多步迭代檢索（IRCoT）比較** [HippoRAG 2024, Sec. 1, Sec. 4, Sec. 5.2]：
  - 單步 `HippoRAG` 的問答品質可媲美甚至超越多步迭代的 `IRCoT`，但線上檢索階段**便宜 `10–30` 倍、速度快 `6–13` 倍**。
  - 若把 `HippoRAG` 與 `IRCoT` 結合，`2WikiMultiHopQA` R@5 可進一步達到 `93.9%`（QA F1 達 `62.7%`） [HippoRAG 2024, Table 3, Table 4]。

## 4. 限制與未來方向

作者在結尾指出：目前所有元件皆未經微調，主要錯誤來自命名實體辨識（NER）與開放資訊抽取（OpenIE）在長文件中的一致性，且極大規模圖譜的擴展性仍有待驗證 [HippoRAG 2024, Sec. 7]。
