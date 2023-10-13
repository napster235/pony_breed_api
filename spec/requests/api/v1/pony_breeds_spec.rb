# frozen_string_literal: true

require 'rails_helper'
require 'pony/breeds/read_pony_data'

RSpec.describe 'pony_breeds', type: :request do
  describe '#random_pony' do
    subject { get random_pony_path }

    context 'when retrieving a random pony' do
      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'has a populated body' do
        subject
        expect(response.body).not_to be_nil
      end

      it 'has the correct format' do
        subject
        expect(JSON.parse(response.body).keys).to eq(%w[name description wiki_url])
      end
    end

    context 'when there is no pony available' do
      before do
        allow(Pony::Breeds::ReadPonyData).to receive(:retrieve_random_pony).and_return(nil)
      end

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'should render a message' do
        subject
        expect(response.body).to eq('No pony data available')
      end
    end
  end

  describe '#pony_by_name' do
    context 'when retrieving a pony by an existing name' do
      subject { get pony_by_name_path, params: { name: 'Bali pony' } }
      # rubocop:disable Layout/LineLength
      let(:bali_pony) do
        {
          'name' => 'Bali Pony',
          'description' => 'The Bali ponies are quite hardy and self-sufficient, surviving with little outside care. They are tough animals that are not shod and are remarkably sound, with hard feet, and strong legs. The ponies show the usual "primitive markings" such as a dorsal stripe, shoulder bars, and zebra stripes on the legs, in addition to their dun coat, that includes a black mane, tail, and legs.',
          'wiki_url' => 'https://en.wikipedia.org/wiki/Bali Pony'
        }
      end
      # rubocop:enable Layout/LineLength

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns a json response' do
        subject
        expect(response.body).to eq(bali_pony.to_json)
      end

      it 'has the correct format' do
        subject
        expect(JSON.parse(response.body).keys).to eq(%w[name description wiki_url])
      end
    end

    context 'when retrieving a pony by a non existing name' do
      subject { get pony_by_name_path, params: { name: 'Test' } }
      let(:message) { "No data available for the following name: 'Test'" }

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns an empty response' do
        subject
        expect(response.body).to eq(message)
      end
    end
  end

  describe '#pony_by_key' do
    context 'when retrieving a pony by an existing key' do
      subject { get pony_by_key_path, params: { key: 'bali_pony' } }
      # rubocop:disable Layout/LineLength
      let(:bali_pony) do
        {
          'name' => 'Bali Pony',
          'description' => 'The Bali ponies are quite hardy and self-sufficient, surviving with little outside care. They are tough animals that are not shod and are remarkably sound, with hard feet, and strong legs. The ponies show the usual "primitive markings" such as a dorsal stripe, shoulder bars, and zebra stripes on the legs, in addition to their dun coat, that includes a black mane, tail, and legs.',
          'wiki_url' => 'https://en.wikipedia.org/wiki/Bali Pony'
        }
      end
      # rubocop:enable Layout/LineLength

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns a json response' do
        subject
        expect(response.body).to eq(bali_pony.to_json)
      end

      it 'has the correct format' do
        subject
        expect(JSON.parse(response.body).keys).to eq(%w[name description wiki_url])
      end
    end

    context 'when retrieving a pony by a non existing key' do
      subject { get pony_by_key_path, params: { key: 'Test' } }
      let(:message) { "No data available for the following key: 'Test'" }

      it 'returns a 200 OK status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns an empty response' do
        subject
        expect(response.body).to eq(message)
      end
    end
  end
end
