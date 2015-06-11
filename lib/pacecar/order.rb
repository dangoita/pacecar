require 'active_support/concern'

module Pacecar
  module Order
    extend ActiveSupport::Concern

    included do
      define_order_scopes
    end

    module ClassMethods

      def define_order_scopes
        safe_column_names.each do |name|
          scope "by_#{name}", ->(*args) {
            direction = args.flatten.first || 'asc'
            order("#{quoted_table_name}.#{connection.quote_column_name name} #{direction}")
          }
        end
      end

    end
  end
end
