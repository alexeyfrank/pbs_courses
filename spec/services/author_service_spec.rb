require 'rails_helper'

RSpec.describe AuthorService do
  describe '#find_author_by_course_skills' do
    let(:author) { create(:user) }
    let(:skills) { create_list(:skill, 2) }

    before do
      create(:course, author:, skills:)
    end

    it 'returns the author with the most matching skills' do
      expect(AuthorService.new.find_author_by_course_skills(skills.map(&:slug), [])).to eq(author)
    end

    it 'returns the author with the least courses if no skills are provided' do
      expect(AuthorService.new.find_author_by_course_skills([], [])).to eq(author)
    end

    it 'excludes the author if an exclude_ids array is provided' do
      expect(AuthorService.new.find_author_by_course_skills(skills.map(&:slug), [ author.id ])).not_to eq(author)
    end

    it 'returns the author with the least courses if no skills are provided' do
      expect(AuthorService.new.find_author_by_course_skills([], [])).to eq(author)
    end
  end
end
