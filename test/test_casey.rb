require 'minitest/autorun'
require 'Casey'

class FTTest < Minitest::Test
    # Run a test from early morning.
    def test_format
        assert_equal "This Is My 1st Test String. It's not much, but it's mine!",
            Casey.run(["format", "--case=title", "this IS my 1St Test string. It's not much, but IT's mine!"])
    end
end
