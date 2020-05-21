<template>
  <b-navbar wrapper-class="container" type="is-primary">
    <template slot="start">
      <b-navbar-item href="/"
        ><i class="fa fa-home"></i
        ><span style="margin-left:.5ch">หน้าหลัก</span></b-navbar-item
      >
      <b-navbar-item href="/statistics"
        ><i class="fa fa-chart-bar"></i
        ><span style="margin-left:.5ch">สถิติการซ่อม</span></b-navbar-item
      >
    </template>
  </b-navbar>
</template>

<script>
export default {
  name: "AppNavbar"
};
</script>