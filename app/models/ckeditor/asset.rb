class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip

  def self.extended(base)
    base.class_eval do
      self.table_name = 'ckeditor_assets'

      belongs_to :assetable, polymorphic: true, optional: true
    end
  end
end
