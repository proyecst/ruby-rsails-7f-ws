# app/services/crypto/price_fetcher_service.rb
module Crypto
  class PriceFetcherService
    def initialize(symbol)
      @symbol = symbol.upcase
      @cache_key = "crypto_price_#{@symbol}"
    end

    def call
      # Intentamos obtener el precio de Redis primero
      cached_price = $redis.get(@cache_key)
      return JSON.parse(cached_price) if cached_price

      # Si no está en caché, consultamos la API (Ej: CoinGecko)
      response = Faraday.get("https://api.coingecko.com/api/v3/simple/price?ids=#{@symbol}&vs_currencies=usd")
      
      if response.success?
        price_data = JSON.parse(response.body)
        # Guardamos en Redis por 60 segundos
        $redis.setex(@cache_key, 60, price_data.to_json)
        return price_data
      end
      
      { error: "Servicio no disponible" }
    end
  end
end