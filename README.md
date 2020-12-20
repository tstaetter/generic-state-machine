[![Maintainability](https://api.codeclimate.com/v1/badges/4e0a58444fff831e22c1/maintainability)](https://codeclimate.com/github/tstaetter/generic-state-machine/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/4e0a58444fff831e22c1/test_coverage)](https://codeclimate.com/github/tstaetter/generic-state-machine/test_coverage)

# Generic state machine

Generic state machine provides the possibility to create simple state machines.
Use them for any purpose, e.g. order objects in your store.
The gem provides a DSL for easy creation of state machines.

## Transitions

A transition is the act of changing the state machines' current state. They are always
defined using a 'from' and a 'to' state. After performing the transition, the state
machine will have the state defined in the transitions 'to' field.

***NOTE:*** Each state machine needs a starting state having a transition available for it, otherwise
nothing will happen when trying to switch the state. 

## Hooks

Hooks can be used to react on a transition event. Currently the following hooks 
are available:

```ruby
:before_transition, :after_transition, :end_reached
```

ATM, 
```ruby
:end_reached
```
is available, but not in use. Using #register, you can register a handler which will
be called on the corresponding hook w/o any parameters.

## Examples

### DSL

```ruby
GenericStateMachine.describe do
  # Add a transition
  transition from: :state, to: :state
  # Add a hook
  register hook: :before_transition, handler: proc { puts 'do something' }
  # Set the starting state
  start from: :some_state
end
```

## Roadmap

* Add hooks per state (e.g. :after_transition_start_state)
* Add possibility to freeze the complete state machine (except #current)