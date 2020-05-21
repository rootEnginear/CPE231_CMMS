<template>
  <div id="AppHeader">
    <div class="header-bar">
      <div class="container content">
        <div class="header-logo">
          <img
            src="../assets/logo.png"
            alt="Computer Engineering Logo"
            style="max-height:80px"
          />
        </div>
        <h1 class="header-text">Computerized Maintenance Management System</h1>
      </div>
    </div>
    <AppNavbar class="is-hidden-print" />
  </div>
</template>

<script>
import AppNavbar from "./AppNavbar";

export default {
  name: "AppHeader",
  components: {
    AppNavbar
  }
};
</script>

<style lang="scss" scoped>
#AppHeader {
  box-shadow: 0 2px 3px rgba(10, 10, 10, 0.1), 0 0 0 1px rgba(10, 10, 10, 0.1);
}
.header-bar {
  height: 100px;
  background: #fff;
}

.header-bar > .container,
.toolbar > .container {
  display: flex;
  align-items: center;
  height: 100%;
}

.header-bar > .container > .header-text {
  margin: 0;
  margin-left: auto;
  color: #4a4a4a;
  text-align: right;
}
</style>