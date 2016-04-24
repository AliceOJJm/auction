# == Schema Information
#
# Table name: songs
#
#  id              :integer          not null, primary key
#  url             :string(255)
#  user_id         :integer
#  title           :string(255)
#  performer       :string(255)
#  genre           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  metadata        :text(65535)
#  attachable_id   :integer
#  attachable_type :string(255)
#  owners          :integer          default("1")
#  likers_count    :integer          default("0")
#

require 'elasticsearch/model'

class Song < ActiveRecord::Base
  include Elasticsearch::Model
  
  before_create :extract_metadata
  serialize :metadata
  
  has_and_belongs_to_many :users
  belongs_to :attachable, polymorphic: true
  
  has_attached_file :file

  validates_attachment :file, :content_type => { :content_type => /\Aaudio\/.*\Z/},
                              :size => { :less_than => 20.megabytes }
  acts_as_taggable
  acts_as_likeable
  
  #searchable do
  #  text :title, :performer, boost: 5.0
  #  text :genre
  #end
  
  def self.fulltext_search search_by
  #  Song.search{fulltext search_by}.results
     response = Song.search search_by
    response.results.map{|result| result._source}
  end
  
  private
  
  def extract_metadata
    path = file.queued_for_write[:original].path
    open_opts = { :encoding => 'utf-8' }
    Mp3Info.open(path, open_opts) do |mp3info|
      self.metadata = mp3info.tag
    end
  end

end
