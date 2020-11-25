#ifdef  OS_GLOBALS
#define OS_EXT
#else
#define OS_EXT	extern
#endif

#define OS_STATE_OS_STOPPED				(OS_STATE) (0u)
#define OS_STATE_OS_RUNNING				(OS_STATE) (1u)


typedef struct os_tcb				OS_TCB;
typedef void (*OS_TASK_PTR)(void *p_arg);
typedef struct os_rdy_list			OS_RDY_LIST;

struct os_rdy_list
{
	OS_TCB			*HeadPtr;
	OS_TCB			*TailPtr;
};

struct os_tcb
{
	CPU_STK						*StkPtr;
	CPU_STK_SIZE			StkSize;
};

OS_EXT			OS_RDY_LIST			OSRdyList[OS_CFG_PRIO_MAX];
OS_EXT			OS_TCB					*OSTCBCurPtr;
OS_EXT 			OS_TCB					*OSTCBHighRdyPtr;
OS_EXT			OS_STATE				OSRunning;