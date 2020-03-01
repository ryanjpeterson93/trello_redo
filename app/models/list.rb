class List < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  def self.all_lists(board_id)
    List.find_by_sql(
      "SELECT *
      FROM list AS l
      WHERE l.board_id = #{board_id}"
    )
  end

  def self.single_list(board_id, list_id)
    List.find_by_sql(["
      SELECT * 
      FROM list AS l
      WHERE l.id = ? AND c.board_id = ?
    ", list_id, board_id]).first
  end
end
 