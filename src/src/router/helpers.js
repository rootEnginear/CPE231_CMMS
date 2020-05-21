function getView(view) {
  return () => import(/* webpackChunkName: "[request]" */ `../views${view}.vue`);
}

export function r(route_name, path, options) {
  return {
    path: path || `/${route_name.toLowerCase()}`,
    name: route_name,
    component: getView(`${options?.dir || ""}/${options?.component || route_name}`),
    meta: {
      ...(options?.meta || {}),
      title: options?.title || route_name
    }
  };
}
