require 'swagger_helper'

RSpec.describe 'api/v1/courses', type: :request do
  path '/api/v1/courses' do
    get('list courses') do
      consumes 'application/json'
      produces 'application/json'
      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/CourseListResponse'

        run_test!
      end
    end

    post('create course') do
      let(:author) { create(:user) }
      let(:skills) { create_list(:skill, 2) }
      let(:course) do
        {
          title: 'Ruby Course',
          description: 'Learn Ruby programming',
          author_id: author.id,
          skill_slugs: skills.map(&:slug)
        }
      end

      consumes 'application/json'
      produces 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          author_id: { type: :integer },
          skill_slugs: {
            type: :array,
            items: { type: :string }
          }
        },
        required: %w[title description]
      }

      response(201, 'created') do
        schema '$ref' => '#/components/schemas/Course'
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/Errors'
        let(:course) { { title: '', description: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show course') do
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/Course'
        let(:id) { create(:course).id }

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end
    end

    put('update course') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          skill_slugs: {
            type: :array,
            items: { type: :string }
          }
        }
      }

      let(:id) { create(:course).id }
      let(:course) do
        {
          title: 'Updated Ruby Course',
          description: 'Updated Ruby course description'
        }
      end

      response(200, 'ok') do
        schema '$ref' => '#/components/schemas/Course'
        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/Errors'
        let(:course) { { title: '', description: '' } }
        run_test!
      end
    end

    delete('delete course') do
      consumes 'application/json'
      produces 'application/json'

      response(204, 'no content') do
        let(:id) { create(:course).id }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end
    end
  end
end
