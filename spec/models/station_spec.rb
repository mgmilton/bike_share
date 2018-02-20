require 'rails_helper'

describe Station, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
  end

  context 'uniqueness' do
    it { should validate_uniqueness_of :name }
  end

  context 'instance methods' do
    describe '#zip_code' do

    end
  end

  context 'class methods' do
    before(:each) do
      create(:station, dock_count: 20)
      create(:station, dock_count: 10)
      create(:station, dock_count: 30)
    end

    describe '.average_bikes' do
      it 'returns the average bikes for all stations' do
        expect(Station.average_bikes).to eq(20)
      end
    end

    describe '.most_bikes_available' do
      it 'returns the highest dock count of all stations' do
        expect(Station.most_bikes_available).to eq(30)
      end
    end
  end
end
