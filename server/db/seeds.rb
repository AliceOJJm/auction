#  Role.create(:name => :admin)
#  Role.create(:name => :user)

%w( Electronic Transport Property Sport Books Art Others ).each do |category|
  Category.create(name: category)
end
