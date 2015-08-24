class BookPresenter < BasePresenter
  presents :book

  def short_info
    info = build_info

    if info.blank?
      h.t(:no_description_yet).capitalize
    else
      info
    end
  end

  def image(class_name: "")
    h.image_tag book.picture_url, class: class_name if book.picture?
  end

  def link(category = nil)
    category = book.categories[0] unless category
    h.link_to book.title, [category, book]
  end

  def descr_format
    h.simple_format(book.description)
  end

  def add_review_btn(category)
    classes = 'btn-floating btn-large waves-effect waves-light right'

    h.content_tag(:a, icon("add"), href: h.new_category_book_rating_path(category, book), class: classes) if h.can? :new, Rating
  end

  def ratings
    book.ratings.accessible_by(h.current_ability).includes(:item)
  end

private

  def add_dots(text, origin)
    text += '...' if origin.length > 120
    text
  end

  def build_info
    unless book.short_descr.blank?
      add_dots(book.short_descr[1..120], book.short_descr)
    else
      add_dots(book.description[1..120], book.description)
    end
  end
end