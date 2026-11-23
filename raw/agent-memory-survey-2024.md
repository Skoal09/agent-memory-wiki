# A Survey on the Memory Mechanism of Large Language Model based Agents

- **arXiv ID**: `arXiv:2404.13501`
- **Source URL**: https://arxiv.org/abs/2404.13501
- **Authors**: Zeyu Zhang , Xiaohe Bo , Chen Ma , Rui Li , Xu Chen , Quanyu Dai , Jieming Zhu , Zhenhua Dong , Ji-Rong Wen
- **Publication Venue**: ACM Transactions on Information Systems (TOIS; CORE A*, CCF A, JCR Q1)
- **Year**: 2024

## Abstract

Large language model (LLM) based agents have recently attracted much attention from the research and industry communities. Compared with original LLMs, LLM-based agents are featured in their self-evolving capability, which is the basis for solving real-world problems that need long-term and complex agent-environment interactions. The key component to support agent-environment interactions is the memory of the agents. While previous studies have proposed many promising memory mechanisms, they are scattered in different papers, and there lacks a systematical review to summarize and compare these works from a holistic perspective, failing to abstract common and effective designing patterns for inspiring future studies. To bridge this gap, in this paper, we propose a comprehensive survey on the memory mechanism of LLM-based agents. In specific, we first discuss ''what is'' and ''why do we need'' the memory in LLM-based agents. Then, we systematically review previous studies on how to design and evaluate the memory module. In addition, we also present many agent applications, where the memory module plays an important role. At last, we analyze the limitations of existing work and show important future directions. To keep up with the latest advances in this field, we create a repository at \url{ this https URL }.

## Extracted Full-Text Sections

Content selection saved. Describe the issue below:

Large language model (LLM) based agents have recently attracted much attention from the research and industry communities. Compared with original LLMs, LLM-based agents are featured in their self-evolving capability, which is the basis for solving real-world problems that need long-term and complex agent-environment interactions. The key component to support agent-environment interactions is the memory of the agents. While previous studies have proposed many promising memory mechanisms, they are scattered in different papers, and there lacks a systematical review to summarize and compare these works from a holistic perspective, failing to abstract common and effective designing patterns for inspiring future studies. To bridge this gap, in this paper, we propose a comprehensive survey on the memory mechanism of LLM-based agents. In specific, we first discuss “what is” and “why do we need” the memory in LLM-based agents. Then, we systematically review previous studies on how to design and evaluate the memory module. In addition, we also present many agent applications, where the memory module plays an important role. At last, we analyze the limitations of existing work and show important future directions. To keep up with the latest advances in this field, we create a repository at https://github.com/nuster1128/LLM_Agent_Memory_Survey .


> [Figure/Table Caption] Figure 1: The importance of the memory module in LLM-based agents.


### 1 Introduction

"Without memory, there is no culture. Without memory, there would be no civilization, no society, no future."

Elie Wiesel, 1928-2016

Recently, large language models (LLMs) have achieved remarkable success in a large number of domains, ranging from artificial intelligence and software engineering to education and social science [ 1 , 2 , 3 ] . Original LLMs usually accomplish different tasks without interacting with environments. However, to achieve the final goal of artificial general intelligence (AGI), intelligent machines should be able to improve themselves by autonomously exploring and learning from the real world. For example, if a trip-planning agent intends to book a ticket, it should send an order request to the ticket website, and observe the response before taking the next action. A personal assistant agent should adjust its behaviors according to the user’s feedback, providing personalized responses to improve user’s satisfaction. To further push the boundary of LLMs towards AGI, recent years have witnessed a large number of studies on LLM-based agents [ 3 , 4 ] , where the key is to equip LLMs with additional modules to enhance their self-evolving capability in real-world environments.

Among all the added modules, memory is a key component that differentiates the agents from original LLMs, making an agent truly an agent (see Figure 1 ). It plays an extremely important role in determining how the agent accumulates knowledge, processes historical experience, retrieves informative knowledge to support its actions, and so on. Around the memory module, people have devoted much effort to designing its information sources, storage forms, and operation mechanisms. For example, Shinn et al. [5] incorporate both in-trial and cross-trial information to build the memory module for enhancing the agent’s reasoning capability. Zhong et al. [6] store memory information in the form of natural languages, which is explainable and friendly to the users. Modarressi et al. [7] design both memory reading and writing operations to interact with environments for task solving.

While previous studies have designed many promising memory modules, there still lacks a systemic study to view the memory modules from a holistic perspective. To bridge this gap, in this paper, we comprehensively review previous studies to present clear taxonomies and key principles for designing and evaluating the memory module. In specific, we discuss three key problems including: (1) what is the memory of LLM-based agents? (2) why do we need the memory in LLM-based agents? and (3) how to implement and evaluate the memory in LLM-based agents? To begin with, we detail the concepts of memory in LLM-based agents, providing both narrow and broad definitions. Then, we analyze the necessity of memory in LLM-based agents, showing its importance from three perspectives including cognitive psychology, self-evolution, and agent applications. Based on the problems of “what” and “why”, we present commonly used strategies to design and evaluate the memory modules. For the memory design, we discuss previous works from three dimensions, that is, memory sources, memory forms, and memory operations. For the memory evaluation, we introduce two widely used approaches including direct evaluation and indirect evaluation via specific agent tasks. Next, we discuss agent applications including role-playing, social simulation, personal assistant, open-world games, code generation, recommendation, and expert systems, in order to show the importance of the memory module in practical scenarios. At last, we analyze the limitations of existing work and highlight significant future directions.

The main contributions of this paper can be summarized as follows: (1) We formally define the memory module and comprehensively analyze its necessity for LLM-based agents. (2) We systematically summarize existing studies on designing and evaluating the memory module in LLM-based agents, providing clear taxonomies and intuitive insights. (3) We present typical agent applications to show the importance of the memory module in different scenarios. (4) We analyze the key limitations of existing memory modules and show potential solutions for inspiring future studies. To our knowledge, this is the first survey on the memory mechanism of LLM-based agents.

The rest of this survey is organized as follows. First, we provide a systematical meta-survey for the fields of LLMs and LLM-based agents in Section 2 , categorizing different surveys and summarizing their key contributions. Then, we discuss the problems of “what is”, “why do we need” and “how to implement and evaluate” the memory module in LLM-based agents in Section 3 to 6 . Next, we show the applications of memory-enhanced agents in Section 7 . The discussions of the limitations of existing work and future directions come at last in Section 8 and Section 9 .


### 2 Related Surveys


> [Figure/Table Caption] Figure 2: The organization of related surveys on LLMs and LLM-based agents.

In the past two years, LLMs have attracted much attention from the academic and industry communities. To systemically summarize the studies in this field, researchers have written a lot of survey papers. In this section, we briefly review these surveys (see Figure 2 for an overview), highlighting their major focuses and contributions to better position our study.


#### 2.1 Surveys on Large Language Models

In the field of LLMs, Zhao et al. [70] present the first comprehensive survey to summarize the background, evolution paths, model architectures, training methodologies, and evaluation strategies of LLMs. Hadi et al. [71] and Min et al. [72] also conduct LLM surveys from the holistic view, which, however, provide different taxonomies and understandings on LLMs. Following these surveys, people dive into specific aspects of LLMs and review the corresponding milestone studies and key technologies. These aspects can be classified into four categories including the fundamental problems, evaluation, applications, and challenges of LLMs.

Fundamental problems . The surveys in this category aim to summarize techniques that can be leveraged to tackle fundamental problems of LLMs. Specifically, Zhang et al. [8] provide a comprehensive survey on the methods of supervised fine-tuning, which is a key technique for better training LLMs. Shen et al. [9] , Wang et al. [10] and Liu et al. [11] present surveys on the alignment of LLMs, which is a key requirement for LLMs to produce outputs consistent with human values. Gao et al. [12] propose a survey on the retrieval-augmented generation (RAG) capability of LLMs, which is key to providing LLMs with factual and up-to-date knowledge and removing hallucinations. Qin et al. [18] summarize the state-of-the-art methods on enabling LLMs to leverage external tools, which is fundamental for LLMs to expand their capability in domains that require specialized knowledge. Wang et al. [13] , Yao et al. [14] , Wang et al. [15] , Feng et al. [16] and Zhang et al. [17] present surveys on the direction of LLM knowledge editing, which is important for customizing LLMs to satisfy specific requirements. Huang et al. [19] , Wang et al. [20] and Pawar et al. [21] focus on long-context capabilities of LLMs, which is critical for LLMs to process more information at each time and enhance their application scenarios. Wu et al. [22] , Song et al. [23] , Caffagni et al. [24] and Yin et al. [25] summarize multi-modal LLMs, which expands the capability of LLMs from text to visual and other modalities. The above surveys mainly focus on the effectiveness of LLMs. Another important aspect of LLMs is their training and inference efficiency. To summarize studies on this aspect, Zhu et al. [30] , Xu and McAuley [31] , Wang et al. [32] and Park et al. [33] systematically review the techniques of model compression. Ding et al. [81] and Xu et al. [29] analyze and conclude the studies on parameter efficient fine-tuning. Bai et al. [26] , Wan et al. [27] , Miao et al. [28] and Ding et al. [81] put more focuses on the efficiency of resource utilization in a general sense.

