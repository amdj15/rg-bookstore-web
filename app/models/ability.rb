class Ability
  include CanCan::Ability

  def initialize(customer)
    can :all, Book
    can :read, Book
    can :read, Category
    can :read, Author

    can :read, Rating, approved: true

    if customer
      can :review, Book
      can :create_review, Book

      can :destroy, Rating do |rating|
        rating.customer == customer
      end
    end
  end
end
