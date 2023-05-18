require_relative '../test_init'

def clear_screen
  print "\e[2J\e[H"
  STDOUT.flush
end

def console_info
  width, height = console_dimensions

  <<~TEXT
  Width: #{width}
  Height: #{height}
  TEXT
end

def console_rows
  height, _width = console_dimensions
  height
end

def console_dimensions
  console = IO.console

  console.winsize
end
