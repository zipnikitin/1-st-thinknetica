# frozen_string_literal: true

module AdjustBrand
  attr_accessor :brand
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :counter

    def instances
      self.counter ||= 0
      self.counter
    end
  end

  module InstanceMethods
    def register_instance
      self.class.counter ||= 0
      self.class.counter += 1
    end
  end
end

module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name); @collect_values[name] = [] }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @collect_values[name].append(value)
        end
        define_method("#{name}_history") { @collect_values[name] }
      end
    end

    def strong_attr_accessor(name, class_check)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        if value.instance_of?(class_check)
          instance_variable_set(var_name, value)
        else
          raise 'Неправильные типы аргументов в операции присвоения значения переменной'
        end
      end
    end
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :params_hash, :params

    def validate(name, type_check, specifics = 0)
      self.params_hash = {}
      self.params_hash = { ['name'] => name, ['types'] => type_check, ['specials'] => specifics }
      self.params ||= []
      self.params.append(params_hash)
    end
  end

  module InstanceMethods
    def validate!
      self.class.params.each do |param|
        type if param['types'] == :type
        presence if param['types'] == :presence
        form if param['types'] == :format
      end
    end

    def type
      if @collect_values[param['name']][-1].class != param['specials']
        print 'Неправильная переменная '
        puts param['name']
        raise 'Некорректный тип атрибута'
      end
    end

    def presence
      if @collect_values[param['name']][0].nil?
        print 'Неправильная переменная '
        puts param['name']
        raise 'Nil не может быть значением атрибута'
      end
      if @collect_values[param['name']][0] == ''
        print 'Неправильная переменная '
        puts param['name']
        raise 'Значение атрибута должно быть заполнено'
      end
    end

    def form
      if @collect_values[param['name']][-1] !~ param['specials']
        print 'Неправильная переменная '
        puts param['name']
        raise 'Некорректный формат'
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
