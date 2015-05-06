# This migration comes from g5_sibling_deployer_engine_engine (originally 3)
class CreateSiblingInstructions < ActiveRecord::Migration
  def change
    create_table :sibling_instructions do |t|
      t.string :uid
      t.string :name
      t.datetime :published_at

      t.timestamps
    end
  end
end
