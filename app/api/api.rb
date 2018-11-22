require 'grape-swagger'
class API < Grape::API
  LIMIT_RESPONSE_LOG = 10_000 # characters

  version 'v1', using: :header, vendor: 'airport'
  prefix 'api'
  format :json

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'

    debug_params
  end

  after do
    Rails.logger.info(body.to_json.truncate(LIMIT_RESPONSE_LOG))
  end

  helpers do
    def permitted_params
      debug_params('PERMITTED PARAMS')
      @permitted_params ||= declared(params, include_missing: false)
    end

    def resource_error!(resource)
      Rails.logger.info(resource.errors.to_json)
      error!({ errors: resource.errors.messages }, 401)
    end

    def debug_params(title='DEBUG PARAMS')
      Rails.logger.info("\n*** #{title} ***")
      begin
        Rails.logger.info(params.to_json)
      rescue
        Rails.logger.info('--- DEBUG PARAMS FAILED ---')
      end
    end
  end

  mount Airport::Flights
  mount Airport::Passengers


  add_swagger_documentation base_path: '/',
                          api_version: 'v1',
                          hide_documentation_path: true,
                          hide_format: true,
                          info: {
                            title: 'Airport API wrapper',
                            description: 'Just some description'
                          }
end
