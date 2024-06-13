class PublicJob < ApplicationRecord
  include Ownership
  belongs_to :account
  belongs_to :job
  belongs_to :department, counter_cache: true, optional: true
  belongs_to :job
end
