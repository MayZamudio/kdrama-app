class Drama < ApplicationRecord
  validates :title, presence: true, length: {minimum:5, maximum:100}
  validates :overview, presence: true, length: {minimum:10}

  def self.find_in_tmdb(api_key='cda4f0b6b9f50acb07381d9ef76d2202', title)
      base_url = 'https://api.themoviedb.org/3/search/multi'
      query_params = {
        api_key: api_key,
        query: title,
      }
      puts "query_params: #{query_params}"
      response = Faraday.get(base_url, query_params)
      if response.success?
        result = JSON.parse(response.body)
        dramas_from_tmdb = result['results']
        puts "API Result: #{result}"
        new_dramas = []
        
        dramas_from_tmdb.each do |tmdb_drama|
          next if tmdb_drama['original_language'] == 'en'
          media_type = tmdb_drama['media_type']

          if tmdb_drama['known_for']
            # If the result is an actor, retrieve their known works
            # rails generate migration AddActorNameToDramas actor_name:string
            known_for = tmdb_drama['known_for']
            actor_profile = tmdb_drama['profile_path']
            actor_name = tmdb_drama['name']
            known_for.map do |work|
              new_dramas << create_drama_from_tmdb_data(work, actor_profile, actor_name)
              puts "new_dramas: #{new_dramas}"
            end
          else
            # If the result is a movie or TV show, create a Drama object
            new_dramas << create_drama_from_tmdb_data(tmdb_drama)
          end
        end
        puts "new_dramas: #{new_dramas}"
        existing_drama_titles = Drama.where(title: new_dramas.map { |m| m['title'] }).pluck(:title)
        new_dramas.reject! { |m| existing_drama_titles.include?(m['title']) }
        return new_dramas
      else
        return nil
      end
  end
  def self.create_drama_from_tmdb_data(data, actor_profile = nil, actor_name = nil)
    media_type = data['media_type'] == 'movie' ? 'Movie' : 'Drama'
    Drama.new(
      title: data['title'] || data['name'],
      overview: data['overview'],
      air_date: data['release_date'] || data['first_air_date'],
      country: data['origin_country']&.first,
      media_type: media_type,
      backdrop: data['backdrop_path'],
      poster: data['poster_path'],
      profile_path: actor_profile,
      actor_name: actor_name
    )
  end
end
