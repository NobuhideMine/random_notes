# frozen_string_literal: true

# Your Ruby code goes here

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true, null: false
      t.integer :action_type, null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
