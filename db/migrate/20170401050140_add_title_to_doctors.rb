class AddTitleToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :title, :string, default: 'Dr.'
    add_column :doctors, :last_name, :string
  end
end
