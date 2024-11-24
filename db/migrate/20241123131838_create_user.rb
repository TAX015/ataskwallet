require "./db/migrate/20241123130536_create_abstract"
class CreateUser < CreateAbstract
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :user_type
      t.boolean :is_admin, default: false
    end
    additional_columns(:users)
  end
end
