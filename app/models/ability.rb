class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when :admin
      can :manage, :all
    when :user
      can :read, [Category, Comment, Product, Coupon, User,
        Rate, Order, OrderDetail, Suggest]
      can :create, [Comment, Suggest, Order, OrderDetail, Rate]
      can :update, [Comment, Rate, OrderDetail, User], user_id: user.id
    else
      can :read, [Category, Comment, Product, Coupon, User,
        Rate, Order, OrderDetail, Suggest]
    end
  end
end
