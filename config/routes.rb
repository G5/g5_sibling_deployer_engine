Rails.application.routes.draw do
  resources :siblings, only: [:index] do
    member do
      post "deploy"
    end
  end

  get "siblings/instructions" => "siblings/instructions#index", as: :siblings_instructions
  get "siblings/deploys" => "siblings/deploys#index", as: :siblings_deploys

  post "webhooks/g5-configurator" => "webhooks#g5_configurator", as: :g5_configurator_webhook
end
