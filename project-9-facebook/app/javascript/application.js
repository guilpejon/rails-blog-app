// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'bootstrap'

document.addEventListener('turbo:load', (_e) => {
  var dropdownToggle = document.querySelector('.dropdown-toggle');
  if (dropdownToggle) {
    dropdownToggle.addEventListener('click', function() {
      var dropdownMenu = dropdownToggle.parentNode.querySelector('.dropdown-menu');
      dropdownMenu.classList.toggle('show');
    });
  }
})