Evaluation . The surveys in this category focus on how to evaluate the capability of LLMs. Specifically, Chang et al. [34] comprehensively summarize the evaluation methods from an overall perspective. It encompasses different evaluation tasks, methods, and benchmarks, which serve as critical parts in assessing LLM performances. Guo et al. [35] care more about the evaluation targets and describe how to evaluate the knowledge, alignment, and safety control capabilities of LLMs, which supplement evaluation metrics beyond performance.

Applications . The surveys in this category aim to summarize models that leverage LLMs to improve different applications. More concretely, Zhu et al. [37] focus on the field of information retrieval (IR) and summarize studies on LLM-based query processes. Xu et al. [38] pay more attention to information extraction (IE) and provide comprehensive taxonomies for LLM-based models in this field. Li et al. [50] , Lin et al. [51] and Wang et al. [52] discuss the applications of LLMs in the field of recommender system, where they utilize agents to generate data and provide recommendations. Fan et al. [39] , Wang et al. [40] , and Zheng et al. [41] concentrate on how LLMs can benefit software engineering (SE) in terms of software design, development, and testing. Zeng et al. [42] summarize LLM-based methods in the field of robotics. Cui et al. [43] and Yang et al. [44] focus on the application of autonomous driving and summarize models in this domain based on LLMs from different perspectives. Beyond the above domains in artificial intelligence, LLMs have also been used in natural and social science. He et al. [45] , Zhou et al. [46] and Wang et al. [47] summarize the applications of LLMs in medicine. Li et al. [48] focus on the applications of LLMs in finance. He et al. [49] review the models on leveraging LLMs to improve the development of psychology.

Challenges . The surveys in this category focus on trustworthiness in LLMs, such as hallucination, bias, unfairness, explainability, security, and privacy. Hallucination in LLMs refers to the problem that LLMs may generate misconceptions or fabrications, impacting their reliability for downstream applications. Zhang et al. [53] , Huang et al. [54] , Rawte et al. [55] , Ye et al. [56] , Ji et al. [57] , Tonmoy et al. [58] and Jiang et al. [59] summarize the mainstream models for alleviating the hallucination problem in LLMs. The bias and unfairness problems refer to the phenomenon that LLMs may unequally treat different humans or objectives, which can lead to the propagation of societal stereotypes and discrimination. Gallegos et al. [60] , Kotek et al. [61] and Li et al. [62] comprehensively discuss these challenges and summarize existing methods for alleviating them. The problem of explainability means that the internal working mechanisms of LLMs are still unclear. Zhao et al. [63] systematically discuss this problem and summarize previous efforts on improving the explainability of LLMs. Security and privacy are also challenging problems, which have been comprehensively surveyed in Yao et al. [64] , Shayegani et al. [65] , Neel and Chang [66] , Smith et al. [67] , Dong et al. [68] and Das et al. [69] .


#### 2.2 Surveys on Large Language Model-based Agents

Based on the capability of LLMs, people have conducted a lot of studies on building LLM-based agents, which can autonomously perceive environments, take actions, accumulate knowledge, and evolve themselves. In this field, Wang et al. [3] present the first survey paper to systematically summarize LLM-based agents from the perspectives of agent construction, agent application, and agent evaluation. Xi et al. [4] , Zhao et al. [77] , Cheng et al. [78] and Ge et al. [80] also summarize LLM-based agent studies from the overall perspective, but they have different focuses and taxonomies, delivering more diverse understandings on this field. In addition to these overall surveys, there have also emerged several papers reviewing specific aspects of LLM-based agents. For the fundamental problems, Durante et al. [79] summarize studies on multi-modal agents. Huang et al. [74] focus on the planning capability of LLM-based agents. Guo et al. [75] pay more attention to the scenarios of multi-agent interactions. For the applications, Li et al. [76] provide a summarization on LLM-based agents that are leveraged as personal assistants.

Position of this work . Our survey summarizes the studies on a fundamental problem of LLM-based agents, that is, the agent’s memory mechanism. To our knowledge, this is the first survey in this direction. We hope it can not only inspire more advanced memory architectures in the future, but also provide newcomers with comprehensive starting materials.


### 3 What is the Memory of LLM-based Agent

Interacting and learning from environments is a basic requirement of LLM-based agents. In the agent-environment interaction process, there are three key phases, that is, (1) the agent perceives information from the environment, and stores it into the memory; (2) the agent processes the stored information to make it more usable; and (3) the agent takes the next action based on the processed memory information. In all these phases, memory plays an extremely important role. In the following, we first define the memory of the agent from both narrow and broad perspectives, and then, detail the execution processes of the above three phases based on the memory module.


#### 3.1 Basic Knowledge

For clear presentations, we first introduce several important background knowledge as follows:

Task is the final target that the agent needs to achieve, for example, booking a flight ticket for Alice, recommending a restaurant for Bob, and so on. Formally, we use 𝒯 \mathcal{T} to represent a task and label different tasks by subscripts in the following contents.

In a narrow sense, environment is the object that the agent needs to interact with to accomplish the task. For the examples in definition 1 , the environments are Alice and Bob, who provide feedback on the agent’s actions. More broadly, environment can be any contextual factors that influence the agent’s decisions, such as the weather when booking flight tickets, the time and location when recommending restaurants, etc.

To accomplish a task, the agent needs to interact with the environment. Usually, the agent first takes an action, and then the environment responds to this action. At last, the agent takes the next action based on the response. This process iterates until the task is finished. The complete agent-environment interaction process is called a trial , and each interaction turn is called a step . For each trial, the agent can take multiple steps to form a potential solution to the task. For each task, the agent can explore multiple trials to accomplish the task [ 5 ] . Formally, at step t t , we use a t a_{t} and o t o_{t} to represent the agent action and the observed environment response, respectively. Then, a T T -length trial can be represented as ξ T = { a 1 , o 1 , a 2 , o 2 , … , o T , a T } \xi_{T}=\{a_{1},o_{1},a_{2},o_{2},...,o_{T},a_{T}\} .

In the above definitions, task and environment are the most coarse-grained concepts, while step is the most fine-grained one. They together describe the complete agent-environment interaction process.


> [Figure/Table Caption] Figure 3: (a) Examples of the potential trials in the agent-environment interaction process. (b) Illustration of the memory reading, writing, and management processes, where dotted lines mean that the cross-trial information can be incorporated into the memory module.

A Toy Example . Based on the above definitions, we show a toy example and use it throughout the paper to provide more intuitions. In this example, the agent has two tasks: (A) Making a trip plan for Alice in Beijing from 5/1/2024 to 5/3/2024 , where the agent has to (i) buy a round-trip flight ticket, (ii) determine several attractions according to Alice’s preferences, and (iii) arrange the visiting order of these attractions. (B) Recommending a movie for Alice on 5/10/2024 , where the agent has to (i) determine the time that Alice is free to watch movies, and (ii) select a movie according to Alice’s watching preference. For each task, we present a potential trial in the following (also illustrated in Figure 3 (a)). For task (A), the trial is:

[Step 1] Agent : I need to book flight tickets from Shanghai to Beijing on 5/1/2024, and from Beijing to Shanghai on 5/3/2024 through the online ticket office. Environment (Online Ticket Office) : The order has been confirmed. The departure flight takes off at 9:00 AM, and your ticket number is EK240501SX9021. The returning flight takes off at 4:30 PM, and your ticket number is LG240503FN6317. Please arrive at the airport on time for your flight.

[Step 2] Agent : I have acquired external knowledge from the magazine Attractions in Beijing . It shows that the Great Wall, the Forbidden City and the Summer Palace are famous. According to Alice’s preferences, I think she prefers ancient architecture, so I determine the Forbidden City and the Summer Palace as the destinations. Environment (Alice) : Well done!

[Step 3] Agent : Now, I need to arrange the visiting order for Alice. According to the information above, I recommend visiting the Summer Palace after she arrives in Beijing because it is suitable to spend a whole afternoon there and watch the sunset. Then, she can go to the Forbidden City the next day, which would give her plenty of time. Finally, she can return to Shanghai on the third day and take a rest. Environment (Alice) : I love this plan. Thanks!

For task (B), the trial is:

[Step 1] Agent : According to my previous experiences of movie recommendations for Alice, she prefers to start watching movies at 9:00 PM, because she has finished work by then. I should ask Alice if she is available at that time. Environment (Alice) : Of course, it is a nice time!

[Step 2] Agent : Now, I need to find some movies that Alice has marked "want to watch" on Netflix. Environment (Netflix) : Alice’s want to watch: Interstellar , Planet Terror and Candle in the Tomb .

[Step 3] Agent : Since Alice never watches horror movies at night, Interstellar would be more suitable for her. Now, I need to confirm with Alice about the movie. Environment (Alice) : Great! I like it!


#### 3.2 Narrow Definition of the Agent Memory

