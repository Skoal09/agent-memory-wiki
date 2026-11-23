# Slide 10：新手實戰指南 — 不同應用場景該配哪種記憶？

- **對應卡片**：`card-01`, `card-02`, `card-03`, `card-04`, `card-05`, `card-06`
- **出處**：`wiki/syntheses/paradigm-and-tradeoff-comparison.md`, `wiki/syntheses/beginner-learning-path.md` `[綜合比較 Sec. 3; 學習路線; HippoRAG 2024, Sec. 2.2-2.3; Mem0 2025, Sec. 4.3-4.5]`

---

### 依任務需求選配，不必一次上最複雜架構

- **個人化聊天／客服機器人** → 選 `Mem0`（精簡事實萃取＋主動汰舊 `DELETE`，省 Token 又最快）[Mem0 2025, Sec. 2.1, Sec. 4.3-4.5]。
- **跨文件知識庫／研究問答** → 選 `HippoRAG`（OpenIE 知識圖譜＋PPR 單步跨頁聯想）[HippoRAG 2024, Sec. 2.2-2.3, Sec. 5.3]。
- **個人長期筆記／學習伴侶** → 選 `A-MEM`（卡片盒連結與舊記憶自我演化）[A-MEM 2025, Sec. 3.1-3.3]。
- **多角色模擬或自建新系統** → 先用 `CoALA` 劃定權限邊界，再套用 `Generative Agents` 反思機制 [CoALA 2024, Sec. 6; Generative Agents 2023, Sec. 4.2]。
