$(document).ready(function() {
  $('.consumption-chart').on('click', function() {
    var infoText = $(this).attr('info');
    displayInfoBox(infoText);
  });

  $('body').on('click', '.info-box', function() {
    closeInfoBox();
  });
});

function closeInfoBox() {
  $('.info-box').css('display', 'none');
}

function displayInfoBox(infoText) {
  var infoBox = '<div class="info-box">' +
                  '<p>' + infoText + '</p>' +
                '</div>';

  $('body').append(infoBox);
  $('.info-box').css('display', 'block');
}