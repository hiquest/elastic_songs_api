module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :author, type: :text
      indexes :title, type: :text
      indexes :lyrics, type: :text
      indexes :genre, type: :keyword
    end

    def self.search(query)
      params = {
        query: {
          multi_match: {
            query: query, 
            fields: [ :title, :artist, :lyrics ] 
          },
        },
      }

      self.__elasticsearch__.search(params)
    end
  end
end
