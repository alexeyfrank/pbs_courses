module Ba
  module Courses
    class Create < Base
      private

      def perform
        @course = Course.new(attributes)
        @course.skills = find_skills
        @course.author = find_author

        @course.save

        @course
      end
    end
  end
end