In a narrow sense, the memory of the agent is only relevant to the historical information within the same trial. Formally, for a given task, the historical information of the trial before step t t is ξ t = { a 1 , o 1 , a 2 , o 2 , … , a t − 1 , o t − 1 } \xi_{t}=\{a_{1},o_{1},a_{2},o_{2},...,a_{t-1},o_{t-1}\} , and then the memory is derived based on ξ t \xi_{t} . In the above toy example, for task (A), the agent at [step 3] needs to arrange the visiting order for Alice; at this time, its memory contains the information about the selected attractions and arrival time in [step 1] and [step 2]. For task (B), the agent has to choose a movie for Alice at [step 3]; at this time, its memory contains the arranged time to watch films.


#### 3.3 Broad Definition of the Agent Memory

In a broad sense, the memory of the agent can come from much wider sources, for example, the information across different trials and the external knowledge beyond the agent-environment interactions. Formally, given a series of sequential tasks { 𝒯 1 , 𝒯 2 , … , 𝒯 K } \{\mathcal{T}_{1},~\mathcal{T}_{2},...,~\mathcal{T}_{K}\} , for task 𝒯 k \mathcal{T}_{k} , the memory information at step t t comes from three sources: (1) the historical information within the same trial, that is, ξ t k = { a 1 k , o 1 k , … , a t − 1 k , o t − 1 k } \xi_{t}^{k}=\{a_{1}^{k},o_{1}^{k},...,a_{t-1}^{k},o_{t-1}^{k}\} , where we add superscript k k to label the task index. (2) The historical information across different trials, that is, Ξ k = { ξ 1 , ξ 2 , … , ξ k − 1 , ξ k ′ } \Xi^{k}=\{\xi^{1},\xi^{2},...,\xi^{k-1},\xi^{k^{\prime}}\} , where ξ j \xi^{j} ( j ∈ { 1 , … , k − 1 } ) (j\in\{1,...,k-1\}) represents the trials of task j j 1 1 1 For each task, there can be multiple trials for exploring the final solution, and all of them can be incorporated into the memory. , and ξ k ′ \xi^{k^{\prime}} denotes the previously explored trials for task 𝒯 k \mathcal{T}_{k} . (3) External knowledge, which is represented by D t k D_{t}^{k} . The memory of the agent is derived based on ( ξ t k , Ξ k , D t k ) (\xi_{t}^{k},~\Xi^{k},~D_{t}^{k}) . In the above toy example, for task (A), if there are several failed trials, that is, the feedback from Alice is negative, then these trials can be incorporated into the agent’s memory to avoid future similar errors (corresponding to ξ k ′ \xi^{k^{\prime}} ). In addition, for task (B), the agent may recommend movies relevant to the attractions that Alice has visited in task (A) to capture her recent preferences (corresponding to { ξ 1 , ξ 2 , … , ξ k − 1 } \{\xi^{1},\xi^{2},...,\xi^{k-1}\} ). In the agent decision process, it has also referred to the magazine Attractions in Beijing for making trip plans, which is the external knowledge (corresponding to D t k D_{t}^{k} ) for the current task 𝒯 k \mathcal{T}_{k} .


#### 3.4 Memory-assisted Agent-Environment Interaction

As mentioned at the beginning of Section 3 , there are three key phases in the agent-environment interaction process. The agent memory module implements these phases through three operations including memory writing, memory management, and memory reading.

Memory Writing . This operation aims to project the raw observations into the actually stored memory contents, which are more informative [ 7 ] and concise [ 6 ] . It corresponds to the first phase of the agent-environment interaction process. Given a task 𝒯 k \mathcal{T}_{k} , if the agent takes an action a t k a^{k}_{t} at step t t , and the environment provides an observation o t k o^{k}_{t} , then the memory writing operation can be formally represented as:

|  | m t k = W ⁡ ( { a t k , o t k } ) , m_{t}^{k}=W(\{a^{k}_{t},o^{k}_{t}\}), |  |
where W W is a projecting function. m t k m_{t}^{k} is the finally stored memory contents, which can be either natural languages or parametric representations. In the above toy example, for task (A), the agent is supposed to remember the flight arrangement and the decision of attractions after [step 2]. For task (B), the agent should memorize the fact that Alice hopes to watch movies at 9:00 PM, after [step 1].

Memory Management . This operation aims to process the stored memory information to make it more effective, for example, summarizing high-level concepts to make the agent more generalizable [ 6 ] , merging similar information to reduce redundancy [ 7 ] , and forgetting unimportant or irrelevant information to remove its negative influence. This operation corresponds to the second phase of the agent-environment interaction process. Let M t − 1 k M_{t-1}^{k} be the memory contents for task k k before step t t , and suppose m t k m_{t}^{k} is the stored information at step t t based on the above memory writing operation, then, the memory management operation can be represented by:

|  | M t k = P ⁡ ( M t − 1 k , m t k ) , M_{t}^{k}=P(M_{t-1}^{k},m_{t}^{k}), |  |
where P P is a function that iteratively processes the stored memory information. For the narrow memory definition, the iteration only happens within the same trial, and the memory is emptied when the trial is ended. For the broad memory definition, the iteration happens across different trials or even tasks, as well as the integrations of external knowledge. For task (B) in the above toy example, the agent can conclude that Alice enjoys watching science fiction movies in the evening, which can be used as a default rule to make recommendations for Alice in the future.

Memory Reading . This operation aims to obtain important information from the memory to support the next agent action. It corresponds to the third phase of the agent-environment interaction process. Suppose M t k M_{t}^{k} is the memory contents for task k k at step t t , c t k c_{t}^{k} is the context of the next action, then the memory reading operation can be represented by:

|  | M ^ t k = R ⁡ ( M t k , c t + 1 k ) , \hat{M}_{t}^{k}=R(M_{t}^{k},c_{t+1}^{k}), |  |
where R R is usually implemented by computing the similarity between M t k M_{t}^{k} and c t + 1 k c_{t+1}^{k} [ 82 ] . M ^ t k \hat{M}_{t}^{k} is used as parts of the final prompt to drive the agent’s next action. For task (B) in the above toy example, when the agent decides on the final recommended movie in [Step 3], it should focus on the “want to watch” list in [Step 2] and select one from it.

Based on the above operations, we can derive a unified function for the evolving process from { a t k , o t k } \{a^{k}_{t},o^{k}_{t}\} to a t + 1 k a^{k}_{t+1} , that is:

|  | a t + 1 k = LLM ​ { R ⁡ ( P ⁡ ( M t − 1 k , W ⁡ ( { a t k , o t k } ) ) , c t + 1 k ) } , a^{k}_{t+1}=\text{LLM}\{R(P(M_{t-1}^{k},W(\{a^{k}_{t},o^{k}_{t}\})),c_{t+1}^{k})\}, |  |
where LLM is the large language model. The complete agent-environment interaction process can be easily obtained by iteratively expanding this function (see Figure 3 (b) for an intuitive illustration).

This function provides a general formulation of the agent memorizing process. Previous works may use different specifications. For example, in [ 5 ] , R R and P P are set as identical functions, and P P only takes effect at the end of a trial. In Park et al. [83] , R R is implemented based on three criteria including similarity, time interval, and importance, and P P is realized by a reflection process to obtain more abstract thoughts. In this section, we focus on the overall framework of the agent’s memory operations. More detailed realizations of W W , P P , and R R are deferred in Section 5 .


### 4 Why We Need the Memory in LLM-based Agent

Above, we have introduced what is the memory of LLM-based agents. Before comprehensively presenting how to implement it, in this section, we briefly show why memory is necessary for building LLM-based agents, where we expand our discussion from three perspectives including cognitive psychology, self-evolution, and agent applications.


#### 4.1 Perspective of Cognitive Psychology

Cognitive psychology is the scientific study of human mental processes such as attention, language use, memory, perception, problem-solving, creativity, and reasoning 2 2 2 https://en.wikipedia.org/wiki/Cognitive_psychology . Among these processes, memory is widely recognized as an extremely important one [ 84 ] . It is fundamental for humans to learn knowledge by accumulating important information and abstracting high-level concepts [ 85 ] , form social norms by remembering cultural values and individual experiences [ 86 ] , take reasonable behaviors by imagining the potential positive and negative consequences [ 87 ] , and among others.

A major goal of LLM-based agents is to replace humans for accomplishing different tasks. To make agents behave like humans, following human’s working mechanisms to design the agents is a natural and essential choice [ 88 ] . Since memory is important for humans, designing memory modules is also significant for the agents. In addition, cognitive psychology has been studied for a long time, so many effective human memory theories and architectures have been accumulated, which can support more advanced capabilities of the agents [ 89 ] .


#### 4.2 Perspective of Self-Evolution

To accomplish different practical tasks, agents have to self-evolve in dynamic environments [ 90 ] . In the agent-environment interaction process, the memory is key to the following aspects: (1) Experience accumulation . An important function of the memory is to remember past error plannings, inappropriate behaviors, or failed experiences, so as to make the agent more effective for handling similar tasks in the future [ 91 ] . This is extremely important for enhancing the learning efficiency of the agent in the self-evolving process. (2) Environment exploration . To autonomously evolve in the environment, the agents have to explore different actions and learn from the feedback [ 92 ] . By remembering historical information, the memory can help to better decide when and how to make explorations, for example, focusing more on previously failed trials or actions with lower exploring frequencies [ 93 ] . (3) Knowledge abstraction . Another important function of the memory is to summarize and abstract high-level information from raw observations, which is the basis for the agent to be more adaptive and generalizable to unseen environments [ 82 ] . In summary, self-evolution is the basic characteristic of LLM-based agents, and memory is of key importance to self-evolution.


