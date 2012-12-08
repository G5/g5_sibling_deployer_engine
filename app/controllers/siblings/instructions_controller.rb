class Siblings::InstructionsController < Siblings::ApplicationController
  def index
    @siblings_instructions = Sibling::Instruction.all
  end
end
