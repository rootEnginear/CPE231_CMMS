<template>
  <div id="app" style="padding-bottom:3rem">
    <AppHeader />
    <router-view />
  </div>
</template>

<script>
import AppHeader from "@/components/AppHeader.vue";

export default {
  name: "App",
  components: {
    AppHeader
  }
};
</script>

<style lang="scss">
@import "~bulma/sass/utilities/_all";

$primary: #e65722;
$primary-invert: findColorInvert($primary);
$family-primary: "Sarabun", $family-sans-serif;
$family-secondary: $family-primary;

$colors: (
  "white": (
    $white,
    $black
  ),
  "black": (
    $black,
    $white
  ),
  "light": (
    $light,
    $light-invert
  ),
  "dark": (
    $dark,
    $dark-invert
  ),
  "primary": (
    $primary,
    $primary-invert
  ),
  "info": (
    $info,
    $info-invert
  ),
  "success": (
    $success,
    $success-invert
  ),
  "warning": (
    $warning,
    $warning-invert
  ),
  "danger": (
    $danger,
    $danger-invert
  )
);

// Links
$link: $primary;
$link-invert: $primary-invert;
$link-focus-border: $primary;

// Import Bulma and Buefy styles
@import "~bulma";
@import "~buefy/src/scss/buefy";

// Change default bulma classes
@media screen and (max-width: 1023px) {
  .container {
    margin: 0 1.25rem;
    .navbar > & {
      margin: 0 auto;
    }
  }
}

// Custom classes
body {
  min-height: 100vh;
}

hr {
  margin-top: 1.25rem;
  margin-bottom: 0.75rem;
}

input::placeholder,
textarea::placeholder {
  transition: padding-left 0.3s;
}

input:focus::placeholder,
textarea:focus::placeholder {
  padding-left: 0.5ch;
}

.table-responsive {
  overflow: auto visible;
  border: 1px dashed #dbdbdb;
}

.spacer {
  height: 0.75rem;
  &.is-2x {
    height: 1.25rem;
  }
}

@media print {
  .is-hidden-print {
    display: none !important;
  }
}
</style>


