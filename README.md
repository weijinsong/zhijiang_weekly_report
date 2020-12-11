# 67组之江小组每周工作记录

这是一个记录小组每周工作的仓库。

它有时快乐，有时忧郁，有时紧张，有时轻松。

除了默默记录，它也笑着点赞，它也皱着眉说可以。

它是一是条湾湾的河，载这大家的期待奔向大海。

它永远相信美好的事情即将发生。

---


---
# history

## [2020年](https://github.com/IMESNNGroup/history/2020/)

## 2020-09-25

#### 工作回报
| name| 工作内容|下周工作|
|:--|--|--|
| [卢建](https://github.com/IMESNNGroup/meeting_record/tree/master/member/%E5%8D%A2%E5%BB%BA/MEMO.docx)| 1.文献阅读：这一周主要阅读了一篇关于BayesianNeuralNetwork(BNN)算法的综述文章（BayesianNeuralNetworksAnintroductionandsuvery），泛读了一篇用MTJ实现BNN的文章(All-spinBayesianneuralnetwork)。 <br>2.验证工作总结||
|魏劲松| 1. 完成神经元电路的设计<br>2. 在RTL代码跑通mnist用例<br>2.优化spike_gen模块<br>3.进行ams仿真，验证数模接口|1.寻找并联系版图工程师<br>2.修改文章，把aer的文章修改成science china inforamation|
|[卢吉凯](https://github.com/IMESNNGroup/meeting_record/tree/master/member/卢吉凯/T20200925)|1、RRAM译码电路搭建完成，CadenceAMS单个核心仿真。<br>2、学习DoreFa-Net低比特量化算法。<br>3、完成IEDM审稿。|1、读写电路在CadenceAMS环境的仿真，编写测试文件。<br>2、尝试S4NN算法的低比特量化。<br>3、和安俊杰细化RRAM读写电路的设计|
|[安俊杰](https://github.com/IMESNNGroup/meeting_record/tree/master/member/安俊杰/T20200925)|1.电流电压转换电路<br>2.修改综述|1.尝试I/V电路设计与仿真<br>2.其他周边电路的考虑|
|[姜浩](https://github.com/IMESNNGroup/meeting_record/tree/master/member/%E5%A7%9C%E6%B5%A9/T20200925)|1、准备周五的大组会的PPT<br>2、阅读与神经元（同步和异步）相关的文献<br>3、看有关SNN和受限型玻尔兹曼机相关的资料|用异步方式实现一个数字的神经元|
|刘津畅|1、进行Eyeriss论文的阅读，准备汇报ppt<br>2、深入学习MATLAB<br>3、阅读RISC-V的手册|1、学习完MATLAB的基础知识，开始看深度学习的库<br>2、继续阅读RISC-V手册<br>3、学习attention机制，并简单实践一下<br>4、继续文献的阅读，拓宽基础知识|
|[唐双柱](https://github.com/IMESNNGroup/meeting_record/tree/master/member/唐双柱/T20200925)|1.1T1R测试(**[测试结果](https://github.com/IMESNNGroup/meeting_record/tree/master/member/唐双柱/T20200925/工作汇报9.25.pptx)**)。<br>2.文献阅读|1.继续1T1R测试。2.阅读RRAM阻值编程的文献|


|本周问题|状态|责任人|
|:--|--|--|
|暂时没有确定适合rram读写电路芯片的IV电路方案||安俊杰|
|SNN芯片的Core的spike_gen模块资源消耗很大||魏劲松|
|后端外包暂时没有联系人||魏劲松|

---

## 2020-09-18

#### 工作回报
| name   | 本周工作                                                                                                                                                                        | 下周工作                                                                                                                                 |
|:-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
|[卢建](https://github.com/IMESNNGroup/meeting_record/tree/master/member/%E5%8D%A2%E5%BB%BA/T20200918)|**1.文献阅读**<br> a.  A.Mehonic小组的工作(10.1038/s41467-020-18098-0)，主要内容通过仿真探讨器件非理想特性对网络的影响<br>b.   第二篇是A.Sebastian小组的工作(10.1038/s41467-020-16108-9)，主要内容通过仿真和实验(1MbPCM)探讨了在训练过程中，通过在权重中添加噪声<br> **2.SNN芯片系统级验证方案：**<br>a.初步提出了SNN芯片的系统级验证方案<br>b.工作就是需要把系统验证环境集成起来。| 1.调研相关文献，重关注一下以分布的形式看待权重的相关想法.<br>2.继续学习UVM|
|[卢吉凯]()|1.SNN核心与蜂鸟联合调试2.0版本。RRAM和神经元模型采用SystemC，其它数字部分采用Verilog实现。目前基本跑通，还在调试。<br>2.完善了对RRAM阵列的选通逻辑，VCS仿真通过，网络运行模式和读写模式下的阵列<br>3.模拟部分，搭建电压转换电路，传输门原理图，仿真通过。下一步计划是基于Cadence数模混合仿真平台仿真单个SNN核心以及RRAM译码电路。eda服务器上没有混合仿真的环境，于是在虚拟机上配置好了数模混合仿真环境。<br>4.串口与RISC-V通信控制RRAM读写，控制SNN运行状态调试通过。<br>5.调研神经信号数据集，综述论文已上传。<br>6.论文意见回稿。|1.搭建RRAM和译码电路原理图<br>2.基于CadenceAMS仿真单个SNN核心以及RRAM译码电路。由于仿真速度较慢，不会把蜂鸟直接放进去仿真，需要编写测试平台的总线交互逻辑。<br>3.2T1R的RRAM版图设计。<br>4.2.0DC综合<br>5.尝试基于S4NN算法的低比特量化。<br>6.IEDM审稿。|
| 魏劲松 | 1.解决simulator在mnist数据集上的识别率低的问题 <br> 2.RRAM结构和选通方案设计完成<br> 3.RTL2.0 debug<br> 4.利用verilator构造RTL2.0代码的全流程调式环境<br>5.Neuron电路图完成80%<br> | 1.提交RTL2.0代码,Neuron原理图，RRAM原理图和译码原理图<br> 2.在硬件上跑通mnist用例，提交系统原理图<br> 3.联系版图工程师，开始后端设计<br> |
|[姜浩](https://github.com/IMESNNGroup/meeting_record/tree/master/member/%E5%A7%9C%E6%B5%A9/T20200918)|1.调研数字神经元的相关论文[资料](https://github.com/IMESNNGroup/meeting_record/blob/master/member/%E5%A7%9C%E6%B5%A9/T20200918/%E6%95%B0%E5%AD%97neuron%E8%B0%83%E7%A0%94-%E5%A7%9C%E6%B5%A92020_9_18.docx)<br>2.写了一些CPU的总线部分（总线仲裁器、总线主控多路复用器、地址解码器、总线从属多路复用器）并仿真|<br>1.调研与SNN调度相关的文献资料<br>2.写一下CPU的GPIO部分并仿真，提高verilog编程能力|
|刘津畅|1、进行ANN和ANN加速器方面的论文的阅读<br>2、进行了状态机的复习，并且对握手协议和FIFO有了粗略的了解<br>3、继续深入的学习MATLAB<br>4、开始RISC_V指令集的学习|1、论文阅读<br>2、继续学习MATLAB<br>3、加深对RISC_V的学习和认知<br>4、准备下周的组会的课题|
|[唐双柱](https://github.com/IMESNNGroup/meeting_record/tree/master/member/%E5%94%90%E5%8F%8C%E6%9F%B1/T20200918)|1.阅读《Verilog数字系统设计教程》一书，深入学习和掌握Verilog的基本语法<br>2.测试1T1R的I-V特性，并记录有关数据<br>3.阅读了关于忆阻器的相关文献，了解了一些忆阻器基本特性|1.继续测试1T1R的I-V特性，并记录有关数据，画出图形<br>2.阅读有关RRAM存算一体的文献。|

#### 本周问题

| 问题                                                    | 状态 | 责任人     |
| :--                                                     | --   |  -          |
| 修改后AER电路的设计与原验证方案不符，需要进一步对齐<br> |    done  | weijinsong |
| Leaky电路无法双向漏电<br>                               | done     | weijinsong |
|验证：关于系统整体的复位、上电、时钟等相关的基本功能还没有具体的想法验证，需要调研相关的验证方法；| ignore | 卢建|
|验证：关于系统的能耗、能效的验证方案没有，但是这一部分估计不会验证，首先这不是属于必需验证项目；其次，系统文档中没有关于这一部分的相关描述。| ignore |卢建|

---


## 2020-09-14

| name   | 本周工作                                                                                                                                                                                                                                                                               | 下周工作                                                                                                                                                                    | 本周问题                                                                                                                                                                                                                                                    | 问题状体 |
|:-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| 卢吉凯 | 1.verilog联合模拟电路SystemC模型的基本用力跑通。验证V1.0RTL代码完成.<br>2.根据阵列结构和阵列的工作模式完成了选通逻辑部分的数字部分，与RISC-V的接口部分调通。<br> 3.通过串口与RISC-V的双向通信，仿真通过。现在可以通过串口实现对RRAM读写选通逻辑的控制，以及SNN核心运行状态的控制交互。 | 1. 将RISC-V和V2.0部分RTL代码合并。<br>2.尝试基于S4NN算法的低比特量化，实现MNIST库的识别。<br>3.考虑RRAM和选通电路的版图。                                                   |                                                                                                                                                                                                                                                             |          |
| 魏劲松 | 1、设计和仿真神经元电路，完成度80%，神经元的Leaky电路控制目前需要优化。<br>2、优化core RTL2.0代码，增加neuron控制开关的逻辑电路，增加TX-RX直通的路径<br>3、设计阵列结构和阵列工作模式选通逻辑                                                                                          | 1、提高mnist数据集在simulator中的识别率<br>2、完成神经元电路设计，完成阵列原理图设计。<br>3、与卢吉凯合并译码电路，阵列，神经元电路<br>4、合并SOC分支和master提交2.0RTL代码 | 1、之江实验室的服务器上没有数模混合仿真环境<br>2、神经元leaky电路问题，目前的设计只能保证当膜电位高于共模电位时leaky电路工作，但是当膜电位低于共模电位时leaky电路不工作。<br>3、mnist数据集在simulator上的识别率下降严重，simulator中的识别率只有20%左右。 |          |
| [安俊杰](https://github.com/IMESNNGroup/meeting_record/blob/master/member/%E5%AE%89%E4%BF%8A%E6%9D%B0/T20200914/architecture-an-2020.09.14.pdf) | 1.完成电流多值写入系统的整体规划。<br>2.将原本整合在一起的电路拆分，模块划分完毕.<br>3.帮魏师兄设计运算放大器                                                                                                                                                                          | 1.完成I/V转换电路<br>2.确定RRAM Crossbar阵列的规模.<br>3.尝试和ADC联调.                                                                                                     | 1.对器件特性不甚了解，电路参数确定困难。<br>2.具体规模阵列待与窦老师确认。                                                                                                                                                                                  |          |
| 姜浩   | 1.关于RRAM存算一体做了文献和书籍调研<br>2.读书：读缪向水的《忆阻器导论》第六七章节.<br>3.借《CPU自制入门》一书，学习有关CPU整体的设计思想，阅读书后附录代码，提高ｖｅｒｉｌｏｇ编程能力                                                                                                | 1.学习PT<br>2.学习总线协议，UART和GPIO通讯协议，用Verilog写出来<br>3.读有关RRAM存算一体方面的综述和期刊                                                                     |                                                                                                                                                                                                                                                             |          |
| 唐双柱 | 1.阅读《CPU自制入门》，学习了CPU的设计结构及制作过程。了解了verilog的一些基本语法<br>2.学习了LINUX的使用，Makefile文件的编写，并用VCS+verdi进行了联合仿真<br>3.进行了RRAM有关文献的调研                                                                                                | 1.继续学习《CPU自制入门》<br>2.阅读《Verilog数字系统设计教程》一书，深入学习和理解Verilog的基本语法                                                                         |                                                                                                                                                                                                                                                             |          |

#### 本周问题

| 问题                                                    | 状态 | 责任人     |
| :--                                                     | --   |  -          |
|1、之江实验室的服务器上没有数模混合仿真环境| done|weijinsong|
|2、神经元leaky电路问题，目前的设计只能保证当膜电位高于共模电位时leaky电路工作，但是当膜电位低于共模电位时leaky电路不工作|**延期** |weijinsong|
|3、mnist数据集在simulator上的识别率下降严重，simulator中的识别率只有20%左右。|done|weijinsong|
|1.对器件特性不甚了解，电路参数确定困难|done|安俊杰|
|2.具体规模阵列待与窦老师确认。|done|安俊杰|

---

