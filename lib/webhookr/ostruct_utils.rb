module Webhookr
  # Adapted from http://www.rebeccamiller-webster.com/2012/06/recursively-convert-a-ruby-hash-to-openstruct/
  module OstructUtils

     def self.to_ostruct(obj)
        case
        when obj.kind_of?(Hash)
          return hash_to_ostruct(obj)
        when obj.kind_of?(Array)
          return array_to_ostruct(obj)
        else
          return obj
        end
      end

      def self.hash_to_ostruct(hash)
        hash.each  do |key, val|
          hash[key] = to_ostruct(val)
        end
        OpenStruct.new(hash)
      end

      def self.array_to_ostruct(array)
        array.map { |r| to_ostruct(r) }
      end

  end
end