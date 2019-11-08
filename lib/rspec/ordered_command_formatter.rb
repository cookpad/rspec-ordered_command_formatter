require "rspec/ordered_command_formatter/version"

RSpec::Support.require_rspec_core "formatters/base_formatter"

module RSpec
  class OrderedCommandFormatter < Core::Formatters::BaseFormatter
    RSpec::Core::Formatters.register self, :seed, :dump_summary

    def seed(notification)
      self.seed_value = notification.seed if notification.seed_used?
    end

    def dump_summary(notification)
      output.puts [
        "rspec",
        order_option,
        notification.examples.map(&:location)
      ].flatten.join(" ")
    end

    private

      attr_accessor :seed_value

      def order_option
        if seed_value
          "--order random:#{seed_value}"
        else
          "--order defined"
        end
      end
  end
end
