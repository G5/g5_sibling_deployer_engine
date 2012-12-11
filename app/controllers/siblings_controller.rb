class SiblingsController < ApplicationController
   def index
     @siblings = Sibling.all
   end

   def deploy
     @sibling = Sibling.find(params[:id])
     if @sibling.deploy
       redirect_to siblings_deploys_path, notice: "Deploy has been queued."
     else
       redirect_to siblings_deploys_path, alert: "Something went wrong. Deploy has not been queued."
     end
   end
end
