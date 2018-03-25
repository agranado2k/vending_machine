require 'rspec_helper'

describe Cleo::ChangeCalculator do
  subject { described_class.new(vm_changes) }
  let(:ui) { double('UserInterface') }
  let(:io) { double('IOInterface') }
  let(:vm_changes) { Cleo::VendingMachine.new(ui, io).init.changes }

  context 'when the change is 1x£1' do
    let(:change_value) { Money.new(100, Cleo::CURRENCY) }
    let(:changes) { ['1x£1'] }

    it { expect(subject.calculate_changes(change_value)).to eq(changes) }
  end

  context 'when the change is 1x10p and 1x5p' do
    let(:change_value) { Money.new(15, Cleo::CURRENCY) }
    let(:changes) { ['1x10p', '1x5p'] }

    it { expect(subject.calculate_changes(change_value)).to eq(changes) }
  end

  context 'when the change is 2x£2 and 1x10p' do
    let(:change_value) { Money.new(410, Cleo::CURRENCY) }
    let(:changes) { ['2x£2', '1x10p'] }

    it { expect(subject.calculate_changes(change_value)).to eq(changes) }
  end

  context 'when there is no one type of change has get the next one' do
    before { vm_changes[10].quantity = 0 }

    context 'when the change is 2x£2 and 2x5p' do
    let(:change_value) { Money.new(410, Cleo::CURRENCY) }
      let(:changes) { ['2x£2', '2x5p'] }

      it { expect(subject.calculate_changes(change_value)).to eq(changes) }
    end
  end
end
