class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :full_name
      t.integer :courses_count, default: 0

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
