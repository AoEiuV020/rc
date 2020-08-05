Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & Wscript.Arguments.Item(0) & Chr(34), 0
Set WshShell = Nothing

