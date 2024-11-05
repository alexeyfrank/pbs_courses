module Ba
  module Courses
    class Base < BaseAction
      attr_accessor :course

      private

      def find_skills
        Skill.where(slug: attributes[:skill_slugs]) if attributes[:skill_slugs]
      end

      def find_author
        if attributes[:author_id]
          return User.find_by(id: attributes[:author_id])
        end

        if attributes[:skill_slugs]
          AuthorFinderService.new.find_author_by_course_skills(attributes[:skill_slugs])
        else
          nil
        end
      end
    end
  end
end
