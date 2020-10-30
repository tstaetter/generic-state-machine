# frozen_string_literal: true

require_relative '../spec_helper'

describe GenericStateMachine::StateMachineFactory do
  context 'Object creation' do
    it 'Creates a factory' do
      expect { GenericStateMachine::StateMachineFactory.new }.to_not raise_error
    end
  end

  context 'State machine creation' do
    let(:factory) do
      GenericStateMachine::StateMachineFactory
    end

    it "can't create a GSM w/o starting state" do
      expect {
        factory.create start: nil, transitions: [], hooks: []
      }.to raise_error GenericStateMachine::Errors::GenericStateMachineError,
                       "Can't create state machine w/o starting state"
    end

    it "can't create a GSM w/o transitions" do
      expect {
        factory.create start: :some_start, transitions: [], hooks: []
      }.to raise_error GenericStateMachine::Errors::GenericStateMachineError,
                       "Can't create state machine w/o transitions"
    end

    it 'can create a valid GSM' do
      t = GenericStateMachine::Transition.new :from_state, :to_state

      expect { factory.create start: :from_state, transitions: [t] }.to_not raise_error
    end
  end
end
