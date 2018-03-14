require 'rspec_helper'

describe Cleo::Product do
  context 'when create' do
    it { expect(subject.name).to eq(params[:name]) }
    it { expect(subject.price).to eq(params[:price]) }
    it { expect(subject.quantity).to eq(params[:quantity]) }
  end
end
