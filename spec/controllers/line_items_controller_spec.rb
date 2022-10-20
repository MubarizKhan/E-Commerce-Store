require 'spec_helper'

require "rails_helper"

RSpec.describe LineItemsController, :type => :controller do
  describe "responds to" do
    it "responds to html by default" do
      post :create, :params => { :order => {:cart_id=> 12,
                                            :product_id => 12,
                                            :quantity  => 12} }

      expect(response.content_type).to eq "text/html; charset=utf-8"
    end

    it "responds to custom formats when provided in the params" do
      post :create, :params => { :order => {:cart_id=> 12,
                                 :product_id => 12,
                                 :quantity  => 12} , :format => :json }
      expect(response.content_type).to eq "application/json; charset=utf-8"
    end
  end
end



RSpec.describe LineItemsController, :type => :controller do
  describe "add quantity" do
    it "has a 200 status code" do
      add_quantity_line_item_path(22)
      expect(response.status).to eq(200)
    end
  end
end

RSpec.describe LineItemsController, :type => :controller do
  describe "reduce quantity" do
    it "has a 200 status code" do
      reduce_quantity_line_item_path(22)
      expect(response.status).to eq(200)
    end
  end
end


RSpec.describe LineItemsController, :type => :controller do
  describe "reduce quantity" do
    it "has a 200 status code" do
      checkout_line_items_path(22)
      expect(response.status).to eq(200)
    end
  end
end
