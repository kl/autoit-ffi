require 'ffi'
require 'pry'

module AutoItFFI
  extend FFI::Library
  ffi_lib File.expand_path(File.dirname(__FILE__)) + "/../dll/AutoItX3.dll"
  ffi_convention :stdcall

  attach_function("posx", "AU3_MouseGetPosX", [], :int)
  attach_function("AU3_IsAdmin", "AU3_IsAdmin", [], :int)
  attach_function("AU3_MouseMove", "AU3_MouseMove", [:long, :long, :long], :long)

  module_function

  def is_admin?
    self.AU3_IsAdmin == 1
  end

  def move_mouse(x, y, speed = 10)
    self.AU3_MouseMove(x, y, speed)
  end

end

#binding.pry

#AU3_API long WINAPI AU3_MouseGetPosX(void);
#AU3_API long WINAPI AU3_MouseMove(long nX, long nY, /*[in,defaultvalue(-1)]*/long nSpeed);
