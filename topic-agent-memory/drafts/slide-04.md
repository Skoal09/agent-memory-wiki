# Slide 04：從「流水帳」變「洞察」— 記憶流與反思樹

- **對應卡片**：`card-01`
- **出處**：`wiki/papers/generative-agents-2023.md`, `wiki/concepts/memory-stream-reflection.md` `[Generative Agents 2023, Sec. 4.1, Sec. 4.2, Sec. 6.1-6.5]`

---

### Smallville 25 位虛擬居民怎麼記住彼此？

- **Memory Stream**：以「近期性（0.995/模擬小時衰減）＋重要性（LLM 評 1–10 分）＋相關性」三指標撈取記憶 [Generative Agents 2023, Sec. 4.1]。
- **Reflection（定期反思）**：累積重要性達 150 就檢視近 100 筆紀錄提 3 個問題，淬鍊 5 條洞見成反思樹 [Generative Agents 2023, Sec. 4.2]。
- **消融實證**：100 位人類評測顯示完整版可信度達 TrueSkill μ=29.89；拿掉反思降為 26.88，完全無記憶／規劃／反思僅 21.21 [Generative Agents 2023, Sec. 6.5.1]。
