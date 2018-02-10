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
        $("#show_title").val(data.title);
        $("#show_description").val(data.description);
        $("#creator_name").val(data.creator_name);
        data.episodes.forEach(function (story) {
          $("#stories").append("<li class='episode'>" + story.title + "</li>");
        })
      }
    });
  });
});
