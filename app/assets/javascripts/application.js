// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets


//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


// ----------------------jscroll-------------------------
// $(document).on('turbolinks:load', function() {
//   $('.jscroll').jscroll({
//     // 無限に追加する要素は、どこに入れる？
//     contentSelector: '.jscroll',
//     // 次のページにいくためのリンクの場所は？ ＞aタグの指定
//     nextSelector: 'a.next',
//     // 読み込み中の表示はどうする？
//     loadingHtml: '読み込み中'
//   });
// });

$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.scroll-list',
      nextSelector: 'span.next:last a'
    });
  }
});






// ----------------------TOP-------------------------
document.addEventListener("turbolinks:load",function () {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});