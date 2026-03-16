SimpleForm.setup do |config|
  config.wrappers :default, tag: "div", class: "mb-4" do |b|
    b.use :html5
    b.use :placeholder

    b.use :label, class: "block text-sm font-medium text-gray-700 mb-1"

    b.use :input, class: "mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm"

    b.use :error, wrap_with: { tag: "p", class: "text-red-500 text-sm mt-1" }

    b.use :hint, wrap_with: { tag: "p", class: "text-gray-500 text-sm mt-1" }
  end

  config.default_wrapper = :default

  config.boolean_style = :nested

  config.button_class = "bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"

  config.error_notification_tag = :div

  config.error_notification_class = "bg-red-100 text-red-700 p-3 rounded mb-4"

  config.browser_validations = false

  config.boolean_label_class = 'checkbox'
end
