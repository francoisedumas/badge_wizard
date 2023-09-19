import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "icon", "logo", "link", "other"]

  connect() {
    const expandedState = sessionStorage.getItem("sidebarExpanded");
    if (expandedState === "1") {
      this.expand();
    } else {
      this.collapse();
    }

    if ( window.innerWidth < 768) {
      // Make sure there is no padding-left style
      const nextSibling = this.containerTarget.parentElement.nextElementSibling;
      nextSibling.style.removeProperty("padding-left");
    }
  }

  saveStateToLocalStorage(expanded) {
    sessionStorage.setItem("sidebarExpanded", expanded ? "1" : "0");
  }

  toggle() {
    if (this.isExpanded()) {
      this.collapse();
    } else {
      this.expand();
    }
    this.saveStateToLocalStorage(this.isExpanded());
  }

  isExpanded() {
    return this.containerTarget.dataset.expanded === "1";
  }

  applyStyles(expanded) {
    this.containerTarget.classList.toggle("md:w-64", expanded);
    this.togglePaddingLeft(expanded);
    this.logoTarget.classList.toggle("flex-col", !expanded);
    this.logoTarget.firstChild.classList.toggle("h-16", expanded);
    this.logoTarget.firstChild.classList.toggle("h-10", !expanded);
    this.iconTarget.classList.toggle("justify-start", !expanded);
    this.iconTarget.classList.toggle("justify-end", expanded);
    if (expanded) {
      this.iconTarget.innerHTML = `
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
        </svg>
      `;
    } else {
      this.iconTarget.innerHTML = `
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7" />
        </svg>
      `
    }
    this.linkTargets.forEach((link) => {
      link.classList.toggle("sr-only", !expanded);
      link.parentElement.classList.toggle("justify-center", !expanded);
    });
    this.otherTargets.forEach((other) => {
      other.classList.toggle("hidden", !expanded);
    });
  }

  collapse() {
    this.containerTarget.dataset.expanded = "0";
    this.applyStyles(false);
  }

  expand() {
    this.containerTarget.dataset.expanded = "1";
    this.applyStyles(true);
  }

  // solve issue with the md:pl-64
  togglePaddingLeft(expanded) {
    if (expanded) {
      // Remove padding-left: 88px; from the style attribute
      this.containerTarget.parentElement.nextElementSibling.style.removeProperty("padding-left");
    } else {
      // Add padding-left: 88px; to the style attribute
      this.containerTarget.parentElement.nextElementSibling.style.setProperty("padding-left", "88px");
    }
  }
}
