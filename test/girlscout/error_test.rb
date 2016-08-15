require 'support'

module GirlScout
  class ErrorTest < GirlScoutTest
    def test_initialize
      attributes = { hello: "world", error: "123" }

      instance = GirlScout::Error.new(attributes)
      assert_equal "world", instance.hello
      assert_equal "123", instance.message
    end

    def test_initialize_normalize_keys
      attributes = { }
      attributes[:symbol_key] = "Sym"

      instance = GirlScout::Error.new(attributes)
      assert_equal "Sym", instance.symbol_key
      assert_equal "Sym", instance["symbolKey"]
    end

    def test_to_string
      message = 'Authentication was not provided or was invalid.'
      attributes = {
        code:  401,
        error: message
      }

      instance = GirlScout::Error.new(attributes)
      assert_equal message, instance.to_s
    end

    def test_auth_error
      error = capture do
        Conversation.find('40100')
      end

      refute_nil error
      assert_equal 401, error.code
      assert_equal "Authentication was not provided or was invalid.", error.message
    end

    def test_not_found_error
      error = capture do
        Conversation.find('40400')
      end

      refute_nil error
      assert_equal 404, error.code
      assert_equal "The requested resource was not found.", error.message
    end

    private

    def capture
      yield
      nil
    rescue GirlScout::Error => e
      e
    end
  end
end
