#encoding: utf-8

module AutoItFFI

  module FunctionAttacher

    def self.attach(lib)

      lib.attach_function("AU3_MouseGetPosX", "AU3_MouseGetPosX", [], :int)
      lib.attach_function("AU3_MouseGetPosY", "AU3_MouseGetPosY", [], :int)
      lib.attach_function("AU3_IsAdmin", "AU3_IsAdmin", [], :int)
      lib.attach_function("AU3_MouseMove", "AU3_MouseMove", [:long, :long, :long], :long)

    end

  end
end
