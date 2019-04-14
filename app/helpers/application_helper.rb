module ApplicationHelper
  def search_field(filter, value)
    "<label for='#{filter.name}'>#{filter.name}:</label>
    <input name='search[][parameter_id]' type='hidden' id='parameter_#{filter.id}' value='#{filter.id}'/>".html_safe +

    if filter.data_type == 'array'
      select = ''
      select << "<select name='search[][value]' id='parameter_#{filter.id}_value'>"
      select << "<option></option>"
      filter.options.each do |option|
        select << "<option value='#{option}' #{'selected' if option == value}>#{option}</option>"
      end
      select << '</select>'
      select.html_safe
    else
      type =
        case filter.data_type
        when 'decimal', 'integer'
          'number'
        when 'string'
          'text'
        else
          'text'
        end
      "<input name='search[][value]' type='#{type}' id='parameter_#{filter.id}_value' value='#{value}'/>".html_safe
    end
  end
end
