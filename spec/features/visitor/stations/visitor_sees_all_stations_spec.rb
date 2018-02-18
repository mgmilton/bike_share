require 'rails_helper'

context 'As a visitor' do
  describe 'When I visit the stations index,' do
    scenario 'I see all stations (name, dock count, city, installation date)' do
      stations = create_list(:station, 3)
      visit stations_path

      stations.each do |station|
        expect(page).to have_content(station.name)
        expect(page).to have_content(station.dock_count)
        expect(page).to have_content(station.city)
        expect(page).to have_content(station.format_date)
      end
    end
  end
end
