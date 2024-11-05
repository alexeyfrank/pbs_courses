class CoursesService
  def create_course(params)
    course = Course.new(params)
    course.skills = find_skills(params)
    course.author = find_author(params)

    course.save
    course.reload
  end

  private

  def find_skills(params)
    Skill.where(slug: params[:skill_slugs]) if params[:skill_slugs]
  end

  def find_author(params)
    if params[:author_id]
      User.find(params[:author_id])
    else
      AuthorFinderService.new.find_author_by_course_skills(params[:skill_slugs])
    end
  end
end
