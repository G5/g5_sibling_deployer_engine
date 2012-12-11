class Siblings::InstructionsController < Siblings::ApplicationController
  def index
    @siblings_instructions = Sibling::Instruction.order("created_at DESC").all
  end
end
