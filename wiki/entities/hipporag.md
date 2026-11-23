# HippoRAG 架構（海馬迴索引與知識圖譜檢索）

- **類型**：代表系統與架構頁（`entities/`）
- **出處論文**：[HippoRAG: Neurobiologically Inspired Long-Term Memory for Large Language Models (2024)](../papers/hipporag-2024.md)
- **發表場域**：NeurIPS 2024
- **相關頁面**：[概念：圖結構與聯想式記憶](../concepts/graph-associative-memory.md) ｜ [系統：Mem0 架構](mem0.md)

---

## 系統定位

HippoRAG 是一套專為「跨段落知識整合（Knowledge Integration）」設計的無須額外訓練的 RAG 長記憶架構，目標是解決傳統向量檢索「各自獨立編碼段落、找不到跨文件隱藏關聯」的盲點 [HippoRAG 2024, Sec. 1, Fig. 1]。

## 核心運作管線

1. **OpenIE 建圖（模擬大腦新皮質）**：離線階段用 LLM（如 `GPT-3.5-turbo-1106` 或 `Llama-3.1-70B-Instruct`）透過兩步驟 1-shot 提示抽出名詞片語節點與關係三元組，建立無 Schema 知識圖譜 [HippoRAG 2024, Sec. 2.2, Sec. 2.3, Sec. 5.1]。
2. **同義詞連結（模擬海馬迴旁區 PHR）**：用 `Contriever` 或 `ColBERTv2` 找出相似度高於 `τ = 0.8` 的節點加上同義邊，打通不同說法之間的斷點 [HippoRAG 2024, Sec. 2.3, Sec. 3.4]。
3. **PPR 單步圖搜尋（模擬海馬迴索引）**：查詢時先從問題抽出實體並以節點專一性 `s_i = |P_i|^{-1}` 降權常見詞，再透過 **Personalized PageRank** 一步算出圖譜關聯分數並匯總回原始段落排序 [HippoRAG 2024, Sec. 2.3]。

## 代表表現與適用場景

- 特別擅長「尋找路徑型（Path-finding）」多跳問題——當關鍵字從未同時出現在同一段落時（如尋找「在 Stanford 任教且研究阿茲海默症」的教授），`ColBERTv2` 與多步 `IRCoT` 皆失靈，HippoRAG 卻能透過圖譜關聯成功召回 [HippoRAG 2024, Sec. 5.3, Table 7]。
- 線上檢索比多步 `IRCoT` **便宜 10–30 倍、快 6–13 倍**，且新增知識時只需加邊而無須像 RAPTOR 或 GraphRAG 重新生成整棵摘要樹 [HippoRAG 2024, Sec. 1, Sec. 6.1]。
