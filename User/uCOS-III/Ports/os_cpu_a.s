IMPORT		OSTCBCurPtr
IMPORT		OSTCBHighRdyPtr
	
EXPORT		OSStartHighRdy
EXPORT		PendSV_Handler


NVIC_INT_CTRL EQU 0xE000ED04 ; �жϿ��Ƽ�״̬�Ĵ��� SCB_ICSR��
NVIC_SYSPRI14 EQU 0xE000ED22 ; ϵͳ���ȼ��Ĵ��� SCB_SHPR3��
						     ; bit16~23
NVIC_PENDSV_PRI EQU 0xFF ; PendSV ���ȼ���ֵ(���)��
NVIC_PENDSVSET EQU 0x10000000 ; ���� PendSV �쳣��ֵ Bit28��PENDSVSET


OSStartHighRdy
	LDR R0, = NVIC_SYSPRI14 ; ���� PendSV �쳣���ȼ�Ϊ��� (1)
	LDR R1, = NVIC_PENDSV_PRI
	STRB R1, [R0]
 
	MOVS R0, #0 ;���� psp ��ֵΪ 0����ʼ��һ���������л� (2)
	MSR PSP, R0
  
	LDR R0, =NVIC_INT_CTRL ; ���� PendSV �쳣 (3)
	LDR R1, =NVIC_PENDSVSET
	STR R1, [R0]
 
	CPSIE I ; ʹ�����жϣ�NMI �� HardFault ���� (4)
 
	OSStartHang
	B OSStartHang ; ����Ӧ��Զ�������е�����
	
	

PendSV_Handler
	CPSID	I
	MRS		R0,PSP
	CBZ		R0,OS_CPU_PendSVHandler_nosave
	
	STMDB	R0!, {R4-R11}
	LDR		R1, = OSTCBCurPtr
	LDR		R1, [R1]
	STR		R0, [R1]
	
OS_CPU_PendSVHandler_nosave
	LDR		R0, = OSTCBCurPtr
	LDR 	R1, = OSTCBHighRdyPtr
	LDR		R2, [R1]
	STR		R2, [R0]
	
	LDR 	R0, [R2]
	LDMIA	R0!, {R4-R11}
	
	MSR		PSP, R0
	ORR		LR, LR,#0x04
	
	CPSIE	I
	
	BX		LR