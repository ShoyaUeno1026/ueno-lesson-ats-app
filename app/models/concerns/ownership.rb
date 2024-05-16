module Ownership
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, class_name: "User", optional: true
  end

  def owner?(user)
    owner_id == user.id
  end
end