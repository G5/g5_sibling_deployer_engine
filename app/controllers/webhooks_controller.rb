class WebhooksController < ApplicationController
  def g5_configurator
    Sibling::Instruction.async_consume_feed
    render json: {}, status: :ok
  end
end
