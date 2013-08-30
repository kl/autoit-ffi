autoit-ffi ― FFI bindings for AutoIt
==========

###

This is a very early, unfishied version.

##Usage

```ruby
require_relative "lib/autoit-ffi"

ai = AutoItFFI::AutoIt

ai.admin?                     # => true/false
ai.move_mouse(500, 500, 5)    # x, y, speed
ai.cd_tray("D:", :open)		  # magic!
ai.send("this text will be sent by simulated key strokes")
```

