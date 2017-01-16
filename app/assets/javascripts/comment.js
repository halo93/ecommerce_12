$(document).on('turbolinks:load', function() {
  const list_comment = $('#comments');
  const form = $('#new_comment');

  form.submit(function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
      url: form.attr('action'),
      method: form.attr('method'),
      data: form.serialize(),
      dataType: 'html',
      success: function(data, status) {
        list_comment.prepend(data);
        form[0].reset();
      }
    })
  });

  $('body').on('click', '.delete-comment',function(e) {
    e.preventDefault();
    $btn = $(this);
    $id = $(this).attr('href').split('/')[5];
    $comment_id = $('#comment_'+$id);
    $.ajax({
      url: $btn.attr('href'),
      method: 'Delete',
      success: function() {
        $comment_id.remove();
      }
    })
    return false;
  });
});
