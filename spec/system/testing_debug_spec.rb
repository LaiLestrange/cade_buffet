require 'rails_helper'

describe 'testing the debug tool' do
  it 'vamo lá' do
    visit root_path
    expect(current_path).to eq root_path
  end
end
