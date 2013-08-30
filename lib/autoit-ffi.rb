#encoding: utf-8

require 'ffi'

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

    def mouse_wheel(direction, clicks)
      self.AU3_MouseWheel(to_utf16(direction), clicks)
    end

    def cd_tray(drive, action)
      result = self.AU3_CDTray(to_utf16(drive), to_utf16(action))
      result == 1
    end

    def send(text, mode = :special)
      mode_int = mode == :raw ? 1 : 0
      self.AU3_Send(to_utf16(text), mode_int)
    end

    # --- Helpers ----

    def to_utf16(object)
      object.to_s.encode("UTF-16LE")
    end
    private_class_method :to_utf16

  end
end
