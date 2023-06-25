module ApplicationHelper
  def flash_class(level)
    return 'alert alert-info' if level == 'notice'
    return 'alert alert-success' if level == 'success'
    return 'alert alert-warning' if level == 'warning'
    return 'alert alert-danger' if level == 'error'

    'alert alert-info'
  end
end
