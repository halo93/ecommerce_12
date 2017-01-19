$(document).on('turbolinks:load', function() {
  const ipt_name = $('#q_name_cont');
  const price_gt = $('#q_price_gteq');
  const price_lt = $('#q_price_lteq');
  const url_path = $('form').attr('action');
  const list_pro = $('#list');

  function execute_filter(name, from, to){
    $.get(url_path, $('form').serialize(),
      function(data, status) {
        list_pro.html(data);
    }, 'html');
  }

  ipt_name.on('change', function(){
    var ipt_name = $(this).val();
    price_gt.on('change', function(){
      var price_gt = $(this).val();
      price_lt.on('change', function(){
        var price_lt = $(this).val();
        execute_filter(ipt_name,price_gt,price_lt);
    });
    });
  });
});
