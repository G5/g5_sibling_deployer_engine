class WebhooksController < ApplicationController
  def g5_configurator
    sibling_deploy = SiblingDeploy.new(manual: true)
    if sibling_deploy.save
      render json: {}, status: :ok
    else
      render json: sibling_deploy.errors, status: :bad_request
    end
  end
end
