# frozen_string_literal: true

class ChatgptService
  include HTTParty
  attr_reader :api_url, :options, :query

  def initialize(query)
    @query = query
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => 'Bearer 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'
      }
    }
  end

  def call
    body = {
      model: 'gpt-3.5-turbo', # Model can be change
      messages: [{ role: 'user', content: query }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end
end
