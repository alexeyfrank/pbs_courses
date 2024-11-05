require 'swagger_helper'

RSpec.describe 'api/v1/skills', type: :request do
  path '/api/v1/skills' do
    get('list skills') do
      consumes 'application/json'
      produces 'application/json'
      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/SkillListResponse'

        run_test!
      end
    end

    post('create skill') do
      let(:skill) { { name: 'Ruby', slug: 'ruby' } }

      consumes 'application/json'
      produces 'application/json'

      parameter name: :skill, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          slug: { type: :string }
        },
        required: %w[name slug]
      }

      response(201, 'created') do
        schema '$ref' => '#/components/schemas/Skill'
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/Errors'
        let(:skill) { { name: '', slug: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/skills/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show skill') do
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/Skill'
        let(:id) { create(:skill).id }

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end
    end

    put('update skill') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :skill, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          slug: { type: :string }
        },
        required: %w[name slug]
      }

      let(:id) { create(:skill).id }
      let(:skill) { { name: 'Updated Ruby', slug: 'updated-ruby' } }

      response(200, 'ok') do
        schema '$ref' => '#/components/schemas/Skill'
        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/Errors'
        let(:skill) { { name: '', slug: '' } }
        run_test!
      end
    end

    delete('delete skill') do
      consumes 'application/json'
      produces 'application/json'

      response(204, 'no content') do
        let(:id) { create(:skill).id }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end
    end
  end
end
