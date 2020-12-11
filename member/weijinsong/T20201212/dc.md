
# DC flow

## How to arrange floders

| type   | name               |                          |
|--------|--------------------|--------------------------|
| file   | .synopsys_dc.setup | dc enveriment setup file |
| floder | scripts            | place dc script          |
| floder | rtl                | place rtl file           |
| floder | netlist            | place netlist, sdf, sdc  |
| floder | report             | place report file        |
| floder | unmapped           |                          |
| floder | log                | run log                  |

## How to write "*.synopsys_dc.setup*"
1. setup TOP_DESIGN
```tcl
set TOP_DESIGN SNN_Core 
set DesignTopName SNN_Core
``` 
2. setup path : **In this part, users will define every path based on their hobbies.**
> - [] project path 
```tcl
set ProjHomePath /home1/weijinsong/workspace/SNN-Chip-Hardware_soc
set DCPath  $ProjHomePath/dc
set ProjRTHPath $DCPath/rtl
set ProjSYNPath $DCPath/syn
```
> - [] IP path 
```tcl
set IPPath $ProjHomePath/system/ip
```
3. setup search_path
```tcl
set search_path [list \
            ./lib \
            ./rtl \
            ./scripts ]
```
4. setup library
> - [] target_library : set the std cell path
```tcl
set target_library "./lib/smic180/slow.db"
```
> - [] symbol_library : set symbol_library
```tcl
set symbol_library "./lib/smic180/slow.db"
```
> - [] link_library : 这个部分包括IP的库和std_cell的库。
```tcl
set link_library [ list *\
            ./lib/smic180/slow.db \
            ./lib/smic180/smic18.sdb \
            ./lib/sram_synapse/sram_synapse_128x22_slow_syn.db ]
```
5. alias 
```tcl
alias h history
alias rc "report_constraint -all_violators"
alias rt report_timing
alias rtt "report_timing -nets -path_type full_clock -to"
alias rtf "report_timing -nets -path_type full_clock -from"
alias verilog_syn "source ./scripts/dc_top.tcl"
alias dcc_syn "source ./scripts/dc_top_ddc.tcl"
alias sourceread "source ./scripts/dc_read.tcl"
```

### Understand library
#### std_cell
std_cell是fundray厂提供的库，这个库里包含逻辑门，触发器，buffer等单元。
1. 逻辑库
>逻辑库包含与综合过程有关的信息且通过DC用于设计的综合和优化。<br>
这个库中包括**pin，area, pin type, power, pin timing**这些信息。<br>
逻辑库是一个文本文件（扩展名".lib")，使用library_compiler(LC)编译生成".db"的二进制格式.
smic180的std_cell的逻辑库的名字是
```
ss_1v62_125c.lib   : 最差工艺角 
tt_1v8_25c.lib     : 常规工艺角 
ff_1v98_0c.lib     : 最好工艺角
```
2. 物理库
>物理库包含单元的物理特征和Physical Compiler的必要信息。<br>
物理库也有一个文本文件扩展名".plib"或者".lef"。".plib"可以通过LC编译生成".pdb"，".lef"文件通过lef2pdb转化成pdb

#### IP 
IP库同std_cel

## How to write DC scripts

### dc_read.tcl : read rtl
```tcl
set RTLFileList [exec cat ./SNN_Core.flst]
# exec cat 执行shell命令c
# SNN_Core.flst 是记录全部的rtl代码的位置和名字
foreach rtlfile $RTLFileList {
    analyze -f sverilog $rtlfile
}
# analyze 检查语法，产生".syn"文件存储在work路径下定义设计库内
elaborate $TOP_DESIGN
# elaborate 在产生的中间文件中生成verilog module or VHDL module
# elaborate can set top_module's parameter:
# elaborate chip_top -parameter "DATA_WIDTH = 8, ADDR_WIDTH = 8"
### 
current_design $TOP_DESIGN
# set current_design

check_design > ./rpt/${TOP_DESIGN}_pre_check.rpt # save pre_check report
link
# link cmd connect the module or ip in the DC buffe
# set 'link_library' in the '.synopsys_dc.setup' to tell DC where to find these modules
uniquify 
# 为了在layout中进行时钟树的综合，网表在DC中必须被uniquified.
# uniquified 就是在设计中使子模块的实例和子模块的定义一一对应，消除一个模块的定义被多次引用的现象
write -format ddc -h -o ./unmapped_db/$TOP_DESIGN.ddc
```

