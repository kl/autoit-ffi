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

    def error
      self.AU3_error
    end

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

    def cd_tray(drive, action)
      result = self.AU3_CDTray(to_utf16(drive), to_utf16(action))
      result == 1
    end

    #
    # TODO: currently this method allocates a buffer that can hold 10000 utf16 characters to which
    # the clipboard data is read to. A better approach would be to first query the size of the clipboard
    # and allocate a buffer that fits that size. Note that the program will crash if there is more than 10000
    # characters in the clipboard.
    #
    def clip_get
      buffer = FFI::MemoryPointer.new(:uint16, 10000, true) # allocate 20000 bytes and zero out the memory.
      self.AU3_ClipGet(buffer, 10000)
      clipboard_data = buffer.read_string(buffer.size)
      clipboard_data.force_encoding("UTF-16LE").encode("UTF-8").rstrip
    end

    def control_click(title, text, control, button, num_clicks, x = AU3_INTDEFAULT, y = AU3_INTDEFAULT) 
      self.AU3_ControlClick(to_utf16(title),
                            to_utf16(text),
                            to_utf16(control),
                            to_utf16(button),
                            num_clicks.to_i,
                            x.to_i,
                            y.to_i)
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

    def send(text, mode = :special)
      mode_int = mode.to_sym == :raw ? 1 : 0
      self.AU3_Send(to_utf16(text), mode_int)
    end

    def sleep(milliseconds)
      self.AU3_Sleep(milliseconds.to_i)
    end

    def shutdown(*args)
      if args.size == 1 && args.first.is_a?(Fixnum)
        self.AU3_Shutdown(args.first.to_i)
      else
        options_hash = {logoff: 0, shutdown: 1, reboot: 2, force: 4, power_down: 8}
        options = options_hash.keys & args.map(&:to_sym)
        opt_num = options.map { |option| options_hash[option] }.inject(:+)
        raise ArgumentError, "Illegal arguments #{args.inspect}" if opt_num.nil?
        self.AU3_Shutdown(opt_num.to_i)
      end
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

    def win_kill(title, text = "")
      self.AU3_WinKill(to_utf16(title), to_utf16(text))
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
