module Docspec
  module StringRefinements
    refine String do
      def ellipses_match?(other)
        str = self

        str = str[3..] if str.start_with?('...')
        str = str[..-4] if str.end_with?('...')

        other.include?(str)
      end
    end
  end
end