## dc_cons.tcl : 设置约束
设置约束需要先了解数字电路的setup time，hold time约束。(请参考数字电路设计书籍，或者百度)

```tcl
#### Defining Constranints Parameters ###########
set CLK_PERIOD              10      # 时钟的周期,单位是ns；这个单位可以在std_cell的手册中查到
set CLK_SKW                 0.03    # 时钟偏移，这个也可以在std_cell的手册中查到(p15);
set CLK_SOURCE_LATENCY      0       #
set CLK_NETWORK_LATENCY     0       #
set CLK_TRAN                0.23    #
set IN_DELAY_SA_MAX         0.5
set IN_DELAY_SA_MIN         0
set IN_TRAN_MAX             1
set IN_TRAN_MIN             1
set OUT_DELAY_MAX           1
set OUT_DELAY_MIN           0

set MAX_FANOUT              32
set MAX_TRAN                1
set MAX_CAP                 1
#### 
set clock_port "clk"
set reset_port "nrst"
# set driving_cell "SUFHDV4"

################## Definint The Operation Conditions #######################
# set_min_library $slow\.db -min_version $fast\.db # $slow & $fast 可以在.synopsys_dc.setup 中定义好，在这里可以直接引用
# set_operating_conditions -analysis_type bc_wc -max slow -min fast -min_library fast
# 这个命令可以同时指定最好工艺和最差工艺，目前之在PT中有
set_wire_load_mode enclosed # 
set access_internal_pins true

set_drive 0 [get_ports [list $clock_port $reset_port]] # "set_drive 0" means max driving ability
set_load $pad_cap [all_outputs]

############### set the design rule constraints ############################
# set_max_fanout 20.0 [remove_from_collection [all_inputs] [list $clock_port $reset_port]]
# set MAX_LOAD $pad_cap
# set_max_capacitance [expr $MAX_LOAD*20] [reomve_from collection [all_inputs] [list $clock_port $reset_port]]

############## Clock definition ######
create_clock -period $CLK_PERIOD -waveform [list 0 [expr $CLK_PERIOD/2]] [get_ports $clock_port] -name clk
set_dont_touch_network [get_clocks clk] # set_dont_touch_network apply to clocks pins ports
# the ports of Top_Module named "ports"
# other module's ports named "pins"
# tell DC don't optimze clk & rst
set_ideal_network [get_ports clk] -no_propagate
set_clock_uncertainty $CLK_SKEW [get_clocks clk]
set_clock_latency -source $CLK_SOURCE_LATENCY [get_clocks clk]
set_clock_transition $CLK_NETWORK_LATENCY [get_clocks clk]
set_clock_transition $CLK_TRAN [get_clocks clk]
# set_max_time_borrow [expr $CLK_PERIOD/2] [get_clocks clk]

################ reset_n ########################
# set enable_recovery_removal_arcs true
set_dont_touch_network [get_ports $reset_port] # 不优化rst信号，rst信号不影响时序
set_ideal_network [get_ports $reset_port] # 因为rst信号一般由外部输入而且时间比较长，这条指令不关注rst信号输出能力。
set_false_path -through [get_ports nrst]

################ Specifing I/O Timing Requirments #########################
set INPUT_EX_CLK [remove_from_collection [all_inputs] [get_ports [list clk]]]            
set INPUT_EX_CLK_RST [remove_from_collection [all_inputs] [get_ports [list clk nrst]]]  # 不关注rst和clk的输入延时

set_input_delay         -max $IN_DELAY_SA_MAX -clock clk $INPUT_EX_CLK_RST 
set_input_delay         -min $IN_DELAY_SA_MIN -clock clk $INPUT_EX_CLK_RST -add

set_input_transition    -max $IN_TRAN_MAX   $INPUT_EX_CLK_RST 
set_input_transition    -min $IN_TRAN_MIN   $INPUT_EX_CLK_RST

set_output_delay        -max $OUT_DELAY_MAX   -clock clk [all_outputs]
set_output_delay        -min $OUT_DELAY_MIN   -clock clk [all_outputs] -add

set_load        0.001   [all_outputs]

set DESIGN_CLOCKS [all_clocks]

################ Defining Design Rule #####################################
set_max_area 0
set_max_transition      $MAX_TRAN   [current_design]
set_max_fanout          $MAX_FANOUT [current_design]
set_max_capacitance     $MAX_CAP    [current_design]

check_timing > ./log/${TOP_DESIGN}_check_timing.log
report_port -verbose > ./log/${TOP_DESIGN}_report_port.log
report_timing_requirements > ./log/${TOP_DESIGN}_report_timing_requirements.log

```

