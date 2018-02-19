require 'rails_helper'

context 'As a registered user and admin' do
  describe"When I visit '/stations-dashboard'" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    scenario 'I see the Total count of stations' do
      stations = create_list(:station, 5)

      visit '/stations-dashboard'

      expect(page).to have_content("Stations: #{stations.count}")
    end
  end
end

# I see the Average bikes available per station (based on docks),
# I see the Most bikes available at a station (based on docks),
# I see the Station(s) where the most bikes are available (based on docks),
# I see the Fewest bikes available at a station (based on docks),
# I see the Station(s) where the fewest bikes are available (based on docks),
# I see the Most recently installed station,
# I also see the Oldest station.
