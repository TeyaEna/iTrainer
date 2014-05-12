class CreateTableMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.string :subject
      t.text :body
    end
  end
end
