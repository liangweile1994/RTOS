void OSTaskCreate(OS_TCB					*p_tcb,
									OS_TASK_PTR			 P_task,
									void						*p_arg,
									CPU_STK					*p_stk_base,
									CPU_STK					 stk_size,
									OS_ERR					*p_err)
{
	CPU_STK				*p_sp;
	p_sp = OSTaskStkInit(P_task,
											 p_arg,
											 p_stk_base,
											 stk_size);
	p_tcb->StkPtr  = p_sp;
	p_tcb->StkSize = stk_size;
	
	*p_err = OS_ERR_NONE;
}