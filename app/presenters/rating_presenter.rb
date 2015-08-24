class RatingPresenter < BasePresenter
  presents :rating

  def stars
    (1..rating.rating).map{|i| icon("stars") }.join.html_safe
  end

  def destroy_btn(*args)
    data = { method: "delete", confirm: h.t(:are_you_sure).capitalize }
    classes = "right waves-effect"

    h.content_tag(:a, icon(:delete), href: remove_path(*args), class: classes, data: data) if h.can? :destroy, rating
  end

private

  def remove_path(*args)
    prefix = case rating.item.class.name.downcase
    when Author.to_s.downcase
      "author"
    when Book.to_s.downcase
      "category_book"
    end

    args = args.concat([rating.item, rating])
    h.send("#{prefix}_rating_path", *args)
  end
end