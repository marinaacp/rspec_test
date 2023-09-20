require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe "Guest" do
    context "index" do
      it "responds sucessufully" do
        get :index
        # puts response.inspect
        expect(response).to be_successful
      end

      it "responds 200" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "show" do
      it "responds 302 to show" do
        customer = create(:customer)
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "Mmeber/ User" do
    it "verify login" do
      member = create(:member) # Create meber for devise verification
      customer = create(:customer) # Create a customer (user)
      sign_in member # Make the meber sign in to be able to see the view
      get :show, params: { id: customer.id } # Member acess the view of the customer created
      expect(response).to have_http_status(200)
    end

    it "verify login with template" do
      member = create(:member)
      customer = create(:customer)
      sign_in member
      get :show, params: { id: customer.id }
      expect(response).to render_template(:show) # Same test as above but using the template instead of http response
    end
  end
end
