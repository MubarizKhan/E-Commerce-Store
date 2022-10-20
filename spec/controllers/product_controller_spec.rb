require "rails_helper"
require 'spec_helper'



RSpec.describe ProductsController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      # get :index
      expect(response.status).to eq(200)
      end
    end
  end

  RSpec.describe ProductsController, :type => :controller do
    describe "GET show" do
      it "has a 200 status code" do
        # get :show
        products_path(23)
        expect(response.status).to eq(200)
      end
    end
  end


# RSpec.describe ProductsController, :type => :controller do
#   describe "responds to" do
#     it "responds to html by default" do
#       post :create, :params => { :product => { :name => "Any Name",
#                                                :item_quantity => 12,
#                                                :item_price => 12,
#                                                :user_id => 12 } }
#       expect(response.content_type).to eq "text/html; charset=utf-8"
#     end

#     it "responds to custom formats when provided in the params" do
#       post :create, :params => { :product => { :name => "Any Name",
#                                                :item_quantity => 12,
#                                                :item_price => 12,
#                                                :user_id => 12 } , :format => :json }
#       expect(response.content_type).to eq "application/json; charset=utf-8"
#     end
#   end
# end
