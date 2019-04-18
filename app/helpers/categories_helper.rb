module CategoriesHelper
  def category_tree(branch)
    content_tag(:table, class: 'table-borderless', style: 'width: 100%') do
      branch.map do |parent, children|
        content_tag(:tr) do
          content_tag(
            :td,
            link_to(parent.name, category_path(parent)),
            class: 'pl-4'
          ) +
          content_tag(
            :td, (
              link_to('Edytuj', edit_category_path(parent), class: 'btn btn-warning') + ' ' +
              link_to('Usuń', parent, class: 'btn btn-danger',
                method: :delete, data: { confirm: 'Czy jesteś pewien?' }
              )
            ),
            class: 'text-right'
          )
        end +
        content_tag(:tr) do
          content_tag(:td, category_tree(children), class: 'pl-4', colspan: 2)
        end
      end.join.html_safe +
      content_tag(:hr)
    end
  end
end
