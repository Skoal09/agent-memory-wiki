# 綜合比較：六大 Agent Memory 研究流派與設計權衡

- **類型**：跨文獻綜合比較頁（`syntheses/`）
- **涵蓋來源**：[Generative Agents (2023)](../papers/generative-agents-2023.md) ｜ [CoALA (2024)](../papers/coala-2024.md) ｜ [Memory Survey (2024)](../papers/agent-memory-survey-2024.md) ｜ [HippoRAG (2024)](../papers/hipporag-2024.md) ｜ [A-MEM (2025)](../papers/a-mem-2025.md) ｜ [Mem0 (2025)](../papers/mem0-2025.md)
- **相關連結**：[初學者學習路線圖](beginner-learning-path.md) ｜ [HippoRAG 架構](../entities/hipporag.md) ｜ [A-MEM 系統](../entities/a-mem.md) ｜ [Mem0 架構](../entities/mem0.md)

---

## 1. 六篇代表性研究橫向總覽

| 論文／系統 | 發表場域 | 核心隱喻／設計靈感 | 主要解決的痛點 | 關鍵代表指標 |
| :--- | :--- | :--- | :--- | :--- |
| **Generative Agents (2023)** | ACM UIST 2023 (A*) | 小鎮生活日記＋定期反思樹 | 角色在長模擬中失憶、無法歸納抽象印象 | 完整版可信度 TrueSkill `μ=29.89` vs 無記憶 `21.21` [Generative Agents 2023, Sec. 6.5.1] |
| **CoALA (2024)** | TMLR 2024 | 認知科學（工作／情節／語義／程序記憶） | 術語混亂，缺乏統一設計與權限邊界藍圖 | 盤點 SayCan/ReAct/Voyager 等五大系統架構 [CoALA 2024, Table 2] |
| **Memory Survey (2024)** | ACM TOIS (A*) | 寫入 × 管理（合併/反思/遺忘）× 讀取 | 研究碎片化，缺文字 vs 參數記憶權衡分析 | 系統化分類 28+ 代表模型與直接／間接評測法 [Memory Survey 2024, Table 1–3, Sec. 6] |
| **HippoRAG (2024)** | NeurIPS 2024 | 人腦海馬迴索引＋Personalized PageRank | 傳統 RAG 片段孤立，跨文件多跳聯想失敗 | `2Wiki` R@5 提升約 `20%`；比 IRCoT 省 `10–30×` 成本、快 `6–13×` [HippoRAG 2024, Abstract, Table 2] |
| **A-MEM (2025)** | NeurIPS 2025 | 卡片盒筆記法（Zettelkasten）自我演化 | 寫死 Schema 太僵化、舊記憶不會隨經驗進化 | LoCoMo Token 省 `85–93%`；DialSim F1 比 MemGPT 高 `192%` [A-MEM 2025, Sec. 4.3] |
| **Mem0 / Mem0^g (2025)** | arXiv Preprint | 生產級增量萃取與增刪改（＋Neo4j 圖譜） | 超長對話 Context 太慢太貴、新舊偏好衝突 | 相比 Full-Context 省 `>90%` Token、降 `91%` p95 延遲 [Mem0 2025, Abstract, Table 2] |

---

## 2. ⚠️ 觀點差異：為什麼不能直接拿不同論文的數字互相比較？

初學者讀論文時最容易犯的錯，就是把各篇報告的百分比排在一起比高低。仔細對照 `raw/` 原文會發現三個關鍵差異，必須同時告知讀者：

1. **測試基準（Benchmark）與任務型態完全不同**：
   - `Generative Agents` 測的是**人類對模擬社交可信度的主觀排序（TrueSkill）** [Generative Agents 2023, Sec. 6.4]。
   - `HippoRAG` 測的是**靜態多文件百科問答（MuSiQue / 2WikiMultiHopQA）** 的檢索召回率 [HippoRAG 2024, Sec. 3.1]。
   - `A-MEM` 與 `Mem0` 測的則是**跨數十回合的長對話記憶（LoCoMo）** [A-MEM 2025, Sec. 4.1; Mem0 2025, Sec. 3.1]。
2. **⚠️ 即使同用 LoCoMo 資料集，`A-MEM` 與 `Mem0` 的評測設定也有重要差異**：
   - **題組範圍不同**：[A-MEM (2025)](../papers/a-mem-2025.md) 納入全部 `5` 類題型（共 `7,512` 題，包含測驗「能否識別無法回答問題」的 Adversarial 題型） [A-MEM 2025, Sec. 4.1]；而 [Mem0 (2025)](../papers/mem0-2025.md) 明確排除 Adversarial 題組 [Mem0 2025, Sec. 3.1]。
   - **評分指標與重跑差異**：`A-MEM` 原文主要報告字面重疊指標 `F1` 與 `BLEU-1`；`Mem0` 則認為 F1 會誤判「三月出生 vs 七月出生」，改採 `LLM-as-a-Judge (J)`，並在 `temperature=0` 下重跑 `A-MEM*` 得到 `J = 48.38%`（低於 `Mem0` 的 `66.88%` 與 `Mem0^g` 的 `68.44%`） [Mem0 2025, Sec. 3.2, Table 1, Table 2]。
3. **「是否該用知識圖譜」沒有單一正解**：
   - `HippoRAG` 證明圖譜＋PPR 在**跨文章多跳聯想**能帶來高達 `20%` 的檢索躍升；但 `Mem0` 在對話基準中實測發現，雖然 `Mem0^g` 在時間推理表現最佳，在較單純的 Single-Hop 與 Multi-Hop 反而略輸純自然語言事實庫 `Mem0`，且 Token 儲存與延遲都多出約 2–3 倍 [Mem0 2025, Sec. 4.1, Sec. 4.5]。

---

## 3. 給實作新手的選型決策樹

- **想從頭設計模組化 Agent 架構** → 先用 [CoALA](../entities/coala.md) 切分工作/情節/語義/程序記憶與讀寫權限。
- **做虛擬角色／長時程模擬** → 參考 [Generative Agents](../entities/generative-agents.md) 的 `Recency + Importance + Relevance` 與定期反思樹。
- **做大量跨文件知識庫問答（企業文件／論文搜尋）** → 採用 [HippoRAG](../entities/hipporag.md) 的 OpenIE 圖譜＋PPR 單步聯想。
- **做能隨用戶長期成長的個人筆記／研究助手** → 採用 [A-MEM](../entities/a-mem.md) 的 Zettelkasten 連結與舊記憶演化。
- **做低延遲、低成本線上客服或個人化聊天機器人** → 優先考慮 [Mem0](../entities/mem0.md) 的萃取＋增量更新管線（需要複雜時間軸推理再加圖譜）。
