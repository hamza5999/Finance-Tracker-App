class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker , presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client_api[:publishable_key],
      secret_token: Rails.application.credentials.iex_client_api[:secret_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_existence(ticker_symbol)
    where(ticker: ticker_symbol).first #same as of Stock.where(ticker: ticker_symbol).first
  end
end