#### 4.3 Perspective of Agent Applications

In many applications, memory is an indispensable component of the agent. For example, in a conversational agent, the memory stores information about historical conversations, which is necessary for the agent to generate the next response. Without memory, the agent does not know the context, and cannot continue the conversation [ 94 ] . In a simulation agent, memory is of great importance to make the agent consistently follow the role profiles. Without memory, the agent may easily step out of the role during the simulation process [ 95 ] . Both of the above examples show that the memory is not an optional component, but is necessary for the agents to accomplish given tasks.

In the above three perspectives, the first one reveals that the memory builds the cognitive basis of the agent. The second and third ones show that the memory is necessary for the agent’s evolving principles and applications, which provide insights for designing agents with memory mechanisms.


### 5 How to Implement the Memory of LLM-based Agent

In this section, we discuss the implementation of the memory module from three perspectives: memory sources, memory forms, and memory operations. Memory sources refer to where the memory contents come from. Memory forms focus on how to represent the memory contents. Memory operations aim to process the memory contents. These three perspectives provide a comprehensive review of memory implementation methods, which is helpful for future research. For better demonstration, we present an overview of implementation methods in Figure 4 .


> [Figure/Table Caption] Figure 4: An overview of the sources, forms, and operations of the memory in LLM-based agents.


#### 5.1 Memory Sources

In previous works, the memory contents may come from different sources. Based on our formulation in Section 3 , these sources can be classified into three categories, that is, the information inside a trial, the information across different trials, and the external knowledge. The former two are dynamically generated in the agent-environment interaction process ( e.g. , task internal information), while the latter is static information outside the loop ( e.g. , task external information). We summarize previous works on memory sources in Table 1 .


> [Figure/Table Caption] Table 1: Summarization of the memory sources. We use ✓ and × to label whether or not the corresponding source is adopted in the model.

| Models | Inside-trial Information | Cross-trial Information | External Knowledge |
| MemoryBank [ 6 ] | ✓ | × | × |
| RET-LLM [ 7 ] | ✓ | × | ✓ |
| ChatDB [ 96 ] | ✓ | × | ✓ |
| TiM [ 97 ] | ✓ | × | × |
| SCM [ 98 ] | ✓ | × | × |
| Voyager [ 99 ] | ✓ | × | × |
| MemGPT [ 100 ] | ✓ | × | × |
| MemoChat [ 94 ] | ✓ | × | × |
| MPC [ 101 ] | ✓ | × | × |
| Generative Agents [ 83 ] | ✓ | × | × |
| RecMind [ 102 ] | ✓ | × | ✓ |
| Retroformer [ 103 ] | ✓ | ✓ | ✓ |
| ExpeL [ 82 ] | ✓ | ✓ | ✓ |
| Synapse [ 91 ] | ✓ | ✓ | × |
| GITM [ 93 ] | ✓ | ✓ | ✓ |
| ReAct [ 104 ] | ✓ | × | ✓ |
| Reflexion [ 5 ] | ✓ | ✓ | ✓ |
| RecAgent [ 95 ] | ✓ | × | × |
| Character-LLM [ 105 ] | ✓ | × | ✓ |
| MAC [ 106 ] | ✓ | × | × |
| Huatuo [ 107 ] | ✓ | × | ✓ |
| ChatDev [ 1 ] | ✓ | × | × |
| InteRecAgent [ 108 ] | ✓ | × | ✓ |
| MetaAgents [ 109 ] | ✓ | × | × |
| TPTU [ 110 , 111 ] | ✓ | × | ✓ |
| MetaGPT [ 112 ] | ✓ | ✓ | × |
| S 3 [ 2 ] | ✓ | × | × |
| InvestLM [ 113 ] | ✓ | × | ✓ |

**5.1.1 Inside-trial Information**

In the agent-environment interaction process, the historical steps within a trial are usually the most relevant and informative signals to support the agent’s future actions. Almost all the previous works use this information as a part of the memory sources.

Representative Studies . Generative Agents [ 83 ] aims to simulate human’s daily behaviors by using LLM-based agents. The memory of an agent is derived from the historical behaviors to achieve a target, for example, the collection of relevant papers when researching on a specific topic. MemoChat [ 94 ] aims to chat with humans, where the memory of the agent is derived based on the conversation history of a dialogue session. TiM [ 97 ] aims to enhance the agent’s reasoning capability by self-generating multiple thoughts after accomplishing a task, which is used as the memory to provide more generalizable information. Voyager [ 99 ] focuses on building game agents based on Minecraft, where the memory contains executable codes of preliminary and basic actions to accomplish a task. It should be noted that the inside-trial information not only includes agent-environment interactions, but also contains interaction contexts, such as time and location information.

Discussion . The inside-trial information is the most obvious and intuitive source that should be leveraged to construct the agent’s memory since it is highly relevant to the current task that the agent has to accomplish. However, relying solely on inside-trial information may prevent the agent from accumulating valuable knowledge from various tasks and learning more generalizable information. Thus, many studies also explore how to effectively utilize the information across different tasks to build the memory module, which is detailed in the following sections.


**5.1.2 Cross-trial Information**

For LLM-based agents, the information accumulated across multiple trials in the environment is also a crucial part of the memory, typically including successful and failed actions and their insights, such as failure reasons, common action patterns to succeed, and so on.

Representative Studies . One of the most prominent studies is Reflexion [ 5 ] , which proposes verbal reinforcement learning for LLM-based agents. It derives the experiences from past trials in verbal form, and applies them in subsequent trials to improve the performance of the same task. Furthermore, Retroformer [ 103 ] fine-tunes the reflection model, enabling the agent to extract cross-trial information from past trials more effectively. In Synapse [ 91 ] , the agents focus on solving the computer control tasks. Their memory can record cross-trial information through successful exemplars, which would be used as references on similar trials. In ExpeL [ 82 ] , the agents are required to solve a collection of complex interactive tasks within the environment. They store and organize completed trajectories, and recall similar ones for the new task. In the recalled trajectories, successful cases will be compared with failed ones to identify the patterns to succeed.

Discussion . According to the accumulated memory of cross-trial information, the agents are able to accumulate experiences, which is important for their evolution. Based on the past experiences, the agents can adjust their actions based on the overall feedback of the whole process. In contrast to the inside-trial observations, which serve as short-term memory, the trial experiences can be considered as long-term memory. It utilizes feedback from different trials to support a wider range of agent trials, providing more prolonged experiential support for agents. However, the limitation lies in the fact that both inside-trial and cross-trial information require the agents to personally engage in agent-environment interactions, where external experiences and knowledge are not included.


**5.1.3 External Knowledge**

