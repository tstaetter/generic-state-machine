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
      expect do
        factory.create start: nil, transitions: [], hooks: []
      end.to raise_error GenericStateMachine::Errors::GenericStateMachineError,
                         "Can't create state machine w/o starting state"
    end

    it "can't create a GSM w/o transitions" do
      expect do
        factory.create start: :some_start, transitions: [], hooks: []
      end.to raise_error GenericStateMachine::Errors::GenericStateMachineError,
                         "Can't create state machine w/o transitions"
    end

    it 'can create a valid GSM' do
      t = GenericStateMachine::Transition.new :from_state, :to_state

      expect { factory.create start: :from_state, transitions: [t] }.to_not raise_error
    end
  end

  context 'Validation' do
    it 'validates start state' do
      t = GenericStateMachine::Transition.new :from_state, :to_state
      transitions = [t]

      expect do
        GenericStateMachine::StateMachineFactory.send :_validate_start_state, :from_state, transitions
      end.to_not raise_error
    end

    it "doesn't accept not valid start state" do
      t = GenericStateMachine::Transition.new :from_state, :to_state
      transitions = [t]

      expect do
        GenericStateMachine::StateMachineFactory.send :_validate_start_state, :some_state, transitions
      end.to raise_error GenericStateMachine::Errors::GenericStateMachineError
    end

    it 'accepts valid array of transitions' do
      t = GenericStateMachine::Transition.new :from_state, :to_state
      transitions = [t]

      expect do
        GenericStateMachine::StateMachineFactory.send :_validate_transitions, transitions
      end.to_not raise_error
    end

    it "doesn't accept empty array transitions" do
      expect do
        GenericStateMachine::StateMachineFactory.send :_validate_transitions, []
      end.to raise_error GenericStateMachine::Errors::GenericStateMachineError
    end

    it "doesn't accept none transition objects" do
      expect do
        GenericStateMachine::StateMachineFactory.send :_validate_transitions, %i[foo bar]
      end.to raise_error GenericStateMachine::Errors::GenericStateMachineError
    end

    it 'only accepts valid hooks' do
      h = GenericStateMachine::Hook.new :foo, -> {}, -> {}
      hooks = [h]

      expect do
        GenericStateMachine::StateMachineFactory.send :_validate_hooks, hooks
      end.to_not raise_error
    end
  end
end
