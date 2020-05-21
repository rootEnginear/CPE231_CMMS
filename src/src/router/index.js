import Vue from "vue";
import VueRouter from "vue-router";
import { r } from "./helpers";

Vue.use(VueRouter);

// -- Routes --
const routes = [
  r("Home", "/", { title: "หน้าหลัก" }),
  r("UpdateWks", "/works/update/:id", { title: "ข้อมูลการแจ้งซ่อม" }),
  r("Statistics", "/statistics", {
    title: "สถิติการแจ้งและซ่อมแซมเครื่องจักรในแต่ละเดือน",
  }),
];

// -- Initialize --
const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes: routes.concat({
    path: "*",
    redirect: "/",
  }),
});

// -- Middleware --
router.beforeEach((to, from, next) => {
  // Change Title
  const customTitle = to.matched
    .slice()
    .reverse()
    .find((record) => record.meta && record.meta.title);
  document.title = `${customTitle.meta.title} - CMMS`;

  // Etc...
  next();
});

export default router;