An important characteristic of LLM-based agents is that they can be directly communicated and controlled in natural languages. As such, LLM-based agents can easily incorporate external knowledge in textual forms ( e.g. , Wikipedia 3 3 3 https://www.wikipedia.org ) to facilitate their decisions.

Representative Studies . In ReAct [ 104 ] , the agents are required to answer questions about general knowledge by multiple reasoning steps. They can utilize Wikipedia APIs to obtain external knowledge if they lack information during these steps. GITM [ 93 ] intends to design agents in Minecraft, which can explore in complex and sparse-reward environments. The agents draw from the online Minecraft Wiki and craft recipes to provide an infinite source of knowledge for their navigation. CodeAgent [ 114 ] focuses on the repo-level code generation task, which commonly requires complex dependencies and extensive documentation. It designs a web search strategy for acquiring related external knowledge. ChatDoctor [ 115 ] adapts LLM-based agents to the medical domain. It fine-tunes an acquisition process to retrieve external knowledge from Wikipedia and medical databases.

Discussion . The external knowledge can be obtained from both private and public sources. It provides LLM-based agents with much knowledge beyond their internal environment, which might be difficult or even impossible for the agent to acquire by agent-environment interactions. Moreover, most external knowledge can be acquired by accessing the APIs of various tools dynamically in real time according to the task needs, thus mitigating the problem of outdated knowledge. Integrating external knowledge into the memory of LLM-based agents significantly expands their knowledge boundaries, providing them with unlimited, up-to-date, and well-founded knowledge for decision-making.


#### 5.2 Memory Forms

In general, there are two forms to represent the memory contents: textual form and parametric form. In textual form, the information is explicitly retained and recalled by natural languages. In parametric form, the memory information is encoded into parameters and implicitly influences the agent’s actions. We summarize previous works on memory forms with their implementations in Table 2 .


> [Figure/Table Caption] Table 2: Summarization of the memory forms. We use ✓ and × to label whether or not the corresponding memory form is adopted in the model.

| Models | Textual Form | Parametric Form |
| Complete | Recent | Retrieved | External | Fine-tuning | Editing |
| MemoryBank [ 6 ] | × | × | ✓ | × | × | × |
| RET-LLM [ 7 ] | × | × | ✓ | × | × | × |
| ChatDB [ 96 ] | × | × | ✓ | × | × | × |
| TiM [ 97 ] | × | × | ✓ | × | × | × |
| SCM [ 98 ] | × | ✓ | ✓ | × | × | × |
| Voyager [ 99 ] | × | × | ✓ | × | × | × |
| MemGPT [ 100 ] | × | ✓ | ✓ | × | × | × |
| MemoChat [ 94 ] | × | × | ✓ | × | × | × |
| MPC [ 101 ] | × | × | ✓ | × | × | × |
| Generative Agents [ 83 ] | × | × | ✓ | × | × | × |
| RecMind [ 102 ] | ✓ | × | × | × | × | × |
| Retroformer [ 103 ] | ✓ | × | × | ✓ | ✓ | × |
| ExpeL [ 82 ] | ✓ | × | ✓ | ✓ | × | × |
| Synapse [ 91 ] | × | × | ✓ | × | × | × |
| GITM [ 93 ] | ✓ | × | ✓ | ✓ | × | × |
| ReAct [ 104 ] | ✓ | × | × | ✓ | × | × |
| Reflexion [ 5 ] | ✓ | × | × | ✓ | × | × |
| RecAgent [ 95 ] | × | ✓ | ✓ | × | × | × |
| Character-LLM [ 105 ] | × | ✓ | × | × | ✓ | × |
| MAC [ 106 ] | × | × | × | × | × | ✓ |
| Huatuo [ 107 ] | ✓ | × | × | × | ✓ | × |
| ChatDev [ 1 ] | ✓ | × | × | × | × | × |
| InteRecAgent [ 108 ] | × | ✓ | ✓ | ✓ | × | × |
| MetaAgents [ 109 ] | × | × | ✓ | × | × | × |
| TPTU [ 110 , 111 ] | ✓ | × | × | ✓ | × | × |
| MetaGPT [ 112 ] | ✓ | × | × | × | × | × |
| S 3 [ 2 ] | × | × | ✓ | × | × | × |
| InvestLM [ 113 ] | ✓ | × | × | × | ✓ | × |

**5.2.1 Memory in Textual Form**

Textual form is currently the mainstream method to represent the memory contents, which is featured in better interpretability, easier implementation, and faster read-write efficiency. In specific, the textual form can be both non-structured representations like raw natural languages and structured information such as tuples, databases, and so on. In general, previous studies use the textual form memory to store four types of information including (1) complete agent-environment interactions, (2) recent agent-environment interactions, (3) retrieved agent-environment interactions, and (4) external knowledge. In the former three methods, the memory leverages natural languages to describe the information within the agent-environment interaction loop. In the former three types, they record the information inside the agent-environment interaction loop, while the last type leverages natural languages to store information outside that loop.

Complete Interactions . This method stores all the information of the agent-environment interaction history based on long-context strategies [ 116 ] . For the example in Section 3.1 , the memory of the agent in task (A) after step 2 can be implemented by concatenating all the information before step 2, and the final textual form memory is: "Your memory is [Step 1] (Agent) … (Online Ticket Office) … [Step 2] … Please infer based on your memory".

In the previous work, different models store the memory information using different strategies. For example, in LongChat [ 116 ] , the agents focus on understanding natural languages in long-context scenarios. It fine-tunes the foundation model for better adapting to memorize complete interactions. Memory Sandbox [ 117 ] intends to alleviate the impact of irrelevant memory in conversations. It designs a transparent and interactive method to manage the memory of agents, which removes irrelevant memory before concatenating them as a prompt. Moreover, some efforts are dedicated to enhancing the capacity of LLMs to handle longer contexts [ 118 , 119 ] .

While storing all the agent-environment interactions can maintain comprehensive information, obvious limitations exist in terms of computational cost, inference time, and inference robustness. Firstly, the fast-growing long-context memory in practice results in high computational cost during LLM inference, due to the quadratic growth of the time complexity of attention computation with sequence length. It thus requires much more computing resources and significantly increases inference latency, which hinders its practical deployment. What’s more, with its fast growth, the memory length can easily exceed the upper bound of the sequence length during LLM’s pretraining, which makes a truncation of memory necessary. Thus, it can lead to information loss due to the incompleteness of agent memory. Last but not least, it can lead to biases and unrobustness in LLM’s inference. Specifically, a previous research [ 120 ] has shown that, the positions of text segments in a long context can greatly affect their utilization, so the memory in the long-context prompt can not be treated equally and stably. All these drawbacks show the need to design extra memory modules for LLM-based agents, rather than straightforwardly concatenating all the information into a prompt.

Recent Interactions . This method stores and maintains the most recently acquired memories using natural languages, thereby enhancing the efficiency of memory information utilization according to the Principle of Locality [ 121 ] . In task (B) of the example in Section 3.1 , we can just remember Alice’s preferences in the recent three years, and truncate the distant part, where the recent three years can be considered as the memory window size.

In previous studies, there are various strategies to store recent textual memories. For example, SCM [ 98 ] proposes a flash memory based on the cache mechanism, which preserves observations from the recent t − 1 t-1 time steps, aimed at enhancing the recency of information. MemGPT [ 100 ] considers the agent as an operating system, which can dynamically interact with users through a natural interface. It designs the working context to hold recent histories, as a part of virtual context management. In RecAgent [ 95 ] , the agents are designed to simulate user behaviors in movie recommendations. It stores some temporal information in short-term memory as an intermediate cache, which can simulate the memory mechanism of the human brain [ 122 , 123 ] . These representative methods can dynamically update memories based on recent interactions, and pay more attention to the recent context that is important for the current stage.

Caching the memory according to recency is an effective way to enhance memory efficiency, and it enables agents to focus more on the recent information. However, in long-term tasks, this method fails to access key information from distant memories. It can result in the loss of potentially crucial information that is not within the immediate cache window. In other words, emphasizing on recency can inherently neglect earlier, yet critical information, thus posing challenges in scenarios requiring a comprehensive understanding of past events.

Retrieved Interactions . Unlike the above method which truncates memories based on time, this method typically selects memory contents based on their relevance, importance, and topics. It ensures the inclusion of distant but crucial memories in the decision-making process, thereby addressing the limitation of only memorizing recent information. In task (A) of the example in Section 3.1 , Alice’s preferences have been stored in the memory before this task. At [Step 2], the agent will retrieve the most relevant aspects of Alice’s preferences from memory based on the query keyword "travel", obtaining Alice’s scenic spot preference for ancient architectures. In general, retrieval methods will generate embeddings as indexes for memory entries during memory writing, along with recording auxiliary information to assist in retrieval. During memory reading, matching scores are calculated for each memory entry, and the top- K K entries will be used for the decision-making process of agents.

In existing studies, most agents utilize retrieval methods to process the memory information. For example, Park et al. [83] first calculate the relevance between the current context and memory entries by cosine similarity, and obtain the importance and recency according to auxiliary information. MemoryBank [ 6 ] employs a dual-tower dense retrieval model to find related information from past conversations. Each memory entry is encoded into an embedding and subsequently indexed by FAISS [ 124 ] to improve the efficiency of retrieval. When reading memories, the current context will be encoded as representations to obtain the most relevant memory. Moreover, RET-LLM [ 7 ] intends to design a write-read memory module for general usage. It utilizes Locality-Sensitive Hashing (LSH) to retrieve tuples with relative entries in the database to provide more information. In addition, ChatDB [ 96 ] designs to utilize symbolic memory, and proposes to generate SQL statements to retrieve from database to obtain stored information.

The retrieval methods considerably depend on the accuracy and efficiency of obtaining expected information. An inaccurate retrieval strategy can potentially acquire unrelated information that is unhelpful for agent inference. And a heavy retrieval system can lead to large computational costs and long time latency, especially when handling massive information. Moreover, retrieval methods typically store homogeneous information inside the environment, where all the information is in a consistent form. For heterogeneous information outside the environment, it’s difficult to directly apply the same method for memory storage.

External Knowledge . To obtain more information, some agents acquire external knowledge by invoking tools, with the aim of transforming additional relevant knowledge into their own memories for decision-making. For instance, accessing external knowledge through Application Programming Interface (API) is a common practice [ 104 , 5 ] . Nowadays, abundant public information, such as Wikipedia and OpenWeatherMap 4 4 4 https://openweathermap.org , are available online (either free of charge or on a paying basis), and can be conveniently accessed through API calls. For instance, in [Step 2] of task (A) of the example in Section 3.1 , external knowledge from the digital magazine is obtained with tool methods.

In existing models, Toolformer [ 125 ] proposes to teach LLM to use tools, which can acquire external knowledge for better solving tasks. Furthermore, ToolLLM [ 126 ] empowers Llama [ 127 ] with the ability to utilize more APIs in RapidAPI 5 5 5 https://rapidapi.com/hub and to enable multi-tool usage, which provides a general interface to extend agents’ ability. In TPTU [ 110 ] , the agents are incorporated in both task planning and tool usage, in order to tackle intricate problems. The follow-up work [ 111 ] further improves its ability extensively like retrieval. In ToRA [ 128 ] , the agents are required to solve mathematical problems. They utilize imitation learning to improve their ability to use program-based tools.

The above methods significantly advance the capabilities of agents by allowing them to access external up-to-date and real-world information from diverse sources. However, the reliability of this information can be questionable due to potential inaccuracies and biases [ 18 ] . Furthermore, the integration of tools into agents demands a comprehensive understanding to interpret the retrieved information across various contexts, which can incur higher computational costs and complications in aligning external data with internal decision-making processes. Additionally, utilizing external APIs brings forth concerns regarding privacy, data security, and compliance with usage policies, necessitating rigorous management and oversight [ 18 ] .


**5.2.2 Memory in Parametric Form**

An alternative type of approaches is to represent memory in parametric form. They do not take up the extra length of context in prompts, so they are not constrained by the length limitations of LLM context. However, the parametric memory form is still under-researched, and we categorize previous works into two types: fine-tuning methods and memory editing methods.

Fine-tuning Methods. Integrating external knowledge into the memory of agents is beneficial for enriching domain-specific knowledge on top of its general knowledge. To infuse the domain knowledge into LLMs, supervised fine-tuning is a common approach, which empowers agents with the memory of domain experts. It significantly improves the agent’s ability to accomplish domain-specific tasks. In task (A) of the example in Section 3.1 , the external knowledge of attractions from magazines can be fine-tuned into the parameters of LLMs prior to this task.

In previous works, Character-LLM [ 105 ] focuses on the role-play circumstance. It utilizes supervised fine-tuning strategies with role-related data ( e.g., experiences), to endow agents with the specific traits and characteristics of the role. Huatuo [ 107 ] intends to empower agents with professional ability in the biomedical domain. It tries to fine-tune Llama [ 127 ] on Chinese medical knowledge bases. Besides, in order to create artificial doctors, DoctorGLM [ 129 ] fine-tunes ChatGLM [ 130 ] with LoRA [ 131 ] , and Radiology-GPT [ 132 ] improves domain knowledge on radiology analysis by supervised fine-tuning on an annotated radiology dataset. Moreover, InvestLM [ 113 ] collects investment data and fine-tunes it to improve domain-specific abilities on financial investment.

The fine-tuning methods can effectively bridge the gap between general agents and specialized agents. It improves the capability of agents on the tasks that require high accuracy and reliability on domain-specific information. Nevertheless, fine-tuning LLMs for specific domains could potentially lead to overfitting, and it also raises concerns about catastrophic forgetting, where LLMs may forget the original knowledge because of updating their parameters. Another limitation of fine-tuning lies in the computational cost and time consumption, as well as the requirement of a large amount of data. Therefore, most fine-tuning approaches are applied to offline scenarios, and can seldom deal with online scenarios, such as fine-tuning with agent observations and trial experiences. Due to the frequent agent-environment interactions, it is unaffordable for the cost of backpropagation to fine-tune every step of the online and dynamic interactions.

Memory Editing Methods. Apart from the fine-tuning approaches, another type of methods for infusing memory into model parameters is knowledge editing [ 133 , 134 ] . Unlike fine-tuning methods that extract patterns from certain datasets, knowledge editing methods specifically target and adjust only the facts that need to be changed. It ensures that unrelated knowledge remains unaffected. Knowledge editing methods are more suitable for small-scale memory adjustments. Generally, they have lower computational costs, making them more suitable for online scenarios. In our example of task (B), Alice always watches movies at 9:00 PM from the agent’s memory, but she may recently change her work and would not be empty at 9:00 PM. If so, the related memory (such as routines at 9:00 PM) should be edited, which can be implemented by knowledge editing methods.

In previous studies, MAC [ 106 ] intends to design an effective and efficient memory adaptation framework for online scenarios. It utilizes meta-learning to substitute the optimization step. PersonalityEdit [ 135 ] focuses on editing the personality of LLMs and agents, where it changes their traits based on theories such as the big-five factor. MEND [ 134 ] utilizes the idea of meta-learning to train a lightweight model, which is capable of generating modifications for model parameters of a pre-trained language model. APP [ 136 ] studies whether adding a new fact leads to catastrophic forgetting of existing facts. It focuses on the impact of neighbor perturbation on memory addition. Moreover, KnowledgeEditor [ 133 ] trains a hyper-network to predict the modification of model parameters when injecting memory based on a learning-to-update problem formulation. Wang et al. [137] propose a new optimization target to change the poisoning knowledge of LLM, and maintain the general performance at the same time. For LLM-based agents, the agents can change bad memory by knowledge editing, which can be considered as a type of forgetting mechanism.

Knowledge editing methods provide an innovative way to update the information stored within the parameters of LLMs. By specifically targeting and adjusting the facts, these methods can ensure the non-targeted knowledge unaffected during updates, thus mitigating the issue of catastrophic forgetting. Moreover, the targeted adjustment mechanism allows for more efficient and less resource-intensive updates, making knowledge editing an appealing choice for high-precision and real-time modifications. However, despite these promising developments, computational costs of meta-training and the preservation of unrelated memories remain significant challenges.


**5.2.3 Advantages and Disadvantages of Textual and Parametric Memory**

Textual memory and parametric memory have their strengths and weaknesses respectively, making them suitable for different memory contents and application scenarios. In this section, we discuss the advantages and disadvantages of these two forms of memory from various aspects.

Effectiveness. The textual memory stores raw information about the agent-environment interactions, which is more comprehensive and detailed. However, it is constrained by the token limitation of LLM prompts, which makes the agent hard to store extensive information. In contrast, the parametric memory is not limited by the prompt length, but it may suffer from information loss when transforming texts into parameters, and the complex memory training can bring additional challenges.

Efficiency. For textual memory, each LLM inference requires to integrate memory into the context prompt, which leads to higher costs and longer processing times. In contrast, for parametric memory, the information can be integrated into the parameters of the LLM, eliminating the extra costs of these contexts. However, parametric memory takes additional costs in the writing process, but textual memory is easier to write, especially for small amounts of data. In a nutshell, textual memory is more efficient in writing, while parametric memory is more efficient in reading.

Interpretability. Textual memory is usually more explainable than the parametric one, since natural languages are the most natural and straightforward strategies for humans to understand, while parametric memory is commonly represented in latent space. Nevertheless, such explainability is obtained at the cost of information density. This is because the sequences of words in textual memory are represented in a discrete space, which is not as dense as continuous space in parametric memory.

In conclusion, the trade-offs between these two types of memories make them suitable for different applications. For example, for the tasks that require recalling recent interactions, like conversational and context-specific tasks, textual memory seems more effective. For the tasks that require a large amount of memory, or well-established knowledge, parametric memory can be a better choice.


#### 5.3 Memory Operations

We separate the entire procedure of memory into three operations: memory writing, memory management, and memory reading. These three typically collaborate to achieve memory function, providing information for LLM inference. We summarize previous works on memory operations in Table 3 .


> [Figure/Table Caption] Table 3: Summarization of the memory operations. If a model does not have special designs on the memory operations, we use ∘ \circ to label it, otherwise, it is denoted by ✓ \checkmark . × means that the memory operations are not discussed in the paper.

| Models | Writing | Management | Reading |
|  | Merging | Reflection | Forgetting |  |
| MemoryBank [ 6 ] | ✓ | ✓ | ✓ | ✓ | ✓ |
| RET-LLM [ 7 ] | ✓ | × | × | × | ✓ |
| ChatDB [ 96 ] | ✓ | × | ✓ | × | ✓ |
| TiM [ 97 ] | ✓ | ✓ | × | ✓ | ✓ |
| SCM [ 98 ] | ✓ | ✓ | × | × | ✓ |
| Voyager [ 99 ] | ✓ | × | ✓ | × | ✓ |
| MemGPT [ 100 ] | ✓ | × | ✓ | × | ✓ |
| MemoChat [ 94 ] | ✓ | × | × | × | ✓ |
| MPC [ 101 ] | ✓ | × | × | × | ✓ |
| Generative Agents [ 83 ] | ✓ | × | ✓ | ✓ | ✓ |
| RecMind [ 102 ] | ∘ \circ | × | × | × | ✓ |
| Retroformer [ 103 ] | ✓ | ✓ | ✓ | × | ∘ \circ |
| ExpeL [ 82 ] | ✓ | ✓ | ✓ | × | ∘ \circ |
| Synapse [ 91 ] | ✓ | × | × | × | ✓ |
| GITM [ 93 ] | ∘ \circ | ✓ | ✓ | × | ✓ |
| ReAct [ 104 ] | ∘ \circ | × | × | × | ∘ \circ |
| Reflexion [ 5 ] | ✓ | ✓ | ✓ | × | ∘ \circ |
| RecAgent [ 95 ] | ✓ | ✓ | ✓ | ✓ | ✓ |
| Character-LLM [ 105 ] | ✓ | × | × | × | ∘ \circ |
| MAC [ 106 ] | ✓ | ✓ | ✓ | × | ✓ |
| Huatuo [ 107 ] | ✓ | × | × | × | ∘ \circ |
| ChatDev [ 1 ] | ✓ | × | ✓ | × | ✓ |
| InteRecAgent [ 108 ] | ✓ | ✓ | ✓ | × | ✓ |
| MetaAgents [ 109 ] | ✓ | × | ✓ | × | ✓ |
| TPTU [ 110 , 111 ] | ∘ \circ | × | ✓ | × | ✓ |
| MetaGPT [ 112 ] | ✓ | × | ✓ | × | ✓ |
| S 3 [ 2 ] | ✓ | × | ✓ | ✓ | ✓ |
| InvestLM [ 113 ] | ✓ | × | × | × | ∘ \circ |

**5.3.1 Memory Writing**

After the information is perceived by the agent, a part of it will be stored by the agent for further usage through the memory writing operation, and it is crucial to recognize which information is essential to store. Many studies choose to store the raw information, while others also put the summary of the raw information into the memory module.

Representative Studies. In TiM [ 97 ] , the raw information will be extracted as the relation between two entities, and stored in a structured database. When writing into the database, similar contents will be stored in the same group. In SCM [ 98 ] , it designs a memory controller to decide when to execute the operations. The controller serves as a guide for the whole memory module. In MemGPT [ 100 ] , the memory writing is entirely self-directed. The agents can autonomously update the memory based on the contexts. In MemoChat [ 94 ] , the agents summarize each conversation segment by abstracting the mainly discussed topics and storing them as keys for indexing memory pieces.

Discussion. Previous research indicates that designing the strategy of information extraction during the memory writing operation is vital [ 94 ] . This is because the original information is commonly lengthy and noisy. Besides, different environments may provide various forms of feedback, and how to extract and represent the information as memory is also significant for memory writing.


**5.3.2 Memory Management**

For human beings, memory information is constantly processed and abstracted in the brains. The memory in the agent can also be managed by reflecting to generate higher-level memories, merging redundant memory entries, and forgetting unimportant, early memories.

Representative Studies. In MemoryBank [ 6 ] , the agents process and distill the conversations into a high-level summary of daily events, similar to how humans recall key aspects of their experiences. Through long-term interactions, they continually evaluate and refine their knowledge, generating daily insights into personality traits. In Voyager [ 99 ] , the agents are able to refine their memory based on the feedback of the environment. In Generative Agents [ 83 ] , the agents can reflect to get higher-level information, where the abstract thoughts are generated from agents. The reflection process will be activated when there are accumulated events that are enough to address. For GITM [ 93 ] , in order to establish common reference plans for various situations, key actions from multiple plans are further summarized in the memory module.

Discussion. Most of the memory management operations are inspired by the working mechanism of human brains. With the strong capability of LLMs to simulate human minds, these operations can help the agents to better generate high-level information and interact with environments.


**5.3.3 Memory Reading**

When the agents require information for reasoning and decision-making, the memory reading operation will extract related information from memory for usage. Therefore, how to access the related information for the current state is important. Due to the massive quantity of memory entities, and the fact that not all of them are pertinent to the current state, careful design is required to extract useful information based on relevance and other task-orientated factors.

Representative Studies. In ChatDB [ 96 ] , the memory reading operation is executed by the SQL statements. These statements will be generated by agents as a series of Chain-of-Memory in advance. In MPC [ 101 ] , the agents can retrieve relevant memory from the memory pool. This method also proposes to provide Chain-of-Thought examples for ignoring certain memory. ExpeL [ 82 ] utilizes the Faiss [ 124 ] vector store as the pool of memory, and obtains the top- K K successful trajectories that share the highest similarity scores with the current task.

Discussion. To some extent, the memory reading and writing operations are collaborative, and the forms of memory writing greatly influence the methods of memory reading. For the forms of textual memory, most previous works use the text similarity and other auxiliary information for reading. For the forms of parametric memory, existing models may just utilize the updated parameters for inference, which can be seen as an implicit reading process.


### 6 How to Evaluate the Memory in LLM-based Agent

How to effectively evaluate the memory module remains an open problem, where diverse evaluation strategies have been proposed in previous works according to different applications. To clearly show the common ideas of different evaluation methods, in this section, we summarize a general framework, which includes two broad evaluation strategies (see Figure 5 for an overview), that is, (1) direct evaluation, which independently measures the capability of the memory module. (2) indirect evaluation, which evaluates the memory module via end-to-end agent tasks. If the tasks can be effectively accomplished, the memory module is demonstrated to be useful.


> [Figure/Table Caption] Figure 5: An overview of the evaluation methods of the memory module.


#### 6.1 Direct Evaluation

This type of approaches regards the memory of the agents as a stand-alone component and evaluates its effectiveness independently. Previous studies can be categorized into two classes: subjective evaluation and objective evaluation. The subjective evaluation aims to measure memory effectiveness based on human judgments, which can be widely used in the scenarios that lack objective ground truths. Objective evaluation assesses memory effectiveness based on numerical metrics, which makes it easy to compare different memory modules.


**6.1.1 Subjective Evaluation**

In subjective evaluation, there are two key problems, that is, (1) what aspects should be evaluated and (2) how to conduct the evaluation process. To begin with, the following two aspects are the most common perspectives leveraged to evaluate the memory module.

Coherence. This aspect refers to whether the recalled memory is natural and suitable for the current context. For example, if the agent is making a plan for Alice’s travel, the memory should be related to her preference for traveling rather than working. In previous works, Modarressi et al. [7] study whether the memory module could provide proper references among the ever-changing knowledge. Liang et al. [98] present some examples to demonstrate the relation between the current query and historical memory. Zhong et al. [6] and Liu et al. [97] assess the coherence of responses that integrate context and retrieved memory by scoring labels. Lee et al. [101] focus on the contradiction between the recalled memory and contexts.

Rationality. This aspect aims to evaluate whether the recalled memory is reasonable. For example, if the agent is asked to answer "Where is the Summer Palace", the recalled memory should be "The Summer Palace is in Beijing" rather than "The Summer Palace is on the Moon". In previous works, Lee et al. [101] ask crowd workers to directly score the rationality of the retrieved memory. Zhong et al. [6] and Liu et al. [97] recruit human evaluators to check if the memory contains reasonable answers for the current question.

As for how to conduct the evaluation process, there are two important problems. The first one is how to select the human evaluators. In general, the evaluators should be familiar with the evaluation task, which ensures that the labeling results are convincing and reliable. In addition, the backgrounds of the evaluators should be diverse to remove subjective biases of specific human groups. The second problem is how to label the outputs of the memory module. Usually, one can either directly score the results [ 6 ] or make comparisons between two candidates [ 95 ] . The former can obtain absolute and quantitative evaluation results, while the latter can remove the labeling noises when independently scoring each candidate. In addition, the granularity of the ratings should also be carefully designed. Too coarse ratings may not effectively discriminate the capabilities of different memory modules, while too fine-grained ones may bring more effort for the workers to make judgments.

In general, subjective evaluation can be used in a wide range of scenarios, where one just needs to define the evaluation aspects and let recruited workers make judgments. This method is usually more explainable since the workers can provide the reasons for their judgments. However, subjective evaluation is costly due to the need to employ human evaluators. Additionally, different groups of evaluators may have various biases, making the results difficult to reproduce and compare.


**6.1.2 Objective Evaluation**

In objective evaluation, previous work usually defines numeric metrics to evaluate the effectiveness and efficiency of the memory module.

Result Correctness. This metric measures whether the agent can successfully answer pre-defined questions directly based on the memory module. For example, the question could be "Where did Alice go today?" with two choices "A: the Summer Palace" and "B: the Great Wall". Then, the agent should choose the correct answer based on the problem and its memory. The agent-generated answer will be compared with the ground truth. Formally, the accuracy can be calculated as

|  | Correctness = 1 N ∑ i = 1 N 𝕀 [ a i = a ^ i ] , \text{Correctness}=\frac{1}{N}\sum_{i=1}^{N}\mathbb{I}\left[a_{i}=\hat{a}_{i}\right], |  |
where N N is the number of problems, a i a_{i} represents the ground truth for the i i -th problem, a ^ i \hat{a}_{i} means the answer given by the agent, and 𝕀 [ a i = a ^ i ] \mathbb{I}\left[a_{i}=\hat{a}_{i}\right] is the matching function commonly represented as

|  | 𝕀 [ a i = a ^ i ] = { 1 if ​ a i = a ^ i , 0 if ​ a i ≠ a ^ i . \mathbb{I}\left[a_{i}=\hat{a}_{i}\right]=\begin{cases}1&\text{if }a_{i}=\hat{a}_{i},\\ 0&\text{if }a_{i}\neq\hat{a}_{i}.\end{cases} |  |
In previous works, Hu et al. [96] construct questions from past histories with annotated ground truths and calculate the accuracy of whether the recalled memory could match the correct answers. Similarly, Packer et al. [100] generate questions and answers that can only be derived from past sessions, and compare the responses from the agents with the ground truths to calculate the accuracy.

Reference Accuracy. This metric evaluates whether the agent can discover relevant memory contents to answer the questions. Different from the above metric, which focuses on the final results, reference accuracy cares more about the intermediate information to support the agent’s final decisions. In specific, it compares the retrieved memory with the pre-prepared ground truth. For the above problem of "Where did Alice go today?", if the memory contents include (A) "Alice had lunch with friends at Wangfujing today." and (B) "Alice had roast duck for lunch", then a better memory module should select (A) as a reference to answer the question. Usually, researchers leverage F1-score to evaluate the reference accuracy, which is calculated as

|  | F1 = 2 ⋅ Precision ⋅ Recall Precision + Recall , \text{F1}=2\cdot\frac{\text{Precision}\cdot\text{Recall}}{\text{Precision}+\text{Recall}}, |  |
where the precision and recall scores are calculated as Precision = TP TP + FP \text{Precision}=\frac{\text{TP}}{\text{TP}+\text{FP}} and Recall = TP TP + FN \text{Recall}=\frac{\text{TP}}{\text{TP}+\text{FN}} . The TP represents the number of true positive memory contents, FP means the number of false positive memory contents, and FN indicates the number of false negative memory contents. In previous works, Lu et al. [94] utilize F1-score to evaluate the retrieval process of the memory, and Zhong et al. [6] focus on assessing whether related memory can be successfully retrieved.

Result Correctness and Reference Accuracy are both utilized to evaluate the effectiveness of the memory module. Beyond effectiveness, efficiency is also an important aspect, especially for real-world applications. Therefore, we describe the evaluation of efficiency as follows.

Time & Hardware Cost. The total time cost includes the time leveraged for memory adaption and inference. The adaptation time refers to the time of memory writing and memory management, while the inference time indicates the time latency of memory reading. In specific, the difference from the end time to the start time of memory operations can be considered as the time consumption. Formally, the average time consumption of each type of operation can be represented as

|  | Δ ​ time = 1 M ​ ∑ i = 1 M t i end − t i start , \Delta\text{time}=\frac{1}{M}\sum_{i=1}^{M}t_{i}^{\text{end}}-t_{i}^{\text{start}}, |  |
where M M represents the number of these operations, t i end t_{i}^{\text{end}} means the end time of the i i -th operation, and t i start t_{i}^{\text{start}} indicates the start time of that operation. As for the computation overhead, it can be evaluated by the peak GPU memory allocation. In previous works, Tack et al. [106] utilize the peak memory allocation and adaptation time to assess the efficiency of memory operations.

Objective evaluation offers numeric strategies to compare different methods of memory, which is important to benchmark this field and promote future developments.


#### 6.2 Indirect Evaluation

Besides the above method that directly evaluates the memory module, evaluating via task completion is also a popular evaluation strategy. The intuition behind this type of approaches is that if the agent can successfully complete a task that highly depends on memory, it suggests that the designed memory module is effective. In the following parts, we present several representative tasks that are leveraged to evaluate the memory module in indirect ways.


**6.2.1 Conversation**

Engaging in conversations with humans is one of the most important applications of agents, where memory plays a crucial role in this process. By storing context information in memory, the agents allow users to experience personalized conversations, thus improving users’ satisfaction. Therefore, when other parts of the agents are determined, the performance of the conversation tasks can reflect the effectiveness of different memory modules.

In the context of conversation, consistency and engagement are two commonly used methods to evaluate the effectiveness of the agents’ memory. Consistency refers to how the response from agents is consistent with the context because dramatic changes should be avoided during the conversation. For example, Lu et al. [94] evaluate the consistency of agents on interactive dialogues, using GPT-4 to score on the responses from agents. Engagement refers to how the user is engaged to continue the conversation. It reflects the quality and attraction of agents’ responses, as well as the ability of agents to craft the personas for current conversations. For example, Lee et al. [101] assess the engagingness of responses by SCE-p score, and Packer et al. [100] utilize CSIM score to evaluate the memory effect on increasing engagement of users.


**6.2.2 Multi-source Question-answering**

Multi-source questing-answering can comprehensively evaluate the memorized information from multiple sources, including inside-trial information, cross-trial information, and external knowledge. It focuses on the integration of memory utilization from various contents and sources.

In previous works, Yao et al. [104] evaluate the memory that integrates information from the task trial and the external knowledge from Wikipedia. Then, Shinn et al. [5] and Yao et al. [103] further include the cross-trial information of the same task, where the memory is permitted to obtain more experiences from previous failed trials. Moreover, Packer et al. [100] allow agents to utilize the memory from multi-document information for question-answering.

By evaluating multi-source question-answering tasks, the memory of agents can be examined on the capability of content integration from various sources. It also reveals the issue of the memory contradiction due to multiple information sources, and the problem of updated knowledge, which can potentially affect the performance of the memory module.


**6.2.3 Long-context Applications**

Beyond the above general applications, in many scenarios, LLM-based agents have to make decisions based on extremely long prompts. In these scenarios, the long prompts are usually regarded as the memory contents, which play an important role in driving agent behaviors.

In previous works, Huang et al. [19] organize a comprehensive survey for long-context LLMs, which provides a summary of evaluation metrics on long-context scenarios. Moreover, Shaham et al. [138] propose a zero-shot benchmark for evaluating agents’ understanding of long-context natural languages. As for specific long-context tasks, long-context passage retrieval is one of the important tasks for evaluating the long-context ability of agents. It requires agents to find the correct paragraph in a long context that corresponds to the given questions or descriptions [ 139 ] . Long-context summarization is another representative task. It requests agents to formulate a global understanding of the whole context, and summarizes it according to the descriptions, where some metrics on matching scores like ROUGE can be utilized to compare the results with ground truths.

The evaluation of long-context applications provides broader approaches to assess the function of memory in agents, focusing on practical downstream scenarios. The comprehensive benchmarks [ 138 , 140 ] also provide an objective assessment for the ability of long-context understanding.


**6.2.4 Other Tasks**

In addition to the above three types of major tasks for indirect evaluation, there are also some other metrics in general tasks that can reveal the effectiveness of the memory module.

Success rate refers to the proportion of tasks that agents can successfully solve. For Yao et al. [104] , Shinn et al. [5] and Zhao et al. [82] , they assess how many spacial tasks can be correctly completed through reasoning and memory in AlfWorld [ 141 ] . In Zhu et al. [93] , they evaluate the success rate of producing different items in Minecraft to show the effect of memory. Moreover, Shinn et al. [5] measure the success rate of passed problems by generated codes, and Zheng et al. [91] calculate the success rate of computer control and accuracy of element selection to show the function of trajectory-as-exemplar memory. Exploration degree typically appears in exploratory games, which reflects the extent that agents can explore the environment. For example, Wang et al. [99] compare the numbers of distinct items explored in Minecraft to reflect the skill learning in memory.

In fact, nearly all the memory-equipped agents can evaluate the effect of memory by ablation studies, comparing the performance between with/without memory modules. The evaluation on specific scenarios can better reflect the significance of memory for the downstream applications practically.


#### 6.3 Discussions

Compared with direct evaluation, indirect evaluation via specific tasks can be easier to conduct, since there are already many public benchmarks. However, the performance on tasks can be attributed to various factors, and memory is only one of them, which may make the evaluation results biased. By direct evaluation, the effectiveness of the memory module can be independently evaluated, which improves the reliability of the evaluation results. However, to our knowledge, there are no open-sourced benchmarks tailored for the memory modules in LLM-based agents.


### 7 Memory-enhanced Agent Applications

Recently, LLM-based agents have been investigated across a wide variety of scenarios, facilitating societal advancement. In general, most LLM-based agents are equipped with memory modules. However, the specific effects undertaken by these memory components, the particular information they store, and the implementation methods they use, vary across different applications. In order to provide insights for the design of memory functionalities in LLM-based agents, in this section, we review and summarize how memory mechanisms are manifested in LLM-based agents across various application scenarios. In specific, we categorize them into several classes: role-playing and social simulation, personal assistant, open-world games, code generation, recommendation, expert systems in specific domains, and other applications. The summarization is shown in Table 4 .


> [Figure/Table Caption] Table 4: Summarization of memory-enhanced agents applications.

| Applications | Models | Applications | Models |
| Role-playing | Character-LLM [ 105 ] | Code Generation | RTLFixer [ 142 ] |
| ChatHaruhi [ 143 ] | GameGPT [ 144 ] |
| RoleLLM [ 145 ] | ChatDev [ 1 ] |
| NarrativePlay [ 146 ] | MetaGPT [ 109 ] |
| CharacterGLM [ 147 ] | CodeAgent [ 114 ] |
| Social Simulation | Generative Agents [ 83 ] | Recommendation | RecAgent [ 95 ] |
| Lyfe Agents [ 148 ] | InteRecAgent [ 108 ] |
| S 3 [ 2 ] | RecMind [ 102 ] |
| MetaAgents [ 109 ] | AgentCF [ 149 ] |
| WarAgent [ 150 ] | Medicine | Huatuo [ 107 ] |
| Personal Assistant | MemoryBank [ 6 ] | DoctorGLM [ 129 ] |
| RET-LLM [ 7 ] | Radiology-GPT [ 132 ] |

*[Truncated after 85,000 characters; core sections preserved above.]*
