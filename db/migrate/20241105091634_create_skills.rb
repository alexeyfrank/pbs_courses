class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
    add_index :skills, :slug, unique: true
  end
end
