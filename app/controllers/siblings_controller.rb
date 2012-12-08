class SiblingsController < ApplicationController
   def index
     @siblings = Siblings.all
   end
end
