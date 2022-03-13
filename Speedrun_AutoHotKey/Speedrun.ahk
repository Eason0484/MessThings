^!x::ExitApp	; Suspend script with Ctrl+Alt+X
#IfWinActive Minecraft
F4:: ;Autocreate with easy mode
Send, `t
Sleep, 70
Send, {enter}
Sleep, 70
Send, +`t
Send, +`t
Sleep, 70
Send, {enter}
Sleep, 70
Send, `t
Send, `t
Sleep, 70
Send, {enter}
Send, {enter}
Send, {enter}
Sleep, 70
Send, +`t
Send, +`t
Sleep, 70
Send, {enter}
return
F12:: ;close world
send {Esc}+{Tab}{Enter} 
return
f6:: ;Recreate worlds
Send, `t
Sleep, 70
Send, {enter}
Send, `t
Send, `t
Send, `t
Send, `t
Send, `t
Send, `t
Sleep, 70
Send, {enter}
Sleep, 350
Send, {enter}
return
f7:: ;Autocreate world with SSG seed
Send, `t
Sleep, 70
Send, {enter}
Send, +`t
Send, +`t
Sleep, 70
Send, {enter}
Send, +`t
Send, +`t
Send, +`t
Sleep, 70
Send, {enter}
Send, `t
Send, `t
Send, `t
Sleep, 70
Send, -3294725893620991126
Sleep, 70
Send, +`t
Send, +`t
Sleep, 70
Send, {enter}
return
f9:: ;Autocreate worlds with SSG seed (peaceful)
Send, `t
Sleep, 70
Send, {enter}
Send, +`t
Send, +`t
Sleep, 70
Send, {enter}
Send, `t
Send, `t
Sleep, 70
Send, {enter}
Send, {enter}
Sleep, 70
Send, `t
Send, `t
Send, `t
Send, `t
Sleep, 70
Send, {enter}
Send, `t
Send, `t
Send, `t
Sleep, 70
Send, -3294725893620991126
Sleep, 70
Send, {enter}
return
insert:: ;Autoreset Demo
Send, `t
Send, `t
Send, {enter}
Send, `t
Send, {enter}
Send, `t
Send, {enter}
return