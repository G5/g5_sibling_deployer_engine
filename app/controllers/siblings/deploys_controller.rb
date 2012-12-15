class Siblings::DeploysController < Siblings::ApplicationController
  def index
    @siblings_deploys = Sibling::Deploy.order("created_at DESC")
  end
end
