# frozen_string_literal: true

require 'yaml'

# Module for serializing game
module Serializable
  SERIALIZER = YAML

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end

    SERIALIZER.dump obj
  end

  def unserialize(string)
    obj = SERIALIZER.unsafe_load(string)
    obj.each_key do |key|
      instance_variable_set(key, obj[key])
    end
  end

  def save_game_data(serialized_game)
    Dir.mkdir('save_data') unless Dir.exist?('save_data')

    filename = 'save_data/game_data.yml'

    File.open(filename, 'w') do |file|
      file.puts serialized_game
    end
  end
end
