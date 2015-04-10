class CreateArticlesCategories < ActiveRecord::Migration
  def change
    create_table :articles_categories, :id => false do |t|
      t.references :article #same as t.integer :article_id
      t.references :category
    end
  end
end
