class AuthorFinderService
  def initialize
  end

  # This method finds the most suitable author for a course based on their expertise with the given skills
  # It ranks authors by how many of the requested skills they have taught in their courses
  # The raw SQL generated is equivalent to:
  #
  # SELECT users.*, COUNT(DISTINCT skills.id) as matching_skills_count
  # FROM users
  # INNER JOIN courses ON courses.author_id = users.id
  # INNER JOIN course_skills ON course_skills.course_id = courses.id
  # INNER JOIN skills ON skills.id = course_skills.skill_id
  # WHERE skills.slug IN (<skill_slugs>)
  # AND users.id NOT IN (<exclude_ids>)
  # GROUP BY users.id
  # ORDER BY matching_skills_count DESC, courses_count ASC
  # LIMIT 1
  #
  # Explanation:
  # if skill_slugs is empty, we return the author with the least courses
  #
  # 1. Joins users -> courses -> skills through the associations
  # 2. Filters to only include skills matching the provided slugs
  # 3. Excludes users with ids in the exclude_ids array (optional, needed if we want to exclude some authors)
  # 4. Groups by user to count skills per user
  # 5. Orders first by number of matching skills (DESC) to get authors with most expertise
  # 6. Then orders by total courses_count as a tiebreaker
  # 7. Returns the single best match
  def find_author_by_course_skills(skill_slugs = [], exclude_ids = [])
    if skill_slugs.empty?
      return User.order("courses_count ASC").first
    end

    User.joins(courses: :skills)
      .where(skills: { slug: skill_slugs })
      .where.not(id: exclude_ids)
      .group("users.id")
      .order("COUNT(DISTINCT skills.id) DESC, courses_count ASC")
      .first
  end
end
