# card-05：A-MEM (2025) 證據卡

- **Wiki 來源**：`wiki/papers/a-mem-2025.md`, `wiki/entities/a-mem.md`
- **發表出處**：**NeurIPS 2025**（Advances in Neural Information Processing Systems 38；`arXiv:2502.12110`）。
- **給初學者的一句話比喻**：就像一位會用「卡片盒筆記法（Zettelkasten）」的助理——每學到新知識就寫一張原子卡片、主動牽線連上舊卡片，還會回頭改寫舊卡片的標籤與描述。
- **核心機制** [A-MEM 2025, Sec. 3.1–3.4]：
  1. **Note Construction**：將新互動轉換為含關鍵字 `K_i`、標籤 `G_i`、脈絡描述 `X_i` 與向量 `e_i`（`all-minilm-l6-v2`）的原子筆記。
  2. **Link Generation**：找出前 `k` 個語義最近鄰歷史卡片，由 LLM 判斷因果或屬性關聯建立雙向連結。
  3. **Memory Evolution**：新卡片加入後觸發 LLM **回頭更新鄰近舊卡片的描述與標籤**，讓記憶網路隨經驗成長自我組織（T-SNE 顯現結構群集）。
  4. **Retrieve Relative Memory**：依問題向量挑選 top-`k`（預設 `k=10`）卡片與同盒關聯記憶。
- **關鍵實驗數據**：
  - **LoCoMo**（含 `5` 類共 `7,512` 題 QA、平均 `9K` tokens 跨最多 `35` 回合）[A-MEM 2025, Sec. 4.1, Sec. 4.3, Table 1]：`GPT-4o-mini` 下 Temporal F1 達 `45.85`（LoCoMo 基線 `18.41`、MemGPT `25.52`），Multi-Hop 達 `27.02`；每次問答只用 `2,520` tokens（`GPT-4o` 更降至 `1,216` tokens），比基線（約 `16,900` tokens）節省 **`85–93%`** Token。單次處理成本低於 `$0.0003`、耗時 `5.4` 秒（本機 `Llama 3.2 1B` 僅 `1.1` 秒）。
  - **DialSim**（`1,300` 回合、約 `350,000` tokens）[A-MEM 2025, Table 2]：F1 達 `3.45`，較 LoCoMo（`2.55`）高 `35%`、較 MemGPT（`1.18`）高 `192%`。
  - **消融與擴展性** [A-MEM 2025, Table 3, Table 4]：移除連結生成與記憶演化後，Multi-Hop F1 從 `27.02` 跌至 `9.65`；記憶庫擴張到 `1,000,000` 筆時，檢索時間僅從 `0.31 μs` 升至 `3.70 μs`。
- **已知限制**：連線與重組品質仰賴底層 LLM 能力，且目前僅處理純文字記憶 [A-MEM 2025, Sec. 6]。
