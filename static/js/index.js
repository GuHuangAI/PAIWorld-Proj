document.addEventListener("DOMContentLoaded", () => {
  const leaderboardCards = Array.from(document.querySelectorAll("[data-leaderboard-target]"));
  const leaderboardShowcase = document.querySelector(".leaderboard-showcase");
  const leaderboardPanels = Array.from(document.querySelectorAll("[data-leaderboard-panel]"));

  const showLeaderboard = (name) => {
    if (!leaderboardShowcase) {
      return;
    }

    leaderboardShowcase.classList.add("is-manual");
    leaderboardPanels.forEach((panel) => {
      panel.classList.toggle("is-active", panel.dataset.leaderboardPanel === name);
    });
    leaderboardCards.forEach((card) => {
      card.classList.toggle("is-selected", card.dataset.leaderboardTarget === name);
    });
  };

  leaderboardCards.forEach((card) => {
    card.addEventListener("click", () => showLeaderboard(card.dataset.leaderboardTarget));
    card.addEventListener("keydown", (event) => {
      if (event.key === "Enter" || event.key === " ") {
        event.preventDefault();
        showLeaderboard(card.dataset.leaderboardTarget);
      }
    });
  });

  const loadVideo = (video) => {
    if (video.dataset.loaded === "true" || !video.dataset.src) {
      return;
    }

    const source = document.createElement("source");
    source.src = video.dataset.src;
    source.type = "video/mp4";
    video.appendChild(source);
    video.dataset.loaded = "true";
    video.load();
  };

  const lazyVideos = Array.from(document.querySelectorAll(".lazy-video"));

  if ("IntersectionObserver" in window) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          loadVideo(entry.target);
          observer.unobserve(entry.target);
        }
      });
    }, { rootMargin: "360px 0px" });

    lazyVideos.forEach((video) => observer.observe(video));
  } else {
    lazyVideos.forEach(loadVideo);
  }

  lazyVideos.forEach((video) => {
    video.addEventListener("pointerenter", () => loadVideo(video), { once: true });
    video.addEventListener("focus", () => loadVideo(video), { once: true });
    video.addEventListener("click", () => loadVideo(video), { once: true });
  });
});
