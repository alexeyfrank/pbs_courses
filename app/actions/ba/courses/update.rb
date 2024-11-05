module Ba
  module Courses
    class Update < Base
      def call
        @course = Course.find(attributes[:id])
        @course.assign_attributes(attributes.except(:id))
        @course.skills = find_skills
        @course.author = find_author
        @course.save

        @course
      end
    end
  end
end
