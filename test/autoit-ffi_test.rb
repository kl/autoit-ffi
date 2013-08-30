
require 'minitest/autorun'

require_relative '../lib/autoit-ffi.rb'

AI = AutoItFFI::AutoIt

class AutoItTest < MiniTest::Test

  def test_admin?
    is_admin = system('reg query "HKU\S-1-5-19"')   # this key can only be read as an administrator
    assert_equal is_admin, AI.admin?
  end

end
