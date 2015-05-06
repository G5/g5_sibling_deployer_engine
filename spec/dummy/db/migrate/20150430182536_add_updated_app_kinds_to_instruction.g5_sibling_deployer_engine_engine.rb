# This migration comes from g5_sibling_deployer_engine_engine (originally 4)
class AddUpdatedAppKindsToInstruction < ActiveRecord::Migration
  def change
    add_column :sibling_instructions, :updated_app_kinds, :string, array: true, default: []
  end
end
