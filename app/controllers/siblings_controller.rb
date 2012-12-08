class SiblingsController < ApplicationController
   def index
     @siblings = Sibling.all
   end
end
