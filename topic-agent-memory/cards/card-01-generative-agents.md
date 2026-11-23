# card-01：Generative Agents (2023) 證據卡

- **Wiki 來源**：`wiki/papers/generative-agents-2023.md`, `wiki/entities/generative-agents.md`
- **發表出處**：**ACM UIST 2023**（CORE A*、CCF A 類，2023 年錄取率約 25.1%）；論文 *Generative Agents: Interactive Simulacra of Human Behavior*（`arXiv:2304.03442`）。
- **給初學者的一句話比喻**：幫 AI 配備一本「會即時記流水帳、定期寫日記歸納心得、還會排每日行程表」的生活筆記本，讓它在長期互動中維持一致的人格與人際記憶。
- **核心機制**：
  1. **Memory Stream 與三維加權檢索**：以 `score = α_recency · recency + α_importance · importance + α_relevance · relevance`（三個 α 皆為 `1`，經 `[0, 1]` min-max 正規化）挑選記憶：**Recency**（依模擬小時指數衰減，係數 `0.995`）、**Importance**（建立時由 LLM 評分 `1` 到 `10` 分，如整理房間 `2` 分、約暗戀對象 `8` 分）與 **Relevance**（Embedding 餘弦相似度）[Generative Agents 2023, Sec. 4.1]。
  2. **Reflection（反思樹）**：當近期事件的重要性總和超過門檻值 `150`（約每天 2–3 次），抓取最近 `100` 筆紀錄提出 `3` 個高層次問題，再萃取出 `5` 條具證據指標的洞見存回記憶流 [Generative Agents 2023, Sec. 4.2]。
  3. **Planning（遞迴規劃）**：先規劃整天 `5–8` 個大區塊，再拆解為每小時與 `5–15` 分鐘細節，遇新觀察動態重排 [Generative Agents 2023, Sec. 4.3]。
- **關鍵實驗數據**：
  - `Smallville` 沙盒小鎮放入 `25` 位由 `gpt3.5-turbo` 驅動的 Agent 進行 `2` 個模擬日互動；單靠 Isabella 一筆想辦情人節派對的種子念頭，訊息擴散給鎮上 `12` 位其他 Agent，最終 `5` 位準時出席派對 [Generative Agents 2023, Sec. 3.1, Sec. 3.4.3, Fig. 9]。
  - `100` 位人類評測者之控制消融實驗（TrueSkill 分數，Kruskal-Wallis `H(4) = 150.29`, `p < 0.001`）[Generative Agents 2023, Sec. 6.1–6.5]：完整架構 `μ = 29.89 (σ=0.72)`（相較無記憶基線 Cohen's `d = 8.16`）、移除反思 `μ = 26.88`、移除反思與規劃 `μ = 25.64`、人類眾包扮演 `μ = 22.95`、完全無記憶基線 `μ = 21.21`。
- **已知限制或常見失誤**：缺乏記憶修剪與衝突驗證，偶爾會檢索漏掉關鍵記憶片段，或用 LLM 常識過度「潤飾腦補（Embellishment）」 [Generative Agents 2023, Sec. 1, Sec. 6.5.2]。
