require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get('list users') do
      consumes 'application/json'
      produces 'application/json'
      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/UserListResponse'

        run_test!
      end
    end

    post('create user') do
      let(:user) { { email: 'test@example.com', full_name: 'John Doe' } }

      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          full_name: { type: :string }
        },
        required: %w[email full_name]
      }

      response(201, 'created') do
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/Errors'
        let(:user) { { email: '', full_name: '' } }

        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/User'
        let(:id) { create(:user).id }

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }

        run_test!
      end
    end

    put('update user') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          full_name: { type: :string }
        },
        required: %w[email full_name]
      }

      let(:id) { create(:user).id }
      let(:user) { { email: 'test@example.com', full_name: 'John Doe' } }

      response(200, 'ok') do
        schema '$ref' => '#/components/schemas/User'

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/Errors'
        let(:user) { { email: '', full_name: '' } }
        run_test!
      end
    end

    delete('delete user') do
      consumes 'application/json'
      produces 'application/json'

      response(204, 'no content') do
        let(:id) { create(:user).id }

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '123' }
        run_test!
      end
    end
  end
end
