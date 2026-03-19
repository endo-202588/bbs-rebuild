class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.last_name} #{object.first_name}"
  end

  def role_badge
    classes = {
      "admin" => "text-red-600 bg-red-100",
      "general" => "text-gray-600 bg-gray-100"
    }

    <<~HTML.html_safe
      <span class="inline-block px-2 py-1 text-xs font-semibold rounded #{classes[object.role]}">
        #{object.role_i18n}
      </span>
    HTML
  end
end
