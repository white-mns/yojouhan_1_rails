class AddIndexToName < ActiveRecord::Migration
  def change
    add_index :names, [:e_no, :result_no, :generate_no], :unique => false, :name => 'unique_eno'
    add_index :names, :name
    add_index :names, :nickname
  end
end
