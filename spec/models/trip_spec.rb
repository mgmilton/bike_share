require "rails_helper"

describe Trip do
  before(:each) do
    station = create(:station)
    allow_any_instance_of(Trip).to receive(:station).and_return(station)
  end
  describe "validations" do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :start_station_id }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :end_station_id }
    it { should validate_presence_of :bike_id }
    it { should validate_presence_of :subscription_type }
  end
end
