class Item < ApplicationRecord
  enum status: %w(active, retired)
  has_attached_file :image,
                    styles: { thumb: ["64x64#", :jpg] }
  validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
