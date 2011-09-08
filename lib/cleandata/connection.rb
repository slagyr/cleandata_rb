require "cleandata/packing"

module Cleandata

  class Connection

    BATCH_SIZE = 1000

    def initialize(service)
      @service = service
    end

    def rubitize(name)
      name.to_s.gsub("-", "_")
    end

    def clojurize(name)
      name.to_s.gsub("_", "-")
    end

    def to_op(op)
      case op
        when :eq; Java::com.google.appengine.api.datastore.Query::FilterOperator::EQUAL
        when :gt; Java::com.google.appengine.api.datastore.Query::FilterOperator::GREATER_THAN
        when :gte; Java::com.google.appengine.api.datastore.Query::FilterOperator::GREATER_THAN_OR_EQUAL
        when :lt; Java::com.google.appengine.api.datastore.Query::FilterOperator::LESS_THAN
        when :lte; Java::com.google.appengine.api.datastore.Query::FilterOperator::LESS_THAN_OR_EQUAL
        when :neq; Java::com.google.appengine.api.datastore.Query::FilterOperator::NOT_EQUAL
        when :in; Java::com.google.appengine.api.datastore.Query::FilterOperator::IN
        else raise "Unknown operator: #{op}"
      end
    end

    def to_sort_direction(direction)
      case direction
        when :asc; Java::com.google.appengine.api.datastore.Query::SortDirection::ASCENDING
        when :desc; Java::com.google.appengine.api.datastore.Query::SortDirection::DESCENDING
        else raise "Unknown sort direction: #{direction}"
      end
    end

    def unpack_entity(jentity)
      result = DotHash.new
      result[:kind] = jentity.getKind
      result[:key] = jentity.getKey.unpack
      jentity.getProperties.each do |(key, value)|
        result[rubitize(key).to_sym] = value.unpack
      end
      result
    end

    def find_by_kind(kind, options={})
      query = Java::com.google.appengine.api.datastore.Query.new(kind)
      (options[:filters] || []).each do |(field, op, value)|
        query.addFilter(clojurize(field), to_op(op), value)
      end
      (options[:sorts] || []).each do |(field, direction)|
        query.addSort(clojurize(field), to_sort_direction(direction))
      end
      prepared = @service.prepare(query)

      fetch_options = Java::com.google.appengine.api.datastore.FetchOptions::Builder.withPrefetchSize(BATCH_SIZE).chunkSize(BATCH_SIZE)
      fetch_options = fetch_options.limit(options[:limit]) if options[:limit]
      batch = prepared.asList(fetch_options)

      results = []
      batch.each do |e|
        results << unpack_entity(e)
      end
      results
    end

  end

end