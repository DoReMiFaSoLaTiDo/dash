class RenameNameToFirstName < ActiveRecord::Migration
  def change
    rename_column :doctors, :name, :first_name
  end
end
