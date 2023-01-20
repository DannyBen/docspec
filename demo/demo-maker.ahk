; --------------------------------------------------
; This script generates the demo svg
; NOTE: This should be executed in the repo root
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 60


Return

Type(Command, Delay=1000) {
  Send % Command
  Sleep 400
  Send {Enter}
  Sleep 300
  Sleep Delay
}

F12::
  Type("{#} Press F11 to abort at any time")
  Type("cd ./demo")
  Type("rm README.md")
  Type("rm -f cast.json {;} asciinema rec cast.json")

  Type("{#} Create a markdown document", 500)
  Type("vi README.md")
  Type("iCode inside ruby code fence will be tested:`n`n``````ruby`nputs 1{+}2`n{#}=> 3`n```````n")
  Type("``````ruby`n{#} this test will fail`nputs 'actual output'`n{#}=> expected output`n```````n", 3000)
  Type("{Escape}:x")
  
  Type("{#} Run docspec", 500)
  Type("docspec", 5000)

  Type("exit")
  Type("agg --font-size 20 cast.json cast.gif")
  Sleep 400
  Type("cd ..")
  Type("{#} Done")
Return

^F12::
  Reload
return

F11::
  ExitApp
return
