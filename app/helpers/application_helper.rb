module ApplicationHelper
  def search_field(filter, params)
    "<div class='row'>
      <div class='col'>
        <label for='#{filter.name}'>#{filter.name}:</label>
        <input name='search[][parameter_id]' type='hidden' id='parameter_#{filter.id}' value='#{filter.id}'/>
      </div>".html_safe +
    if filter.data_type == 'array'
      select = ''
      select << "<div class='col'><select class='form-control' name='search[][value]' id='parameter_#{filter.id}_value'>"
      select << '<option></option>'
      filter.options.each do |option|
        select << "<option value='#{option}' #{'selected' if option == params[:value] if params}>#{option}</option>"
      end
      select << '</select></div></div>'
      select.html_safe
    else
      case filter.data_type
      when 'decimal', 'integer', 'float'
        "<div class='col'>
          <input class='form-control required' name='search[][value_from]' type='number' id='parameter_#{filter.id}_value_from' value='#{params[:value_from] if params}'/>
        </div>
        <div class='col'>
          <input class='form-control' name='search[][value_to]' type='number' id='parameter_#{filter.id}_value_to' value='#{params[:value_to] if params}'/>
        </div></div>".html_safe
      when 'string'
        "<div class='col'>
          <input class='form-control' name='search[][value]' type='text' id='parameter_#{filter.id}_value' value='#{params[:value] if params}'/>
        </div></div>".html_safe
      when 'boolean'
        "<div class='col'>
          <div class='btn-group btn-group-toggle' data-toggle='buttons'>
            <label class='btn btn-secondary #{'active' if params && params[:value] == 't'}' >
              <input type='radio' name='search[][value]' id='parameter_#{filter.id}_value' value='t'>
              Tak
            </label>
            <label class='btn btn-secondary #{'active' if params && params[:value] == 'f'}'>
              <input type='radio' name='search[][value]' id='parameter_#{filter.id}_value' value='f'>
              Nie
            </label>
          </div>
        </div></div>".html_safe
      end
    end
  end
end
