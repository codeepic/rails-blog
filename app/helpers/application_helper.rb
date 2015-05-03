module ApplicationHelper
  #creates a submit button with the given name with a cancel link
  #accepts 2 arguments: form object and the canel link name
  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " + link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end
end
