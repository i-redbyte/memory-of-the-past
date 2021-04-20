@echo off
echo  32 bit .ASM compiling batch
tasm32 %1.asm /ml /m2 /l 
tlink32 /Tpe /c %1.obj,%1,,import32
del %1.obj
del %1.map
rem /zi  - Debug info for TASM32
rem /v   - Debug info for TLINK32


