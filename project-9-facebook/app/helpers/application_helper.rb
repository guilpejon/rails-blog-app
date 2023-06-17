module ApplicationHelper
  def flash_class(level)
    return 'alert alert-info' if level == 'notice'
    return 'alert alert-success' if level == 'success'
    return 'alert alert-error' if level == 'error'
    return 'alert alert-error' if level == 'error'

    'alert alert-info'
  end
end
