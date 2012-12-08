class Siblings::DeploysController < Siblings::ApplicationController
  def index
    @siblings_deploys = Sibling::Deploy.all
  end
end
