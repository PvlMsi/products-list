class ApplicationController < ActionController::Base
  helper_method :root

  def root
    @root ||= Category.find_by_name('Root')
  end
end
