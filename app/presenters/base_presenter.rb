class BasePresenter < SimpleDelegator

  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def h
    @view
  end

  def icon(name)
    h.content_tag(:i, name, class: "material-icons")
  end

  def self.presents(name)
    define_method(name) do
      @model
    end
  end
end
