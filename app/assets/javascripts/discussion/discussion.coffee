class Disussion
  @loadComments: (url, contrinerId) ->
    jQuery.ajax({
      url: url,
      dataType: 'script',
      data: {contrinerId: contrinerId},
      type: 'GET'
    });

@Disussion = Disussion