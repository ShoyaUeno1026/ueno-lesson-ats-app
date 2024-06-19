class AddColumnJobIdToCandidate < ActiveRecord::Migration[7.1]
  def change
    add_reference :candidates, :job, foreign_key: true 
  end
end
