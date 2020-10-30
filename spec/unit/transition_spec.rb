# frozen_string_literal: true

require_relative '../spec_helper'

describe GenericStateMachine::Transition do
  context 'Object creation' do
    it 'Creates a transition' do
      expect { GenericStateMachine::Transition.new(:from_state, :to_state) }.to_not raise_error
    end
  end

  context 'Properties' do
    let(:transition) do
      GenericStateMachine::Transition.new(:from_state, :to_state)
    end

    it 'has #from property' do
      expect(transition.respond_to?(:from)).to be_truthy
    end

    it 'has #to property' do
      expect(transition.respond_to?(:to)).to be_truthy
    end

    it 'has #condition property' do
      expect(transition.respond_to?(:condition)).to be_truthy
    end
  end
end
