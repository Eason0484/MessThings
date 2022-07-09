^!x::ExitApp	; Suspend script with Ctrl+Alt+X
#IfWinActive Minecraft
ExitWorld()
{
   send {Esc}+{Tab}{Enter} 
}

U::
   ExitWorld()
return