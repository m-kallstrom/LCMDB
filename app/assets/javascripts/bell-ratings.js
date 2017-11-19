function BellRating() {
  this.init();
};


BellRating.prototype.init = function() {
  this.bells = document.querySelectorAll('.bell-ratings button');
  for (var i = 0; i < this.bells.length; i++) {
    this.bells[i].setAttribute('data-count', i);
    this.bells[i].addEventListener('mouseenter', this.enterBellListener.bind(this));
  }
  document.querySelector('.bell-ratings').addEventListener('mouseleave', this.leaveBellListener.bind(this));
};


BellRating.prototype.enterBellListener = function(e) {
  this.fillBellsUpToElement(e.target);
};


BellRating.prototype.leaveBellListener = function() {
  this.fillBellsUpToElement(null);
};


BellRating.prototype.fillBellsUpToElement = function(el) {

  for (var i = 0; i < this.bells.length; i++) {
    if (el == null || this.bells[i].getAttribute('data-count') > el.getAttribute('data-count')) {
      this.bells[i].classList.remove('hover');
      this.bells[i].classList.remove('fa-bell');
      this.bells[i].classList.add('fa-bell-o');
    } else {
      this.bells[i].classList.remove('fa-bell-o');
      this.bells[i].classList.add('hover');
      this.bells[i].classList.add('fa-bell');
    }
  }
};