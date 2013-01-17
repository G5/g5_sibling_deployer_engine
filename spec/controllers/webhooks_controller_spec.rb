require File.dirname(__FILE__) + '/../spec_helper'

describe WebhooksController do
  describe "#g5_configurator" do
    before do
      Sibling::Instruction.stub(:async_consume_feed).and_return(true)
    end
    it "queues feed consumption" do
      Sibling::Instruction.should_receive(:async_consume_feed).once
      post :g5_configurator
    end
  end
end
