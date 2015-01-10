class AddTagTables < ActiveRecord::Migration
   class Post < ActiveRecord::Base; end
   class Tag < ActiveRecord::Base
      attr_accessible :name
   end
   class ItemTag < ActiveRecord::Base
      attr_accessible :item, :tag
      belongs_to :tag
      belongs_to :item, polymorphic: true
   end

   def up
      create_table :tags do |t|
         t.string :name
         t.timestamps
      end

      create_table :item_tags do |t|
         t.integer :item_id
         t.string :item_type
         t.integer :tag_id
      end

      Post.find_each do |post|
         Array(post.tags).each do |tag|
            tag_record = Tag.create!(name: tag.to_s)
            ItemTag.create!(item: post, tag: tag_record)
         end
      end
      remove_column :posts, :tags
   end

   def down
      raise ActiveRecord::IrreversibleMigration, "Cannot be reversed"
   end
end
