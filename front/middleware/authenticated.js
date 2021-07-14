export default function({ store, route, redirect }) {
  if (
    store.getters['authentication/isLoggedIn'] &&
    (route.fullPath === '/item/signup' || route.fullPath === '/users/login')
  ) {
    return redirect('/')
  }
}
