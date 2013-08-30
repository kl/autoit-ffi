#encoding: utf-8

module AutoItFFI

  module FunctionAttacher

    # Attaches the AutoIt DLL functions to lib (which must extend FFI::Library).
    # See "doc/Function Prototypes (C).txt" for the C header file.
    #
    def self.attach(lib)

      lib.attach_function :AU3_MouseGetPosX, [], :int
      lib.attach_function :AU3_MouseGetPosY, [], :int
      lib.attach_function :AU3_IsAdmin, [], :int
      lib.attach_function :AU3_MouseMove, [:long, :long, :long], :long

      lib.attach_function :AU3_WinMinimizeAll, [], :void
      lib.attach_function :AU3_WinMinimizeAllUndo, [], :void
      lib.attach_function :AU3_MouseWheel, [:pointer, :long], :void

      lib.attach_function :AU3_CDTray, [:pointer, :pointer], :long

      lib.attach_function :AU3_Send, [:pointer, :long], :void

    end

  end
end

# AU3_API void WINAPI AU3_MouseWheel(LPCWSTR szDirection, long nClicks);
# AU3_API long WINAPI AU3_CDTray(LPCWSTR szDrive, LPCWSTR szAction);


