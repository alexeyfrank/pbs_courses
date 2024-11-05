module Ba
  module Courses
    class Create < Base
      def call
        @course = Course.new(attributes)
        @course.skills = find_skills
        @course.author = find_author

        @course.save

        @course
      end
    end
  end
end
