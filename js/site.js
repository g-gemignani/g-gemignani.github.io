/*!
 * Site behavior. Replaces jQuery, Bootstrap 3 JavaScript, wow.js, easing,
 * and fittext. Smooth scrolling and the header type scale are now CSS.
 */
(function () {
  'use strict';

  var toggle = document.querySelector('.navbar-toggle');
  var menu = document.querySelector('.navbar-collapse');

  function setMenu(open) {
    menu.classList.toggle('in', open);
    toggle.classList.toggle('collapsed', !open);
    toggle.setAttribute('aria-expanded', String(open));
  }

  if (toggle && menu) {
    // Bootstrap 3 CSS shows the menu on ".collapse.in", so the class is the
    // whole mechanism.
    toggle.addEventListener('click', function () {
      setMenu(!menu.classList.contains('in'));
    });

    menu.addEventListener('click', function (event) {
      if (event.target.closest('a')) {
        setMenu(false);
      }
    });
  }

  // Mark the nav entry of the section in the middle of the viewport.
  // Replaces Bootstrap scrollspy.
  if (!('IntersectionObserver' in window)) {
    return;
  }

  var pairs = [];
  Array.prototype.forEach.call(
    document.querySelectorAll('.navbar-nav a[href*="#"]'),
    function (link) {
      var id = link.getAttribute('href').split('#')[1];
      var section = id && document.getElementById(id);
      if (section) {
        pairs.push({ link: link, section: section });
      }
    }
  );

  if (!pairs.length) {
    return;
  }

  var observer = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        pairs.forEach(function (pair) {
          if (pair.section === entry.target) {
            pair.link.parentNode.classList.toggle('active', entry.isIntersecting);
          }
        });
      });
    },
    { rootMargin: '-50% 0px -50% 0px' }
  );

  pairs.forEach(function (pair) {
    observer.observe(pair.section);
  });
})();
