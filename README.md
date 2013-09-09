autoit-ffi ― FFI bindings for AutoIt
==========

###

__This is a very early, unfishied version.__

##Overview

This project aims to be a complete Ruby wrapper of the excellent AutotIt library (http://www.autoitscript.com/site/). autoit-ffi uses the AutoItX3 dll library, and not the COM interface. This means that there is no need to install AutoIt prior to using autoit-ffi, in fact installation is as easy as ```gem install autoit-ffi```

##Installation

```gem install autoit-ffi```

##Usage

```ruby
require 'autoit-ffi'

ai = AutoItFFI::AutoIt

ai.admin?                           # => true/false
ai.move_mouse(500, 500, 5)          # x, y, speed
ai.cd_tray("D:", :open)             # magic!
ai.tool_tip("Tool tip!", 200, 200)  # text, x, y
ai.send("this text will be sent by simulated key strokes")
```

For a list of the currently implemented functions, see https://github.com/kl/autoit-ffi/blob/master/lib/function_attacher.rb
