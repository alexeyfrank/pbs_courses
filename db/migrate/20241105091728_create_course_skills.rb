class CreateCourseSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :course_skills do |t|
      t.belongs_to :course, null: false, foreign_key: true, index: true
      t.belongs_to :skill, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
