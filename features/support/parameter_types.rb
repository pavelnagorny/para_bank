# frozen_string_literal: true

ParameterType(
  name: 'variable',
  regexp: /'([^"]*)'/,
  transformer: ->(str) { instance_variable_get("@#{String(str).parameterize(separator: '_').gsub('-', '_')}") }
)

ParameterType(
  name: 'parameter',
  regexp: /'([^"]*)'/,
  transformer: ->(str) { String(str).parameterize(separator: '_').gsub('-', '_') }
)