## dc_syn.tcl : run dc

```tcl
set verilogout_no_tri true
foreach_in_collection design [ get_designs "*" ] {
    current_design $design
    set_fix_multiple_port_nets -all -buffer_constants
    set verilogout_no_tri true
}

current_design $TOP_DESIGN

set_fix_multiple_port_nets -all -buffer_constants

compile_ultra -gate_clock > ./log/${TOP_DESIGN}_compile.log # 运行DC

remove_unconnected_ports [find cell -h *]

set hdlout_internal_busses TRUE
set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
define_name_rules UPCAPS_ONLY -allowed "A-Z 0-9 _"

write -format ddc -h -o         ./mapped_db/$TOP_DESIGN.ddc
write -format verilog -h -o     ./netlist/$TOP_DESIGN.v
write_sdc                       ./netlist/$TOP_DESIGN.sdc
write_sdf                       ./netlist/$TOP_DESIGN.sdf

report_qor                      > ./rpt/${TOP_DESIGN}_qor.rpt
report_timing -max_paths 1000   > ./rpt/${TOP_DESIGN}_timing.rpt
report_timing -path full    		> ./rpt/${TOP_DESIGN}_full_timing.rpt
report_timing -delay min    		> ./rpt/${TOP_DESIGN}_hold_timing.rpt
report_timing -delay max    		> ./rpt/${TOP_DESIGN}_setup_timing.rpt
report_reference            		> ./rpt/${TOP_DESIGN}_ref.rpt
report_area                 		> ./rpt/${TOP_DESIGN}_area.rpt
report_constraints          		> ./rpt/${TOP_DESIGN}_const.rpt
report_constraint -all_violators 	> ./rpt/${TOP_DESIGN}_violators.rpt
report_power 				> ./rpt/${TOP_DESIGN}_power.rpt
report_clock_gating			> ./rpt/${TOP_DESIGN}_clkgate.rpt
report_design				> ./rpt/${TOP_DESIGN}_design.rpt 
report_cell				> ./rpt/${TOP_DESIGN}_cell.rpt
check_timing 				> ./log/${TOP_DESIGN}_last_check_timing.log
check_design 				> ./rpt/${TOP_DESIGN}_post_check.rpt
```

## Tips

### Clock Gating
>clk-gate一般有三种类型: a.简单组合逻辑实现; b.锁存器实现; c.D-触发器实现;
>> a. 简单组合逻辑实现
```verilog
    assign clk_out = clk_in & en;
```
![and-clock-gate](./picture/and-clock-gate.jpg)<br>
>> b. 锁存器实现
```verilog
reg enb;
always @(*)
begin
    if (~clk_in) begin
        enb <= en;
    end
end
assign clk_out = enb & clk_in;
```
![latch-clock-gate](./picture/latch-clock-gate.jpg)<br>
>> c. D-触发器实现
```verilog
reg enb ;
always @(posedge clk_in)
begin
    enb <= en;
end
assign clk_out = enb & clk_in;
```
![DFF-clock-gate](./picture/dff-clock_gate.jpg)<br>
>>确定了clk-gate类型后，可以直接例化上述模块。<br>
SMIC_180的库提供了latch型的clock-gate-cell "**TLATNTSCAX2M**"

### analog IP设置
1. .lef 描述analoglayout的文件，可以通过GDS转换成lef
> Virtuoso中的abstract generator可以根据layout生成abstract,然后可以根觉abstract提取lef文件。<br>
> lef中的类型core对应std_cel，block对应IP
3. .lib 描述analog的掩饰，引脚等信息
