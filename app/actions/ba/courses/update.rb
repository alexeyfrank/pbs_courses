module Ba
  module Courses
    class Update < Base
      attr_accessor :course

      def initialize(id:)
        @course = Course.find(id)
      end

      private

      def perform
        course.assign_attributes(attributes.except(:id))
        course.skills = find_skills
        course.author = find_author
        course.save

        course
      end
    end
  end
end
