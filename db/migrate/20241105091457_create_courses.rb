class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }, index: true
      t.text :title
      t.text :description

      t.timestamps
    end
  end
end
