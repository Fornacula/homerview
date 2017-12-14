# frozen_string_literal: true

module RuboCop
  module Cop
    module Layout
      # This cops checks if empty lines around the bodies of classes match
      # the configuration.
      #
      # @example EnforcedStyle: empty_lines
      #   # good
      #
      #   class Foo
      #
      #     def bar
      #       # ...
      #     end
      #
      #   end
      #
      # @example EnforcedStyle: empty_lines_except_namespace
      #   # good
      #
      #   class Foo
      #     class Bar
      #
      #       # ...
      #
      #     end
      #   end
      #
      # @example EnforcedStyle: empty_lines_special
      #   # good
      #   class Foo
      #
      #     def bar; end
      #
      #   end
      #
      # @example EnforcedStyle: no_empty_lines (default)
      #   # good
      #
      #   class Foo
      #     def bar
      #       # ...
      #     end
      #   end
      class EmptyLinesAroundClassBody < Cop
        include EmptyLinesAroundBody

        KIND = 'class'.freeze

        def on_class(node)
          _name, _superclass, body = *node
          check(node, body)
        end

        def on_sclass(node)
          _obj, body = *node
          check(node, body)
        end
      end
    end
  end
end
