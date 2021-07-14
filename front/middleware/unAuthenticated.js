export default function({ store, route, redirect }) {
  if (
    !store.getters['authentication/isLoggedIn'] &&
    (route.fullPath === '/item/create' ||
      route.fullPath === '/users/setting' ||
      route.fullPath === `/item/edit/${route.params.id}`)
  ) {
    return redirect('/users/login')
  }
}
