require "httparty"

api_key = "8d53fea777a5dc68d816ef22ea508330"
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

      puts title

      summary = HTTParty.get("http://api.trakt.tv/show/summary.json/#{api_key}/#{clean_title}")

      # we gotta make sure there was a summary, then figure out if it is adding correctly
      Show.where(id: show_id).update_attribute(:genre summary["genres"], :poster summary["poster"], :imdb_id summary["imdb_id"])

      puts Show.where(id: show_id)
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