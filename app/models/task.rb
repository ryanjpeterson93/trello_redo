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
    Task.find_by_sql(["
      INSERT INTO tasks (priority, name, body, created_at, updated_at)
      VALUES (:priority, :name, :body, :created_at, :updated_at);
    ", {
      priority: p[:priority],
      name: p[:name],
      body: p[:body],
      created_at: DateTime.now,
      updated_at: DateTime.now
    }])
  end

  def self.update_task(task_id, p)
    Task.find_by_sql(["
      UPDATE tasks AS t
      SET priority = ?, name = ?, body = ?, updated_at = ?
      WHERE t.id = ?
    ;", p[:priority], p[:name], p[:body], DateTime.now, task_id])
  end

  def self.delete_task(task_id)
    Task.find_by_sql(["
      DELETE FROM tasks AS t
      WHERE t.id = ?
    ;", task_id])
  end

end
