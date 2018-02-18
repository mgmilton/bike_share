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
    describe '#format_date' do
      it 'formats the installation date' do
        date = Date.new(2013,8,20)
        station = create(:station, installation_date: date)

        expect(station.format_date).to eq('August 20, 2013')
      end
    end
  end
end
