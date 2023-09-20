require 'rails_helper'

RSpec.describe Product, type: :model do
  context "Validations" do
    it "is valid with description, price, category" do
      product = create(:product)
      expect(product).to be_valid
    end

    it "is invalid without description" do
      # On the console simulate a producto like this an the cal .erros to see the errors
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("can't be blank")
    end

    # Same code as above but using shouldamatcher methods
    it { should validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:description) }


    it "is invalid without price" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is invalid without category" do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("can't be blank")
    end
  end

  context "Relations" do
    it { should belong_to(:category) }
  end

  context "CInstace methods" do
    it "returns a product with a full description" do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end

end
