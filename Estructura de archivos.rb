# app/services/ai/sentiment_analyzer.rb
# Extensión: .rb
module Ai
  class SentimentAnalyzer
    def self.call(text)
      client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "user", content: "Analiza el sentimiento de este texto y responde SOLO con una palabra: Positivo, Negativo o Neutral. Texto: #{text}" }]
        }
      )
      response.dig("choices", 0, "message", "content")
    end
  end
end