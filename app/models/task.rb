class Task < ApplicationRecord
  belongs_to :lists

  def self.all_tasks(list_id)
    Task.find_by_sql(
      "SELECT *
      FROM tasks AS t
      WHERE t.list_id = #{list_id}
      ORDER BY t.priority"
    )
  end

  def self.single_task(list_id, task_id)
    Task.find_by_sql(["
      SELECT * 
      FROM tasks AS t
      WHERE t.id = ? AND t.list_id = ?
    ", task_id, list_id]).first
  end

  def self.create_task(p, id)
    Customer.find_by_sql(["
      INSERT INTO tasks (priority, name, body)
      VALUES (:priority, :name, :body);
    ", {
      first: p[:first_name],
      last: p[:last_name],
      email: p[:email],
      phone: p[:phone],
      user_id: id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    }])
  end

end
