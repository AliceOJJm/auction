# == Schema Information
#
# Table name: dialogues
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dialogue < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages
  def self.create_chat(user1, user2)
    dialogue = Dialogue.new
    dialogue.users << user1
    dialogue.users << user2
    dialogue.save
    dialogue
  end
end
