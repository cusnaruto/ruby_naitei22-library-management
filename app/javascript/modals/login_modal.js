document.addEventListener("DOMContentLoaded", function () {
  const isLoggedIn = document.body.dataset.loggedIn === "true";
  const loginModalElement = document.getElementById("loginModal");
  const loginModal = loginModalElement ? new bootstrap.Modal(loginModalElement) : null;

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".add_to_favorite_button, .borrow_button, .write_a_review_button");
    if (btn && !isLoggedIn && loginModal) {
      e.preventDefault();
      loginModal.show();
    }
  });
});
