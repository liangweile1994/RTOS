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