require 'rails_helper'

context 'As an admin' do
  describe 'When I visit the stations index, and I click delete next to a station' do
    scenario 'I do not see the station on the index.' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      stations = create_list(:station, 3)

      visit stations_path
      expect(page).to have_content("#{stations.first.name} #{stations.first.city}")

      find(".delete-#{stations.first.id}").click

      expect(page).to_not have_content("#{stations.first.name} #{stations.first.city}")
      expect(page).to have_content("#{stations.first.name} deleted succesfully")
    end
  end
end
