class ChangeTtbbLengthLimit < ActiveRecord::Migration
  def change
    change_column :songs, :voicing, :string, :limit => 64
  end
end
