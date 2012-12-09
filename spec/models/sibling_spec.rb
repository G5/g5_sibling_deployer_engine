require 'spec_helper'

describe Sibling do
  before :each do
    stub_const("Sibling::MAIN_APP_UID", "spec/support/main_app.html")
  end

  describe ".microformat_app" do
    it "is a e-g5-app" do
    end
  end

  describe ".consume" do
    it "creates main app" do
    end
    it "creates sibling apps" do
    end
  end

  describe ".find_or_create_from_microformat" do
    it "finds Sibling if it already exists" do
    end
    it "creates Sibling if it does not already exist" do
    end
  end

  describe ".deploy_all" do
    it "does not deploy the main app" do
    end
    it "does deploy apps that are not the main app" do
    end
  end

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

  describe "#deploy" do
    it "raises error if called on main_app" do
    end
    it "creates manual deploys when instruction is not present" do
    end
    it "creates automatic deploys when instruction is present" do
    end
  end
end
