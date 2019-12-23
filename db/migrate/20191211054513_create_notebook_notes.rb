class CreateNotebookNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notebook_notes do |t|
      t.integer :notebook_id
      t.integer :note_id

      t.timestamps
    end
  end
end
