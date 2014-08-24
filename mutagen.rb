# require 'active_support/inflector'
# inflectors_path = File.expand_path('./config/initializers/inflections.rb')
# load inflectors_path if File.exist?(inflectors_path)

class Mutagen
  def initialize(path)
    file_match_expression = File.join(File.expand_path(path), '*.rb')
    @source_files = Dir.glob(file_match_expression).map do |file_path|
      SourceFile.new(file_path, path)
    end
  end

  def mutate!
    @source_files.each do |source_file|
      dir_path = source_file.dir_path
      Dir.mkdir(dir_path) unless File.exists?(dir_path)
      source_file.spec_groups.each do |spec_group|
        dir_path = spec_group.dir_path
        Dir.mkdir(dir_path) unless File.exist?(dir_path)
        File.open(spec_group.target_path, 'w') do |file|
          file.write(spec_group.text)
        end
      end
    end
  end
end

class SourceFile
  def initialize(file_path, base_path)
    @file_path = file_path
    @base_path = base_path
  end

  def dir_path
    File.join(@base_path, class_path)
  end

  def class_name
    classify(class_path.split('/').last)
  end

  def classify(string)
    string.split('_').map(&:capitalize).join
  end

  def class_path
    @file_path.match(/#{@base_path}\/(.*)_spec\.rb/).captures.first
  end

  def spec_groups
    @spec_groups = []
    block = ''
    block_started = false
    block_name = ''
    lets = ''
    associations = ''
    validations = ''
    befores = ''

    file_text.lines.each do |line|
      match = line.match(/^  describe '(\S*)' do$/)
      match ||= line.match(/^  describe "(\S*)" do$/)
      next if line.match(/spec_helper/)
      next if line.match(/^end$/)
      if match
        block_name = match.captures.first
        block_name = 'validations' if block_name == '#valid?'
        block_started = true
        next
      elsif !block_started && line.match(/^describe (\S*) do$/)
        next
      elsif !block_started
        if line.match(/^  let/)
          lets << line
        elsif line.match(/(belong_to|have_many|have_one)/)
          associations << line
        elsif line.match(/^  before/)
          befores << line
        else
          fail "leftover text: #{line}" unless line.strip == ''
        end
        next
      elsif !block_started
        next
      end

      if line.match(/^  end$/)
        @spec_groups << SpecGroup.new(block_name, dir_path, class_name, block)
        block = ''
        block_started = false
      else
        line = line[2..-1] || "\n"
        block << line
      end
    end

    if befores.strip != ''
      @spec_groups.each do |spec_group|
        next if %w(associations validations).include?(spec_group.name)
        spec_group.block = "#{befores}\n#{spec_group.block}"
      end
    end

    if lets.strip != ''
      @spec_groups.each do |spec_group|
        next if %w(associations validations).include?(spec_group.name)
        spec_group.block = "#{lets}\n#{spec_group.block}"
      end
    end

    if associations.strip != ''
      assoc_groups = @spec_groups.select { |sg| sg.name == 'associations' }
      fail "too many associations groups" unless assoc_groups.length <= 1
      assoc_group = assoc_groups.first
      if assoc_group
        assoc_group.block = "#{associations}#{assoc_group.block}"
      else
        @spec_groups << SpecGroup.new('associations', dir_path, class_name, associations)
      end
    end

    if validations.strip != ''
      valid_groups = @spec_groups.select { |sg| sg.name == 'validations' }
      fail "too many validations groups" unless valid_groups.length <= 1
      valid_group = valid_groups.first
      if valid_group
        valid_group.block = "#{validations}#{valid_group.block}"
      else
        @spec_groups << SpecGroup.new('validations', dir_path, class_name, validations)
      end
    end

    @spec_groups
  end

private

  def file_text
    File.read(@file_path)
  end
end

class SpecGroup
  attr_accessor :name, :class_name, :base_path, :block

  def initialize(name, base_path, class_name, block)
    fail 'no spaces!' if name.match(/ /)
    @name = name
    @base_path = base_path
    @class_name = class_name
    @block = block
  end

  def target_path
    File.join(dir_path, file_name)
  end

  def dir_path
    [base_path, path_extension].compact.join('/')
  end

  def file_name
    "#{stripped_name}#{modifier}_spec.rb"
  end

  def text
    <<EOF
require 'spec_helper'

describe #{class_name}, '#{name}' do

#{block}
end
EOF
  end

  def path_extension
    'class_methods' if name.match(/^\..*/)
  end

  def stripped_name
    plain_name = name.match(/(\w+)/)
    plain_name && plain_name.captures.first
  end

  def modifier
    case name
    when /<=>/
      'spaceship_operator'
    when /!$/
      '_bang'
    when /\?$/
      '_predicate'
    when /=$/
      '_writer'
    else
      ''
    end
  end

end

mutagen = Mutagen.new('spec/models')
mutagen.mutate!
