#encoding: utf-8

require 'ffi'
require 'pry'

require_relative 'function_attacher'

module AutoItFFI

  module AutoIt

    extend FFI::Library
    ffi_lib File.expand_path(File.dirname(__FILE__)) + "/../dll/AutoItX3.dll"
    ffi_convention :stdcall
    FunctionAttacher.attach(self)

    module_function

    def admin?
      self.AU3_IsAdmin == 1
    end

    def move_mouse(x, y, speed = 10)
      self.AU3_MouseMove(x, y, speed)
    end

    def get_mouse_pos_x
      self.AU3_MouseGetPosX
    end

    def get_mouse_pos_y
      self.AU3_MouseGetPosY
    end

  end
end

#AU3_API long WINAPI AU3_MouseGetPosX(void);
#AU3_API long WINAPI AU3_MouseMove(long nX, long nY, /*[in,defaultvalue(-1)]*/long nSpeed);
