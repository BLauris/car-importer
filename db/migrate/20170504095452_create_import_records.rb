class CreateImportRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :import_records do |t|
      t.timestamps
    end
  end
end
