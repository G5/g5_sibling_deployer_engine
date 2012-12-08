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
