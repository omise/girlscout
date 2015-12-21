module GirlScout
  class Object
    include GirlScout::Concerns::HasAttributes
    include GirlScout::Concerns::HasResource

    class << self
      def has_one(prop_name, options={})
        attr_key = prop_name.to_s
        var_sym = "@#{prop_name}".to_sym

        model_class = options[:as]

        define_method(prop_name) do
          value = instance_variable_get(var_sym)
          return value if value

          attr = self[attr_key]
          return nil unless attr

          value = model_class.new(attr)
          instance_variable_set(var_sym, value)
        end
      end

      def has_many(prop_name, options={})
        attr_key = prop_name.to_s
        var_sym = "@#{prop_name}".to_sym

        model_class, resource_method = options[:as], options[:via]

        case
        when resource_method # build from remote resource
          define_method(prop_name) do
            value = instance_variable_get(var_sym)
            return value if value

            resource = send(resource_method)
            value = List.new(resource.get, model_class)
            instance_variable_set(var_sym, value)
          end

        when model_class # build from existing attributes
          define_method(prop_name) do
            value = instance_variable_get(var_sym)
            return value if value

            value = (self[attr_key] || []).map do |attr|
              model_class.new(attr)
            end

            instance_variable_set(var_sym, value)
          end

        else
          raise 'either as: or resource: option must be specified'

        end
      end
    end

    def initialize(attr={}, options={})
      attr = attr.inject({}) { |h,(k,v)| h[k.to_s] = v; h }
      @attributes = attr
      @resource = options[:resource] if options[:resource]
    end

  end
end
