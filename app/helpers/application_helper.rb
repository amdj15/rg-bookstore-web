module ApplicationHelper
  def active(path)
    "active" if current_page?(path)
  end

  def present(model)
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)

    yield presenter if block_given?
  end
end
