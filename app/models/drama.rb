class Drama < ApplicationRecord
    validates :title, presence: true, length: {minimum:5, maximum:50}
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
            new_dramas << Drama.new(
                title: media_type == 'movie' ? tmdb_drama['title'] : tmdb_drama['name'],
                overview: tmdb_drama['overview'],
                air_date: media_type == 'movie' ? tmdb_drama['release_date'] : tmdb_drama['first_air_date'],
                backdrop: tmdb_drama['backdrop_path'],
                poster: tmdb_drama['poster_path']
              )
            puts "new_dramas: #{new_dramas}"
          end
          existing_drama_titles = Drama.where(title: new_dramas.map { |m| m['title'] }).pluck(:title)
          new_dramas.reject! { |m| existing_drama_titles.include?(m['title']) }
          return new_dramas
        else
          return nil
        end
    end
end
