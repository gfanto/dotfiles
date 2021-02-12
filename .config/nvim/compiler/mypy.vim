if exists("current_compiler")
  finish
endif
let current_compiler = "mypy"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=mypy\ --ignore-missing-imports\ --show-column-numbers\ --no-error-summary\ --no-color-output\ %
CompilerSet errorformat=%f:%l%c:%m
