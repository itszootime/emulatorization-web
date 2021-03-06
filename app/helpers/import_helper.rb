module ImportHelper

  def import_button(container_name)
    # Putting the uploadify trigger script in the helper gives us
    # full access to the view and native rails objects without having
    # to set javascript variables.
    #
    # Uploadify is only a queue manager to hand carrierwave the files
    # one at a time. Carrierwave handles capturing, resizing and saving
    # all uploads. All limits set here (file types, size limit) are to
    # help the user pick the right files. Carrierwave is responsible
    # for enforcing the limits (white list file name, setting maximum file sizes)
    #
    # ScriptData:
    #   Sets the http headers to accept javascript plus adds
    #   the session key and authenticity token for XSS protection.
    #   The "FlashSessionCookieMiddleware" rack module deconstructs these
    #   parameters into something Rails will actually use.

    session_key_name = Rails.application.config.session_options[:key]
    url_root_string = ENV['RAILS_RELATIVE_URL_ROOT'] || ''

    %Q{
<script type="text/javascript">

var uploader;

$(function() {

  var button = $('<button id="upload" class="btn btn-info">Import from CSV</button>');

  $('##{container_name}').append(button);

  $('#upload-container').mousedown(function() {
    $('button', this).addClass('active');
  }).mouseup(function() {
    $('button', this).removeClass('active');
  });

  uploader = new plupload.Uploader({
    runtimes            : 'html5,flash,silverlight,html4',
    browse_button       : 'upload',
    drop_element        : 'upload',
    container           : '#{container_name}',
    url                 : '#{uploads_path}',
    max_file_size       : '10mb',
    flash_swf_url       : '#{url_root_string}/plupload/plupload.flash.swf',
    silverlight_xap_url : '#{url_root_string}/plupload/plupload.silverlight.xap',
    headers             : {
      'Accept' : 'text/javascript'
    },
    multipart           : true,
    multipart_params    : {
      '_http_accept'        : 'application/javascript',
      '#{session_key_name}' : encodeURIComponent('#{u(cookies[session_key_name])}'),
      'authenticity_token'  : '#{form_authenticity_token}'
    }
  });

  uploader.init();

  uploader.bind('FilesAdded', function(up, files) {
    uploader.start();
  });

  uploader.bind('Error', function(up, error) {
    alert(error);
  });

});

</script>
    }.strip.html_safe

    # gsub(/[\n ]+/, ' ').
  end
end