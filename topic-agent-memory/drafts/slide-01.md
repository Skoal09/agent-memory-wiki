# Slide 01：AI 的「金魚腦」困擾

- **對應卡片**：`card-02`, `card-03`, `card-06`
- **出處**：`wiki/concepts/memory-taxonomy.md`, `wiki/papers/mem0-2025.md`, `wiki/syntheses/beginner-learning-path.md` `[CoALA 2024, Sec. 4.1; Mem0 2025, Sec. 1]`

---

### 為什麼聊過的事情，AI 還是會忘記？

- **跨對話失憶**：LLM 本質是**無狀態（Stateless）**，一旦重開對話視窗，前面聊過的內容就不會自動保留 [CoALA 2024, Sec. 4.1]。
- **同對話被洗掉**：就算沒關視窗，週一說「吃素不喝牛奶」，穿插幾天寫程式後再問晚餐，模型也可能忘記而推薦肉類 [Mem0 2025, Sec. 1]。
- **Agent Memory**：幫 AI 建立持久、可更新的記憶系統，告別「金魚腦」。
