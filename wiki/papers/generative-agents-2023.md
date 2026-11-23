# Generative Agents: Interactive Simulacra of Human Behavior

- **類型**：單篇論文摘要（`papers/`）
- **作者**：Joon Sung Park, Joseph C. O'Brien, Carrie J. Cai, Meredith Ringel Morris, Percy Liang, Michael S. Bernstein（Stanford University & Google）
- **發表出處**：**ACM UIST 2023**（第 36 屆使用者介面軟體與技術研討會；CORE A*、CCF A 類，2023 年錄取率約 25.1%）
- **原始檔案**：[raw/generative-agents-2023.md](../../raw/generative-agents-2023.md)（`arXiv:2304.03442`）
- **相關連結**：[概念：記憶流與反思](../concepts/memory-stream-reflection.md) ｜ [系統：Generative Agents](../entities/generative-agents.md) ｜ [論文：CoALA (2024)](coala-2024.md)

---

## 1. 這篇論文要解決什麼問題？

早期的 LLM 角色扮演只能做到「當下這一輪像人」，但一旦互動時間拉長，模型的 `Context Window` 裝不下全部歷史紀錄，就會出現失憶、忘記承諾、甚至中午 12 點吃過午餐後 12:30 又吃一次的荒謬行為 [Generative Agents 2023, Sec. 4.1, Sec. 4.3]。如果把全部記憶直接壓縮成一段大摘要，又會遺失關鍵細節（例如 Isabella 其實最期待的是情人節派對，而不只是日常打掃咖啡廳） [Generative Agents 2023, Sec. 4.1]。

## 2. 核心架構與機制（記憶流＋反思＋規劃）

作者提出由三大模組構成的架構，將所有經驗以自然語言儲存在 **Memory Stream（記憶流）** 中 [Generative Agents 2023, Sec. 1, Sec. 4]：

1. **Memory Stream 與三維加權檢索** [Generative Agents 2023, Sec. 4.1]：
   - 每筆觀察（Observation）都附有建立時間與最近存取時間。
   - 檢索公式為 `score = α_recency · recency + α_importance · importance + α_relevance · relevance`（實作中三個 α 權重皆設為 `1`，並經 `[0, 1]` min-max 正規化）：
     - **Recency（近期性）**：依最後存取經過的模擬小時數做指數衰減，衰減係數為 `0.995`。
     - **Importance（重要性）**：由 LLM 在記憶建立時評分 `1` 到 `10` 分（例如「整理房間」得 `2` 分、「約暗戀對象去派對」得 `8` 分）。
     - **Relevance（相關性）**：以 Embedding 向量的餘弦相似度（Cosine Similarity）衡量與當前情境的關聯。
2. **Reflection（反思樹）** [Generative Agents 2023, Sec. 4.2]：
   - 只有原始觀察無法歸納抽象性格（例如光看對話次數，會選經常擦肩而過的室友 Wolfgang，而非同樣熱愛研究的 Maria）。
   - 當近期事件的重要性分數總和超過門檻值 `150`（實作中大約每天觸發 2–3 次），系統會抓最近 `100` 筆紀錄讓 LLM 提出 `3` 個高層次問題，再檢索相關記憶萃取出 `5` 條具證據指標的洞見（Reflection），存回 Memory Stream 形成「反思樹」。
3. **Planning（由粗到細的遞迴規劃）** [Generative Agents 2023, Sec. 4.3]：
   - 先規劃整天 5–8 個大區塊，再遞迴拆解為每小時、甚至 5–15 分鐘的行動細節，並依據即時觀察動態重排計畫。

## 3. 實驗與關鍵數據（Smallville 25 人小鎮）

- **實驗場景**：在類似《模擬市民》的 `Smallville` 沙盒小鎮放入 `25` 位由 `gpt3.5-turbo` 驅動的 Agent，進行 `2` 個模擬日的互動 [Generative Agents 2023, Sec. 3.1, Sec. 4, Sec. 6.1]。
- **自發社會行為**：僅對咖啡廳老闆 Isabella 植入「想辦情人節派對」的初始念頭，兩天後全鎮除了 Isabella 外共有 `12` 位 Agent 得知邀請訊息，最終有 `5` 位準時出席派對，並自發出現約會與佈置合作 [Generative Agents 2023, Sec. 3.4.3, Fig. 9]。
- **控制評估與消融實驗（100 位人類評測者）** [Generative Agents 2023, Sec. 6.1–6.5]：
  使用 `TrueSkill` 評分比較 5 種條件的可信度（越高越逼真，Kruskal-Wallis `H(4) = 150.29`, `p < 0.001`）：
  1. **完整架構（Full Architecture）**：`μ = 29.89`, `σ = 0.72`（相較於完全無記憶基線，效應量 Cohen's `d = 8.16`）
  2. **移除反思（No Reflection）**：`μ = 26.88`, `σ = 0.69`
  3. **移除反思與規劃（No Reflection, No Planning）**：`μ = 25.64`, `σ = 0.68`
  4. **人類眾包扮演（Human Crowdworkers）**：`μ = 22.95`, `σ = 0.69`
  5. **完全無記憶／規劃／反思（Baseline）**：`μ = 21.21`, `σ = 0.70`

## 4. 限制與已知錯誤模式

作者在實驗中也觀察到三種常見失誤 [Generative Agents 2023, Sec. 1, Sec. 6.5.2]：
- **檢索失敗或碎片化**：例如 Tom 記得要在派對上討論選舉，卻漏檢索到「派對是否真的存在」的記憶。
- **記憶潤飾幻覺（Embellishment）**：Agent 雖少完全憑空捏造，但會用 LLM 內建常識過度腦補細節（例如把鄰居 Adam Smith 說成《國富論》作者，或幫候選人腦補「明天要開記者會」）。
- **語氣過於正式**：受限於當時指令微調模型的腔調，對話偏正式。
