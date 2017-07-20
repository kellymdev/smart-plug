require 'rails_helper'

RSpec.describe Reading, type: :model do
  let(:date_time) { DateTime.parse('19/5/2017 03:04:50') }
  let(:consumption) { 11 }
  let(:temperature) { 40 }
  let(:reading) { Reading.new(date_time: date_time, consumption: consumption, temperature: temperature) }

  describe 'validations' do
    context 'date_time' do
      context 'with the date_time populated' do
        let(:date_time) { DateTime.parse('19/5/2017 03:04:50') }

        it 'is valid' do
          expect(reading).to be_valid
        end
      end

      context 'without a date_time' do
        let(:date_time) { }

        it 'is not valid' do
          expect(reading).not_to be_valid
        end
      end
    end

    context 'consumption' do
      context 'with the consumption populated' do
        let(:consumption) { 11 }

        it 'is valid' do
          expect(reading).to be_valid
        end
      end

      context 'without a consumption value' do
        let(:consumption) { }

        it 'is not valid' do
          expect(reading).not_to be_valid
        end
      end
    end
  end
end
