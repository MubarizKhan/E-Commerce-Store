# frozen_string_literal: true

module LineItemsManager
  class LineItemPriceSetter
    def initialize(chosen_product:, line_item:)
      @chosen_product = chosen_product
      @line_item = line_item
    end

    def call
      set_price
    end

    private

    def set_price
      @line_item.total_line_item_price = @line_item.quantity * @chosen_product.item_price
      @line_item.save
    end
  end
end
