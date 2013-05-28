var Disussion = {
    loadComments: function (url, contrinerId) {
        $ = jQuery;
        $('#' + contrinerId).trigger('loading_comments');
        $.ajax({
            url: url,
            dataType: 'script',
            data: {contrinerId: contrinerId},
            type: 'GET'
        }).done(function () {
                $('#' + contrinerId).trigger('loaded_comments');
                console.log($('#' + contrinerId));
            });
    },
    loadThreads: function (url, contrinerId) {
        $ = jQuery;
        $('#' + contrinerId).trigger('loading_threads');
        $.ajax({
            url: url,
            dataType: 'script',
            data: {contrinerId: contrinerId},
            type: 'GET'
        }).done(function () {
                $('#' + contrinerId).trigger('loaded_threads');
                console.log($('#' + contrinerId));
            });
    }
}