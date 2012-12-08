require 'spec_helper'

describe Sibling do
  describe ".main_app" do
    it "does not return non main apps" do
      sibling = Sibling.create!(main_app: false)
      expect(Sibling.main_app).to be_nil
    end
    it "returns main apps" do
      sibling = Sibling.create!(main_app: true)
      expect(Sibling.main_app).to eq(sibling)
    end
  end
  describe ".not_main_app" do
    it "returns non main apps" do
      sibling = Sibling.create!(main_app: false)
      expect(Sibling.not_main_app).to eq([sibling])
    end
    it "does not return main apps" do
      sibling = Sibling.create!(main_app: true)
      expect(Sibling.not_main_app).to be_empty
    end
  end
end
