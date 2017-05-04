class AddFileToImportRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :import_records, :file, :string
  end
end
