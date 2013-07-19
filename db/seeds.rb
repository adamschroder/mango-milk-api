require "httparty"
#"8d53fea777a5dc68d816ef22ea508330"
api_key = "083a70b0d0142ec2e57317390f828d95"
seed_file = File.join(Rails.root, "db", "seeds.yml")
shows_list = YAML::load_file(seed_file)

shows_list.each do |title|
  Show.create(title)
end

clean_show_titles = shows_list.inject({}) do |shows_hash, show|
  clean_show_title = show['title'].to_s
  shows_hash[show["title"]] = clean_show_title.gsub(/\s/, "-").gsub(/\'/, '')
  shows_hash
end

clean_show_titles.each do |title, clean_title|

  if show = Show.where(title: title.to_s).first

    show_id = show.id

    response = HTTParty.get("http://api.trakt.tv/show/seasons.json/#{api_key}/#{clean_title}")

    if response.code === 200

      summary = HTTParty.get("http://api.trakt.tv/show/summary.json/#{api_key}/#{clean_title}")

      if summary.code === 200

        puts title

        genres = summary["genres"].to_s
        poster = summary["poster"].to_s
        imdb = summary["imdb_id"].to_s

        puts "genre: #{genres}"
        puts "poster: #{poster}"
        puts "imdb: #{imdb}"

        # we gotta make sure there was a summary, then figure out if it is adding correctly
        show.update_attribute(:genre, genres)
        show.update_attribute(:poster, poster)
        show.update_attribute(:imdb_id, imdb)

        season_count = response.size

        season_count.times do |season_num|

          episodes_response = HTTParty.get("http://api.trakt.tv/show/season.json/#{api_key}/#{clean_title}/#{season_num -1}")

          episodes_response.each do |episode|

            puts "-#{episode["title"].to_s}"
            Episode.create(title: episode["title"].to_s, description:episode["overview"].to_s, air_date:episode["first_aired_utc"], season:episode["season"], number:episode["number"], show_id: show_id.to_s)
          end
        end
      end
    end
  end
end