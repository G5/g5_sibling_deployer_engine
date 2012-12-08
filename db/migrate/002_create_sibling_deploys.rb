class CreateSiblingDeploys < ActiveRecord::Migration
  def change
    create_table :sibling_deploys do |t|
      t.references :sibling_id
      t.references :instruction_id
      t.boolean :manual
      t.string :state
      t.string :git_repo
      t.string :heroku_repo
      t.string :heroku_app_name

      t.timestamps
    end
  end
end
