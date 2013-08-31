#encoding: utf-8

require 'ffi'
require_relative 'function_attacher'

module AutoItFFI

  module AutoIt

    # "Default" value for _some_ int parameters (largest negative number)
    AU3_INTDEFAULT = -2147483647
    # Used when constructing strings consumed by AutoIt
    UTF_16LE_NULL = "\0".encode("UTF-16LE")

    extend FFI::Library
    ffi_lib File.expand_path(File.dirname(__FILE__)) + "/../dll/AutoItX3.dll"
    ffi_convention :stdcall

    FunctionAttacher.attach(self)
    self.AU3_Init

    module_function

    def auto_it_set_option(option, value)
      self.AU3_AutoItSetOption(to_utf16(option), value.to_i)
    end

    def admin?
      self.AU3_IsAdmin == 1
    end

    def block_input(flag)
      flag_int = flag ? 1 : 0
      self.AU3_BlockInput(flag_int)
    end

    def move_mouse(x, y, speed = 10)
      self.AU3_MouseMove(x.to_i, y.to_i, speed.to_i)
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
      self.AU3_MouseWheel(to_utf16(direction), clicks.to_i)
    end

    def cd_tray(drive, action)
      result = self.AU3_CDTray(to_utf16(drive), to_utf16(action))
      result == 1
    end

    def send(text, mode = :special)
      mode_int = mode.to_sym == :raw ? 1 : 0
      self.AU3_Send(to_utf16(text), mode_int)
    end

    def sleep(milliseconds)
      self.AU3_Sleep(milliseconds.to_i)
    end

    def tool_tip(tip, x = AU3_INTDEFAULT, y = AU3_INTDEFAULT)
      self.AU3_ToolTip(to_utf16(tip), x.to_i, y.to_i)
    end

    def win_close(title, text = "")
      result = self.AU3_WinClose(to_utf16(title), to_utf16(text))
      result == 1
    end

    def win_exists?(title, text = "")
      result = self.AU3_WinExists(to_utf16(title), to_utf16(text))
      result == 1
    end

    # --- Helpers ----
  
    # All AutoIt functions that take strings expect the strings to be of the "LPCWSTR"
    # or "LPWSTR" types, which use 2 bytes per character. This method calls to_s on its
    # argument and converts the string to UTF-16LE so that AutoIt can use it. Note that the
    # NULL character must be explicitly added.
    #
    def to_utf16(object)
      object.to_s.encode("UTF-16LE") + UTF_16LE_NULL
    end
    private_class_method :to_utf16

  end
end
