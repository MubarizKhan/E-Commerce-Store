module LineItemsManager

  class LineItemQuantityAdder
      def initialize(chosen_product:, line_item:)
        @chosen_product = chosen_product
        @line_item = line_item
      end

      def call
        result = add_quantity
      end

      private

      def add_quantity

        if @line_item.quantity < @chosen_product.item_quantity
          @line_item.quantity += 1
          @line_item.save
        end
      end

    end
  end

