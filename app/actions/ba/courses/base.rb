module Ba
  module Courses
    class Base < BaseAction
      attr_accessor :course

      private

      def find_skills
        if attributes[:skill_slugs]
          Skill.where(slug: attributes[:skill_slugs])
        else
          []
        end
      end

      def find_author
        if attributes[:author_id]
          return User.find_by(id: attributes[:author_id])
        end

        if attributes[:skill_slugs]
          AuthorService.new.find_author_by_course_skills(attributes[:skill_slugs])
        end

        course.author
      end
    end
  end
end
