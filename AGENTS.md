# AGENTS.md — Agent Memory LLM Wiki 專案手冊

> 本手冊為本專案唯一規則檔（不另設 `GEMINI.md` 或 `CLAUDE.md` 重複規則），總長度嚴格控制在 12,000 字元以內；工作流細節拆至 `.agents/workflows/` 與 `scripts/`。

## 1. 專案目標與讀者設定
- **主題**：Agent Memory（AI 代理的記憶機制）：如何治好聊天機器人的「金魚腦」？
- **目標讀者**：有稍微接觸過 AI（曾使用過聊天機器人），但未深入研究底層架構的大學生與一般用戶。
- **語言規範**：一律使用**全繁體中文**，專有名詞保留英文（如 `Context Window`、`Working Memory`、`Episodic Memory`、`RAG`、`Knowledge Graph`）。
- **教學原則**：善用生活化類比（例如人類短期記憶 vs 長期記憶、筆記本、卡片盒 Zettelkasten），但所有技術描述與實驗數據必須 100% 忠於來源。

## 2. 目錄結構與 GitHub Pages 命名規範
- **網址與檔名規範**：所有網頁與連結會用到的檔案及資料夾名稱，一律使用**英文小寫、數字與連字號**（例如 `hipporag-2024.md`、`deck.html`），禁止使用中文檔名或空白，亦不得包含個資、密碼或 API key。
- **資料夾職責**：
  - `raw/`：只讀原始文獻來源（唯一事實來源，嚴禁修改）。
  - `wiki/`：編譯後的結構化知識庫：
    - `wiki/index.md`：全站頁面分類索引與知識地圖。
    - `wiki/log.md`：按時間順序記錄每次 ingest、lint 與更新紀錄。
    - `wiki/papers/`：單篇論文摘要頁（每篇 `raw/` 對應一頁）。
    - `wiki/concepts/`：核心概念頁（記憶分類、記憶流與反思、圖結構記憶、記憶演化）。
    - `wiki/entities/`：代表性系統與框架頁（Generative Agents、CoALA、HippoRAG、A-MEM、Mem0）。
    - `wiki/syntheses/`：跨文獻綜合比較頁（分類法差異、成本與延遲權衡）。
  - `.agents/workflows/`：Graph / Loop 工作流規格檔（細節外拆至此）。
  - `scripts/`：可執行的程式檢查腳本（Wiki lint、簡報檢查、HTML 渲染檢查）。
  - `topic-agent-memory/`：Workflow 執行時的中間產物與檢查報告（`sources.md`、`cards/`、`outline.md`、`drafts/`、`report.md`）。
  - 根目錄網頁入口：`index.html`（雙入口首頁）、`deck.html`（教學 HTML 簡報）、`wiki-viewer.html`（Wiki 與流程報告瀏覽器）。

## 3. 單向事實防線與出處格式
1. **建立 Wiki 階段（`raw/ → wiki/`）**：只能引用 `raw/` 內明確記載的事實、定義與實驗數據；嚴禁將模型記憶中未經 `raw/` 驗證的數字寫入 Wiki。
2. **製作簡報階段（`wiki/ → topic-agent-memory/ → deck.html`）**：只能引用 `wiki/` 內已編譯的內容，不得繞過 Wiki 直接憑空補齊內容。
3. **出處精確度**：
   - 每個核心論點與所有量化數據，必須精確標註到**來源篇名與章節/段落**（格式範例：`[Mem0 2025, Sec. 4.2]` 或 `[CoALA 2024, Sec. 3.1]`）。
   - 若某段來源缺漏所需資訊，應標註「資料不足」並停止，不可自行編造。

## 4. 觀點衝突與矛盾處理規則
- 當不同論文在「記憶分類法」、「檢索策略」或「效能基準數據」上出現分歧或矛盾時，**不得擅自刪除一方或偏頗選邊**。
- 必須在對應概念頁或綜合比較頁中**並陳雙方觀點**，註明各自的前提條件、評估基準（Benchmark）與發表年份，並使用固定標記 `⚠️ 觀點差異` 明確標示。

## 5. Ingest 與 Lint 作業規範
1. **漸進式寫入（Ingest）**：
   - 第一階段：先試 ingest 前 2 篇文獻，檢查頁面格式、雙向連結與出處標註無誤後，執行 `git commit`。
   - 第二階段：再批次 ingest 其餘 4 篇文獻，同步更新 `concepts/`、`entities/`、`syntheses/`、`index.md` 與 `log.md`，再行 `git commit`。
2. **可執行的健康檢查（Lint）**：
   - 不可只靠人工目視或口頭說「檢查一下」。每次批次 ingest 後必須執行 `scripts/lint-wiki.ps1`（或對應腳本），自動驗證：
     - 所有 Markdown 內部連結（`[...](...)`）指向的檔案皆存在（無斷鏈）。
     - 不存在孤島頁面（每篇 `papers/`、`concepts/`、`entities/`、`syntheses/` 皆被 `index.md` 連結，且至少被一個其他頁面或索引關聯）。
     - 單篇論文頁皆包含發表出處（Venue）、`raw/` 來源連結與章節出處標記。
     - 衝突標記（`⚠️ 觀點差異`）於跨篇比較中妥善呈現。

## 6. 教學 HTML 簡報與 Workflow 原則
- **流程控制**：採用事先定義好的 **Graph Workflow**（詳見 `.agents/workflows/topic-slides.md`），每一關卡只能讀取上一關的指定產出，不得跨關偷改或混入未經審查的內容。
- **雙軌檢查**：
  1. **程式檢查**：驗證簡報頁數（10–14 頁）、每頁字數密度與無版面溢出、每頁皆有 `wiki/` 出處標註、引用檔案皆真實存在、數據可回溯至證據卡。
  2. **獨立 AI 審查**：由獨立上下文（新子代理）扮演審查者，**只讀取成品與引用的 Wiki 頁面**（不看生成過程），檢查忠實度、是否有講反的結論、以及 6 篇來源的覆蓋率。
- **剎車上限**：每個修正迴圈（Loop）最多執行 **3 輪**；若相關 Wiki 頁面不足 3 頁則一開始即停止。每次修正結果與退回紀錄必須保存於 `topic-agent-memory/report.md`。
