# Agent Memory LLM Wiki & 教學簡報專案

> **主題**：Agent Memory（AI 代理的記憶機制）：如何治好聊天機器人的「金魚腦」？  
> **定位**：專為「有稍微接觸過 AI、但未深入底層架構」的讀者打造的 LLM Wiki 知識庫與互動教學 HTML 簡報。

---

## 線上瀏覽入口（GitHub Pages）

上傳至 GitHub 並依指引開啟 GitHub Pages（`main` / `/(root)`）後，可瀏覽：
- **成果首頁**：`index.html`（雙入口導覽頁）
- **教學 HTML 簡報**：`deck.html`（12 頁互動教學簡報，每頁附 Wiki 出處與互動小測驗）
- **LLM Wiki 瀏覽器**：`wiki-viewer.html`（可線上閱讀全部 Wiki 頁面與 [`AGENTS.md`](AGENTS.md)）

---

## 目錄結構

```text
agent-memory-wiki/
├── index.html                  # GitHub Pages 雙入口首頁
├── deck.html                   # 12 頁互動教學 HTML 簡報
├── wiki-viewer.html            # 純靜態 Markdown / Wiki 知識庫瀏覽器
├── AGENTS.md                   # 唯一專案規則手冊（< 12,000 字元）
├── assets/
│   └── wiki-bundle.js          # 離線與 GitHub Pages 共用靜態知識包
├── raw/                        # 6 篇真實公開論文全文擷取（唯讀來源）
├── wiki/                       # 編譯後知識庫（20 檔：index, log, papers, concepts, entities, syntheses）
├── .agents/workflows/          # Graph Workflow 規格檔（topic-slides.md）
├── scripts/                    # 6 支可執行 PowerShell 檢查與建置腳本
└── topic-agent-memory/         # Graph 執行產物（sources, cards, outline, drafts, report）
```

---

## 收錄之 6 篇核心文獻（組合 A）

1. **Generative Agents** — Park et al. (2023), *ACM UIST 2023 (CORE A\*)* (`arXiv:2304.03442`)
2. **CoALA** — Sumers et al. (2024), *TMLR 2024 (Featured + Survey Certification)* (`arXiv:2309.02427`)
3. **LLM Agent Memory Survey** — Zhang et al. (2024), *ACM TOIS (CORE A\*, JCR Q1)* (`arXiv:2404.13501`)
4. **HippoRAG** — Gutiérrez et al. (2024), *NeurIPS 2024* (`arXiv:2405.14831`)
5. **A-MEM** — Xu et al. (2025), *NeurIPS 2025* (`arXiv:2502.12110`)
6. **Mem0 / Mem0^g** — Chhikara et al. (2025), *arXiv Preprint 2025* (`arXiv:2504.19413`)

---

## 本地驗證指令（Windows PowerShell）

```powershell
powershell -ExecutionPolicy Bypass -File scripts/lint-wiki.ps1 -RequireSynthesis
powershell -ExecutionPolicy Bypass -File scripts/check-sources.ps1
powershell -ExecutionPolicy Bypass -File scripts/check-outline.ps1
powershell -ExecutionPolicy Bypass -File scripts/check-drafts.ps1
powershell -ExecutionPolicy Bypass -File scripts/check-deck.ps1
powershell -ExecutionPolicy Bypass -File scripts/build-wiki-bundle.ps1
powershell -ExecutionPolicy Bypass -File scripts/check-site.ps1
```
