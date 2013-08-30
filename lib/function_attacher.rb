#encoding: utf-8

module AutoItFFI

  module FunctionAttacher

    # Attaches the AutoIt DLL functions to lib (which must extend FFI::Library).
    # See "doc/Function Prototypes (C).txt" for the C header file.
    #
    def self.attach(lib)

      lib.attach_function("AU3_MouseGetPosX", "AU3_MouseGetPosX", [], :int)
      lib.attach_function("AU3_MouseGetPosY", "AU3_MouseGetPosY", [], :int)
      lib.attach_function("AU3_IsAdmin", "AU3_IsAdmin", [], :int)
      lib.attach_function("AU3_MouseMove", "AU3_MouseMove", [:long, :long, :long], :long)

      lib.attach_function("AU3_WinMinimizeAll", "AU3_WinMinimizeAll", [], :void)
      lib.attach_function("AU3_WinMinimizeAllUndo", "AU3_WinMinimizeAllUndo", [], :void)

    end

  end
end
