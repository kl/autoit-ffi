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

    def window_minimize_all
      self.AU3_WinMinimizeAll
    end

    def window_minimize_all_undo
      self.AU3_WinMinimizeAllUndo
    end

  end
end
