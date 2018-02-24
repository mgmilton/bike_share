class Item < ApplicationRecord
  before_save :generate_slug
  enum status: %w(active, retired)
  has_attached_file :image,
                    styles: { thumb: ['64x64#', :jpg],
                              original: ['500x500>', :jpg] },
                    convert_options: { thumb: '-quality 75 -strip',
                                       original: '-quality 85 -strip' },
                    storage: :s3,
                    s3_credentials: {access_key_id: ENV["AWS_KEY"], secret_access_key: ENV["AWS_SECRET"]},
                    bucket: "accessory-image"
  validates_attachment :image,
                     content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }
  validates_presence_of :title, :description, :price
  validates_uniqueness_of :title
  validates_numericality_of :price

  def generate_slug
    self.slug = self.title.parameterize
  end
end
