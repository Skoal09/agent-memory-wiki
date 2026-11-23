# A-MEM 系統（Agentic Memory for LLM Agents）

- **類型**：代表系統與架構頁（`entities/`）
- **出處論文**：[A-MEM: Agentic Memory for LLM Agents (2025)](../papers/a-mem-2025.md)
- **發表場域**：NeurIPS 2025
- **相關頁面**：[概念：記憶動態演化機制](../concepts/memory-evolution.md) ｜ [系統：Mem0 架構](mem0.md)

---

## 系統定位

A-MEM 是一套借鏡德國社會學家盧曼「卡片盒筆記法（Zettelkasten）」的自主記憶系統。它不要求工程師寫死資料欄位或固定規則，而是讓 Agent 在每次互動後自己撰寫結構化原子筆記、建立跨記憶連結，並讓舊記憶隨著新經驗持續改寫演化 [A-MEM 2025, Sec. 1, Sec. 3]。

## 關鍵設計細節

- **筆記資料結構**：`m_i = { c_i, t_i, K_i, G_i, X_i, e_i, L_i }`，同時保存原始對話、時間戳記、LLM 生成的關鍵字/標籤/脈絡描述、向量編碼與鄰近連結集 [A-MEM 2025, Sec. 3.1]。
- **跨盒連結與回溯更新**：新筆記加入時，先找出語義最相近的前 `k` 張舊筆記，交由 LLM 決定是否建立連結（Link Generation），接著執行記憶演化（Memory Evolution）更新舊筆記的脈絡描述與標籤 [A-MEM 2025, Sec. 3.2, Sec. 3.3]。
- **多模型相容性**：已開源評測碼與生產架構（`A-mem-sys`），在 `GPT-4o`、`GPT-4o-mini`、`Qwen2.5-1.5B/3B`、`Llama 3.2 1B/3B` 等六種骨幹模型上皆驗證有效 [A-MEM 2025, Sec. 4.2, Table 1]。

## 代表成果

- 在 LoCoMo（`GPT-4o-mini`）的 Temporal 推理 F1 達 `45.85`，Multi-Hop 達 `27.02`，並將單次查詢 Context Token 壓低至 `1,216–2,520`（節省 `85–93%`） [A-MEM 2025, Sec. 4.3, Table 1]。
- T-SNE 視覺化顯示，開啟連結生成與記憶演化後，原本分散的記憶嵌入向量會自發聚集成具結構意義的群集 [A-MEM 2025, Sec. 4.7, Fig. 4]。
