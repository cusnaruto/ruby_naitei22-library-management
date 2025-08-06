document.addEventListener('turbo:load', function () {
  document.querySelectorAll('.dropdown-toggle').forEach(function (toggle) {
    toggle.addEventListener('click', function (event) {
      event.preventDefault();

      // Toggle dropdown của chính nút được click
      let menu = this.nextElementSibling;

      // Đóng tất cả dropdown khác
      document.querySelectorAll('.dropdown-menu').forEach(function (otherMenu) {
        if (otherMenu !== menu) {
          otherMenu.classList.remove('active');
        }
      });

      // Toggle dropdown tương ứng
      menu.classList.toggle('active');
    });
  });

  // Tắt dropdown nếu click ngoài
  document.addEventListener('click', function (event) {
    if (!event.target.closest('.dropdown')) {
      document.querySelectorAll('.dropdown-menu').forEach(function (menu) {
        menu.classList.remove('active');
      });
    }
  });
});
