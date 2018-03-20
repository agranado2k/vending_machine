require 'rspec_helper'

shared_examples "a loadable object" do |items|
  context 'when load products' do
    subject { described_class.load }

    it { expect(subject.keys.size).to eq(items) }
  end
end
