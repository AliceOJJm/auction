class Ability
  include CanCan::Ability

  def initialize(user)
     if user
       if user.roles.find_by(:name => 'admin')
         can :manage, :all
       elsif user.roles.find_by(:name => 'user')
         can :read, :all
         can :userpage_media, User
         can :manage, User, :id => user.id
         can :manage, [Dialogue, Message, Song, Video], :user_id => user.id
         can :manage, Post
         can :manage, Subscription
         can :manage, Picture do |picture|
           picture.user_id == user.id || (picture.attachable_type == 'Community' && picture.attachable.owner_id == user.id) || (picture.attachable_type == 'Lot' && picture.attachable.user_id == user.id)
         end
       end
     end
  end
end
