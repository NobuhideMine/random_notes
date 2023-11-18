# frozen_string_literal: true

# Your Ruby code goes here

class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :post
end
