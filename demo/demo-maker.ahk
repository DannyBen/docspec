; --------------------------------------------------
; This script generates the demo svg
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 60

; NOTE: This should be executed in the demo folder

Return

Type(Command, Delay=1000) {
  Send % Command
  Sleep 400
  Send {Enter}
  Sleep 300
  Sleep Delay
}

F12::
  Type("rm README.md")
  Type("termtosvg cast.svg -t window_frame")

  Type("{#} Create a markdown document", 500)
  Type("vi README.md")
  Type("iCode inside ruby code fence will be tested:`n`n``````ruby`nputs 1{+}2`n{#}=> 3`n```````n")
  Type("``````ruby`n{#} this test will fail`nputs 'actual output'`n{#}=> expected output`n```````n", 3000)
  Type("{Escape}:x")
  
  Type("{#} Run docspec", 500)
  Type("docspec", 5000)

  Type("exit")
Return

^F12::
  Reload
return

F11::
  ExitApp
return
