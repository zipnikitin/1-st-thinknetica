# frozen_string_literal: true

module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      define_method('collect_values'.to_sym) { instance_variable_get('@collect_values'.to_sym) }
      define_method('collect_values='.to_sym) { instance_variable_set('@collect_values'.to_sym, {}) }
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name); @collect_values ||= {}; @collect_values[name] = [] }
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
      self.params_hash = { 'name' => name, 'types' => type_check, 'specials' => specifics }
      self.params ||= []
      self.params.append(params_hash)
    end
  end

  module InstanceMethods
    def validate!
      self.class.params.each do |param|
        send param['types'].to_sym, instance_variable_get("@#{param['name']}".to_sym), param['specials']
      end
    end

    def type(value, specifics)
      raise 'Некорректный тип атрибута' if value.class != specifics
    end

    def presence(value, _specifics)
      raise 'Значение атрибута не может быть nil и должно быть заполнено' if value.nil? || value == ''
    end

    def format(value, specifics)
      raise 'Некорректный формат' if value !~ specifics
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
