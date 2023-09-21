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
      it "responds 302 to create" do
        customer = create(:customer)
        get :create, params: { id: customer.id }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "Mmeber/ User" do
    before do
      member = create(:member) # Create meber for devise verification
      @customer = create(:customer) # Create a customer (user)
      sign_in member # Make the meber sign in to be able to see the view
    end
    it "verify login" do
      get :show, params: { id: @customer.id } # Member acess the view of the customer created
      expect(response).to have_http_status(200)
    end

    it "verify login with template" do
      get :show, params: { id: @customer.id }
      expect(response).to render_template(:show) # Same test as above but using the template instead of http response
    end

    it "with valid attributes" do
      customer_params = attributes_for(:customer) # Brings a hash with customer attributes. Methos from the factory_bot
      expect { # as a {} because it nedd to be interpreted before runing. with () will break
        post :create, params: { customer:  customer_params } # Here the params are set excly as in the strong params in the controller
      }.to change(Customer, :count).by(1) # Check if in the DB the class customer will have one more record
    end

    it "with invalid attributes" do
      customer_params = attributes_for(:customer, address: nil)
      expect {
        post :create, params: { customer:  customer_params }
      }.not_to change(Customer, :count)
    end

    it "shows a flash notice" do
      customer_params = attributes_for(:customer)
      post :create, params: { customer:  customer_params }
      # pp response
      expect(flash[:notice]).to match(/successfully created/)
    end

    it "Content type json" do
      customer_params = attributes_for(:customer)
      get :create, format: :json, params: { customer:  customer_params } # Required format json
      expect(response.content_type).to match(/application\/jso/)
    end

    context "routes" do
      it { should route(:get, "/customers").to(action: :index) } # The route /customers should enter the index action on the controller
    end
  end
end
