require 'spec_helper'

describe "routing" do
  it "routes GET /siblings to siblings#index" do
    expect(get: "/siblings").to route_to(
      controller: "siblings",
      action: "index",
    )
  end

  it "routes GET /siblings/deploys to siblings/deploys#index" do
    expect(get: "/siblings/deploys").to route_to(
      controller: "siblings/deploys",
      action: "index",
    )
  end

  it "routes GET /siblings/instructions to siblings/instructions#index" do
    expect(get: "/siblings/instructions").to route_to(
      controller: "siblings/instructions",
      action: "index",
    )
  end

  it "routes POST /webhooks/g5-configurator to webhooks#g5_configurator" do
    expect(post: "/webhooks/g5-configurator").to route_to(
      controller: "webhooks",
      action: "g5_configurator",
    )
  end
end
