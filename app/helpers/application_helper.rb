module ApplicationHelper
  def field_errors(model, field)
    return unless model.errors[field].any?

    content_tag(:div, class: 'mt-2 form-error') do
      model.errors[field].join(', ')
    end
  end
end
