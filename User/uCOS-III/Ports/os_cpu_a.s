NVIC_INT_CTRL EQU 0xE000ED04 ; 中断控制及状态寄存器 SCB_ICSR。
NVIC_SYSPRI14 EQU 0xE000ED22 ; 系统优先级寄存器 SCB_SHPR3：
						     ; bit16~23
NVIC_PENDSV_PRI EQU 0xFF ; PendSV 优先级的值(最低)。
NVIC_PENDSVSET EQU 0x10000000 ; 触发 PendSV 异常的值 Bit28：PENDSVSET


OSStartHighRdy
	LDR R0, = NVIC_SYSPRI14 ; 设置 PendSV 异常优先级为最低 (1)
	LDR R1, = NVIC_PENDSV_PRI
	STRB R1, [R0]
 
	MOVS R0, #0 ;设置 psp 的值为 0，开始第一次上下文切换 (2)
	MSR PSP, R0
  
	LDR R0, =NVIC_INT_CTRL ; 触发 PendSV 异常 (3)
	LDR R1, =NVIC_PENDSVSET
	STR R1, [R0]
 
	CPSIE I ; 使能总中断，NMI 和 HardFault 除外 (4)
 
	OSStartHang
	B OSStartHang ; 程序应永远不会运行到这里