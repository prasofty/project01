class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :dob
      t.string :email
      t.string :education_degree
      t.string :graduate
      t.integer :year
      t.boolean :is_passed
      t.float :salary
      t.text :about_me
      t.boolean :accept_terms

      t.timestamps
    end
  end
end
