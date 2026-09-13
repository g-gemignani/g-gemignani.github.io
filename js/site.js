/*!
 * Site behavior. Replaces jQuery, Bootstrap 3 JavaScript, wow.js, easing,
 * and fittext. Smooth scrolling and the header type scale are now CSS.
 */
(function () {
  'use strict';

  // Tell the CSS that scripting is on. Without this class the elements that
  // animate in stay visible.
  document.documentElement.classList.add('js');

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

  if (!('IntersectionObserver' in window)) {
    return;
  }

  // Play the bounce when an element scrolls into view. Replaces wow.js.
  var reveal = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          reveal.unobserve(entry.target);
        }
      });
    },
    { rootMargin: '0px 0px -10% 0px' }
  );

  Array.prototype.forEach.call(
    document.querySelectorAll('.animate-on-view'),
    function (el) {
      reveal.observe(el);
    }
  );

  // Mark the nav entry of the section in the middle of the viewport.
  // Replaces Bootstrap scrollspy.

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
