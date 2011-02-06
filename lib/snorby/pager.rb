module Snorby
  class Pager < WillPaginate::ViewHelpers::LinkRenderer

    protected

      def pagination
        items = @options[:page_links] ? windowed_page_numbers : []
        items.unshift :first_page, :previous_page
        items.push :next_page, :last_page
        #[ :first_page, :previous_page, items, total_pages, :next_page, :last_page ]
      end
      
      def page_number(page)
        unless page == current_page
          tag(:li, link(page, page, :rel => rel_value(page)))
        else
          tag(:li, page, :class => "page active")
        end
      end

      def gap
        tag(:li, "...", :class => "more")
      end

      def previous_page
        tag(:li, link("Previous", current_page - 1), :class => "previous") unless current_page == 1
      end
      
      def next_page
        tag(:li, link("Next", current_page + 1), :class => "next") unless current_page == total_pages
      end

      def first_page
        tag(:li, link("First", 1), :class => "first") unless current_page == 1
      end

      def last_page
        tag(:li, link("Last", total_pages), :class => "last") unless current_page == total_pages
      end

      def html_container(html)
        tag(:ul, html, :class => 'pager')
      end

  end
end
