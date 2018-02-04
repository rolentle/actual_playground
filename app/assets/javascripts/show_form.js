$(document).ready(function () {
  $('#rss_upload').click(function(event) {
    event.preventDefault();
    const rssUrl = $('#rss_feed').val();
    $.ajax({
      type: 'POST',
      url: '/api/v1/rss_feed_converter',
      data: { 'rss_feed': { url: rssUrl } },
      dataType: 'json',
      success: function(data) {
        data.forEach(function (story) {
          $("#stories").append("<li class='episode'>" + story.title + "</li>");
        })
      }
    });
  });
});
