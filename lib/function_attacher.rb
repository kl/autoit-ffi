#encoding: utf-8

module AutoItFFI

  module FunctionAttacher

    FUNCTION_PROTOTYPES = [
      [ :AU3_Init,                  [],                          :void ],
      [ :AU3_BlockInput,            [:long],                     :void ],
      [ :AU3_MouseGetPosX,          [],                          :int  ],
      [ :AU3_MouseGetPosY,          [],                          :int  ],
      [ :AU3_IsAdmin,               [],                          :int  ],
      [ :AU3_MouseMove,             [:long, :long, :long],       :long ],
      [ :AU3_WinMinimizeAll,        [],                          :void ],
      [ :AU3_WinMinimizeAllUndo,    [],                          :void ],
      [ :AU3_MouseWheel,            [:pointer, :long],           :void ],
      [ :AU3_CDTray,                [:pointer, :pointer],        :long ],
      [ :AU3_Send,                  [:pointer, :long],           :void ],
      [ :AU3_Sleep,                 [:long],                     :void ],
      [ :AU3_ToolTip,               [:pointer, :long, :long],    :void ]
    ] 


    # Attaches the AutoIt DLL functions to lib (which must extend FFI::Library).
    # See "doc/Function Prototypes (C).txt" for the C header file.
    #
    def self.attach(lib)
      FUNCTION_PROTOTYPES.each { |fun| lib.attach_function *fun }
    end

  end
end

# AU3_API void WINAPI AU3_MouseWheel(LPCWSTR szDirection, long nClicks);
# AU3_API long WINAPI AU3_CDTray(LPCWSTR szDrive, LPCWSTR szAction);


