
$(document).on('click','.toggleInput',function(){
  $('.todoInput').slideToggle(300);
});

$(document).on('click','li',function(){
  $(this).toggleClass('clicked');
  $(this).toggleClass('hoverEffect');
});

$(document).on('click','.delete',function(){
  event.stopPropagation();
  $(this).parent().fadeOut(500,function(){
    $(this).remove();
  });
});

$(document).on('submit','form', function(){
  let $todoItem = $('.todoInput input').val().trim();
  $('.todoList').append('<li class="todoListItem hoverEffect"><i class="fas fa-trash-alt delete"></i>'+$todoItem+'</li>');
  event.preventDefault();
});
