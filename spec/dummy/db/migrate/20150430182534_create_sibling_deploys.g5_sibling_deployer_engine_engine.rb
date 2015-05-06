# This migration comes from g5_sibling_deployer_engine_engine (originally 2)
class CreateSiblingDeploys < ActiveRecord::Migration
  def change
    create_table :sibling_deploys do |t|
      t.references :sibling
      t.references :instruction
      t.boolean :manual
      t.string :state
      t.string :git_repo
      t.string :heroku_repo
      t.string :heroku_app_name

      t.timestamps
    end
  end
end
