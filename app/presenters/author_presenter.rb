class AuthorPresenter < BasePresenter

  presents :author

  def link(class_name: "")
    h.link_to fullname, author, class: class_name
  end

  def bio
    h.simple_format(author.biography)
  end

  def fullname
    "#{author.firstname} #{author.lastname}"
  end

  def books
    author.books.includes(:categories)
  end

  def short_bio
    bio = author.biography[1..120].strip
    bio += '...' if author.biography.length > 120

    bio
  end

  def add_review_btn
    classes = 'btn-floating btn-large waves-effect waves-light right'

    h.content_tag(:a, icon("add"), href: h.new_author_rating_path(author), class: classes) if h.can? :new, Rating
  end

  def ratings
    author.ratings.accessible_by(h.current_ability).includes(:item)
  end
end