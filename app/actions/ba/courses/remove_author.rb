module Ba
  module Courses
    class RemoveAuthor < Base
      attr_accessor :course

      def initialize(id:)
        @course = Course.find(id)
      end

      private

      def perform
        old_author = course.author
        course.author = AuthorService.new \
          .find_author_by_course_skills(course.skills.pluck(:slug), [ old_author.id ])

        course.save

        course
      end
    end
  end
end
