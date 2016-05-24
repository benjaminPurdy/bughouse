function refresh_users_online_list() {
  $.ajax({
    url: "online_users/refresh"
 })
}