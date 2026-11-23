# Generative Agents（Smallville 虛擬小鎮架構）

- **類型**：代表系統與架構頁（`entities/`）
- **出處論文**：[Generative Agents: Interactive Simulacra of Human Behavior (2023)](../papers/generative-agents-2023.md)
- **發表場域**：ACM UIST 2023（CORE A*）
- **相關頁面**：[概念：記憶流與反思](../concepts/memory-stream-reflection.md) ｜ [概念：認知分類架構](../concepts/memory-taxonomy.md) ｜ [系統：CoALA 框架](coala.md)

---

## 系統定位

Generative Agents 是首個將大型語言模型（實作採用 `gpt3.5-turbo`）結合完整長期記憶流、週期性反思與遞迴規劃，在開放式沙盒環境中展現長期一致人格與自發社會行為的代表性系統 [Generative Agents 2023, Sec. 3, Sec. 4]。

## 架構運作流程

1. **初始化（Seed Memory）**：用一段自然語言文字描述角色職業、性格與人際關係，依分號切分後寫入初始記憶 [Generative Agents 2023, Sec. 3.1, Sec. 5]。
2. **感知與環境樹**：Agent 透過樹狀環境表徵感知附近物件與人物，將觀察寫入 `Memory Stream` [Generative Agents 2023, Sec. 5.1]。
3. **記憶檢索**：利用 `Recency + Importance + Relevance` 三指標挑選能放進 Context Window 的關鍵記憶 [Generative Agents 2023, Sec. 4.1]。
4. **規劃與反應迴圈**：自頂向下產生每日行程（大綱 → 小時 → 5–15 分鐘細項），遇到新事件時評估是否中斷重排計畫並生成自然對話 [Generative Agents 2023, Sec. 4.3]。
5. **反思更新**：累積重要性分數達 `150` 時觸發反思，產出高階推論存回記憶流 [Generative Agents 2023, Sec. 4.2]。

## 代表成果與局限

- 在 `Smallville` 25 位居民的兩天模擬中，單靠一筆「舉辦情人節派對」的種子念頭，訊息自然擴散給 `12` 位居民，最終促成 `5` 人到場聚會 [Generative Agents 2023, Sec. 3.4.3, Fig. 9]。
- 主要風險在於缺乏記憶修剪與衝突驗證機制，可能出現記憶檢索不完整或利用模型既有常識過度「腦補」的幻覺問題 [Generative Agents 2023, Sec. 6.5.2]。
