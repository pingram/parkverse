class Api::SpacesController < ApplicationController
  def search
    address = params[:address]

    base_uri  = "https://maps.googleapis.com/maps/api/geocode/json"
    query     = { address: address, key: Rails.application.config.google_api_key }
    options   = { query: query, verify: false }

    response = HTTParty.get(base_uri, options)

    location = response["results"].first["geometry"]["location"]
    lat = location["lat"]
    lng = location["lng"]

    sql = <<-SQL
      SELECT id, owner_id, ( 3959 * acos( cos( radians( #{lat} ) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians( #{lng} ) ) + sin( radians( #{lat} ) ) * sin( radians( lat ) ) ) ) AS distance
      FROM spaces
      ORDER BY distance;
    SQL

    spaces = Space.find_by_sql(sql)

    render json: spaces
  end
end
