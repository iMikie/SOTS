class AddNameVoiceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :voice, :string

  end
end
