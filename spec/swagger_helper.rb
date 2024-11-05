# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          UserListResponse: {
            type: :object,
            properties: {
              users: { type: :array, items: { '$ref' => '#/components/schemas/User' } },
              meta: { '$ref' => '#/components/schemas/ListMeta' }
            }
          },
          ListMeta: {
            type: :object,
            properties: {
              total_count: { type: :integer }
            }
          },
          User: {
            type: :object,
            properties: {
              email: { type: :string },
              full_name: { type: :string },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            }
          },
          Errors: {
            type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    attribute: { type: :string },
                    messages: { type: :array, items: { type: :string } }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml

  config.after(:each, operation: true, use_as_request_example: true) do |spec|
    spec.metadata[:operation][:request_examples] ||= []

    example = {
      value: JSON.parse(request.body.string, symbolize_names: true),
      name: 'request_example_1',
      summary: 'A request example'
    }

    spec.metadata[:operation][:request_examples] << example
  end
end
