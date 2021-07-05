if exists("current_compiler")
  finish
endif
let current_compiler = "gopls"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=gopls\ check\ $*
CompilerSet errorformat=%E%f:%l%c:%m
