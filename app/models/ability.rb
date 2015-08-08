class Ability
  include CanCan::Ability

  def initialize(customer)
    can :all, Book
    can :read, Book
    can :read, Category
    can :read, Author

    can :read, Rating, approved: true

    if customer
      can [:create, :new], Rating
      can :destroy, Rating, customer_id: customer.id
    end
  end
end
