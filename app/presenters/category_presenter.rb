class CategoryPresenter < BasePresenter
  attr_reader :max_columns

  presents :category

  def initialize(*args)
    @max_columns = 3
    super *args
  end

  def column(number)
    h.render "column", locals: { books: column_books(number) }
  end

  def link(class_name: "")
    h.link_to category.title, category, class: class_name
  end

private

  def column_books(number)
    inx = 1
    category.books.select do |val|
      inx = 1 if inx > @max_columns

      res = inx == number
      inx += 1

      res
    end
  end
end