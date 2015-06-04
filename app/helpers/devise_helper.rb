module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger">
        <div class="row">
            <div class="col-md-12">
                <h4><strong>Please check and correct the following errors: </strong></h4>
                <ul>
                    #{messages}
                </ul>
            </div>
        </div>
    </div>
    HTML

    html.html_safe
  end
end