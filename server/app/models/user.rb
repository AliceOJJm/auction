# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  gender                 :string(255)
#  avatar_url             :string(255)      default("http://read.me/images/userpic-177.png")
#  birth_date             :date
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  likees_count           :integer          default("0")
#

require 'elasticsearch/model'

class User < ActiveRecord::Base
  include Elasticsearch::Model
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :validatable
         
  before_create :grand_users_abilities
   
  acts_as_liker
   
  has_many :posts, as: :postable
  has_many :pictures
  has_and_belongs_to_many :songs
  has_and_belongs_to_many :videos 
  has_and_belongs_to_many :communities
  has_many :own_communities, class_name: 'Community', foreign_key: :owner_id, dependent: :nullify
    
  has_many :users_roles
  has_many :roles, :through => :users_roles
  
  has_many :subscriptions, foreign_key: :subscriber_id, dependent: :destroy
  has_many :leaders, through: :subscriptions
  has_many :reverse_subscriptions, foreign_key: :leader_id, class_name: 'Subscription', dependent: :destroy
  has_many :subscribers, through: :reverse_subscriptions
  
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_and_belongs_to_many :dialogues
  has_many :messages

  has_many :bids
  
  #searchable do
  #  text :first_name, :last_name, boost: 5.0
  #  text :email
  #end
  
  def self.fulltext_search search_by
    #User.search{fulltext search_by}.results
    response = User.search search_by
    response.results.map{|result| result._source}
  end
  
  def subscribed?(leader)
    leaders.include? leader
  end
  
  def is_friend?(friend)
    friends.include? friend
  end
  
  def subscribe!(leader)
    if leader != self && !subscribed?(leader)
      if leader.subscribed?(self)
        friends << leader
        leader.friends << self
        subscribers.delete leader
        leader.leaders.delete self
      else
        leaders << leader
      end
    end
  end
  
  def unsubscribe!(leader)
    if leader != self
      if subscribed?(leader)
        leaders.delete leader
        leader.subscribers.delete self
      elsif is_friend? leader
        friends.delete leader
        leader.friends.delete self
        leader.subscribe!(self)
        subscription = Subscription.find_by(:leader_id => self.id, :subscriber_id => leader.id)
        subscription.viewed = true
        subscription.save
      end
    end
  end
  
  def send_message (dialogue, message)
    response = Message.new
    dialogue.users.each do |user|
      msg = Message.create(user_id: user.id, sender_id: self.id, text: message)
      if user.id == self.id
        msg.viewed = true
        response = msg
      end
      dialogue.messages << msg
    end
    response ||= "500"
  end
  
  def relations user
    if self == user
      relations = "self"
    elsif self.is_friend? user
      relations = "friend"
    elsif user.subscribed? self
      relations = "leader"
    elsif self.subscribed? user
      relations = "subscriber"
    else
      relations = "none"
    end
    relations
  end
  
  def self.add_names_pics array
    result = Array.new
    array.each do |node|
      if node.user_id
        user = User.find(node.user_id)
      end
      user ||= User.find(node.message.sender_id)
      result << {content: node, user_name: user.first_name + " " + user.last_name, user_pic: user.avatar_url}
    end
    result
  end
  
  def self.add_names_pics_messages array
    result = Array.new
    array.each do |node|
      user = User.find(node.sender_id)
      result << {content: node, user_name: user.first_name + " " + user.last_name, user_pic: user.avatar_url}
    end
    result
  end
  
  private
  
  def grand_users_abilities
    self.roles << Role.find_by_name(:user)  
  end
  
end
