# This migration comes from g5_sibling_deployer_engine_engine (originally 1)
class CreateSiblings < ActiveRecord::Migration
  def change
    create_table :siblings do |t|
      t.string :uid
      t.string :name
      t.string :git_repo
      t.string :heroku_repo
      t.string :heroku_app_name
      t.boolean :main_app

      t.timestamps
    end
  end
end
