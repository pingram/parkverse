class Api::SpacesController < ApplicationController
  def search
    address = params[:address]

    base_uri  = "https://maps.googleapis.com/maps/api/geocode/json"
    query     = { address: address, key: Rails.application.config.google_api_key }
    options   = { query: query, verify: false }

    response = HTTParty.get(base_uri, options)

    render json: response
  end
end
